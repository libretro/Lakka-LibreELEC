/*
 * Copyright (c) 2016-2017, NVIDIA CORPORATION. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *  * Neither the name of NVIDIA CORPORATION nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "NvV4l2ElementPlane.h"
#include "NvLogging.h"

#include <cstring>
#include <errno.h>
#include <libv4l2.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include "nvbuf_utils.h"

#define CHECK_V4L2_RETURN(ret, str)              \
    if (ret < 0) {                               \
        PLANE_SYS_ERROR_MSG(str << ": failed");   \
        return -1;                               \
    } else {                                     \
        PLANE_DEBUG_MSG(str << ": success");      \
        return 0;                                \
    }

using namespace std;

NvV4l2ElementPlane::NvV4l2ElementPlane(enum v4l2_buf_type buf_type,
        const char *device_name, int &fd, bool blocking,
        NvElementProfiler &profiler)
    :fd(fd),
     v4l2elem_profiler(profiler),
     comp_name(device_name)
{
    this->buf_type = buf_type;
    this->blocking = blocking;
    is_in_error = 0;
    switch (buf_type)
    {
        case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
            plane_name = "Output Plane";
            break;
        case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
            plane_name = "Capture Plane";
            break;
        default:
            ERROR_MSG("Unsupported v4l2_buf_type " << buf_type);
            plane_name = "Unknown";
            is_in_error = 1;
    }

    num_buffers = 0;
    buffers = NULL;

    n_planes = 0;
    memset(&planefmts, 0, sizeof(planefmts));

    num_queued_buffers = 0;
    total_queued_buffers = 0;
    total_dequeued_buffers = 0;

    streamon = false;
    pthread_mutex_init(&plane_lock, NULL);
    pthread_cond_init(&plane_cond, NULL);

    dqthread_running = false;
    stop_dqthread = false;
    dq_thread = 0;
    callback = NULL;

    memory_type = V4L2_MEMORY_MMAP;

    dqThread_data = NULL;
}

NvV4l2ElementPlane::~NvV4l2ElementPlane()
{
    pthread_mutex_destroy(&plane_lock);
    pthread_cond_destroy(&plane_cond);
}

NvBuffer *
NvV4l2ElementPlane::getNthBuffer(uint32_t n)
{
    if (n >= num_buffers)
    {
        PLANE_DEBUG_MSG("WARNING:Requested " << n << "th buffer out of " <<
                num_buffers << "buffers. Returning NULL");
        return NULL;
    }
    return buffers[n];
}

int
NvV4l2ElementPlane::dqBuffer(struct v4l2_buffer &v4l2_buf, NvBuffer ** buffer,
        NvBuffer ** shared_buffer, uint32_t num_retries)
{
    int ret;

    v4l2_buf.type = buf_type;
    v4l2_buf.memory = memory_type;
    do
    {
        ret = v4l2_ioctl(fd, VIDIOC_DQBUF, &v4l2_buf);

        if (ret == 0)
        {
            pthread_mutex_lock(&plane_lock);
            if (buffer)
                *buffer = buffers[v4l2_buf.index];
            if (shared_buffer && memory_type == V4L2_MEMORY_DMABUF)
            {
                *shared_buffer =
                    (NvBuffer *) buffers[v4l2_buf.index]->shared_buffer;
            }
            for (uint32_t i = 0; i < buffers[v4l2_buf.index]->n_planes; i++)
            {
                buffers[v4l2_buf.index]->planes[i].bytesused =
                    v4l2_buf.m.planes[i].bytesused;
            }

            if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
            {
                v4l2elem_profiler.finishProcessing(0, false);
            }

            total_dequeued_buffers++;
            num_queued_buffers--;
            pthread_cond_broadcast(&plane_cond);
            PLANE_DEBUG_MSG("DQed buffer " << v4l2_buf.index);
            pthread_mutex_unlock(&plane_lock);
        }
        else if (errno == EAGAIN)
        {
            pthread_mutex_lock(&plane_lock);
            if (v4l2_buf.flags & V4L2_BUF_FLAG_LAST)
            {
                pthread_mutex_unlock(&plane_lock);
                break;
            }
            pthread_mutex_unlock(&plane_lock);

            if (num_retries-- == 0)
            {
                PLANE_WARN_MSG("Error while DQing buffer: Resource temporarily unavailable");
                break;
            }
            if (!blocking)
            {
                break;
            }
        }
        else
        {
            is_in_error = 1;
            PLANE_SYS_ERROR_MSG("Error while DQing buffer");
            break;
        }
    }
    while (ret && !is_in_error);

    return ret;
}

int
NvV4l2ElementPlane::qBuffer(struct v4l2_buffer &v4l2_buf, NvBuffer * shared_buffer)
{
    int ret;
    uint32_t i;
    NvBuffer *buffer;

    pthread_mutex_lock(&plane_lock);
    buffer = buffers[v4l2_buf.index];

    v4l2_buf.type = buf_type;
    v4l2_buf.memory = memory_type;
    v4l2_buf.length = n_planes;

    switch (memory_type)
    {
        case V4L2_MEMORY_USERPTR:
            buffer->shared_buffer = shared_buffer;
            for (i = 0; i < buffer->n_planes; i++)
            {
                if (shared_buffer)
                {
                    v4l2_buf.m.planes[i].m.userptr =
                        (unsigned long) shared_buffer->planes[i].data;
                    v4l2_buf.m.planes[i].bytesused =
                        shared_buffer->planes[i].bytesused;
                }
                else
                {
                    v4l2_buf.m.planes[i].m.userptr =
                        (unsigned long) buffer->planes[i].data;
                    v4l2_buf.m.planes[i].bytesused =
                        buffer->planes[i].bytesused;
                }
            }
            break;
        case V4L2_MEMORY_MMAP:
            for (i = 0; i < buffer->n_planes; i++)
            {
                v4l2_buf.m.planes[i].bytesused = buffer->planes[i].bytesused;
            }
            break;
        case V4L2_MEMORY_DMABUF:
            buffer->shared_buffer = shared_buffer;
            if (shared_buffer)
            {
                for (i = 0; i < buffer->n_planes; i++)
                {
                    v4l2_buf.m.planes[i].m.fd = shared_buffer->planes[i].fd;
                    v4l2_buf.m.planes[i].bytesused =
                        shared_buffer->planes[i].bytesused;
                }
            }
            break;
        default:
            pthread_cond_broadcast(&plane_cond);
            pthread_mutex_unlock(&plane_lock);
            return -1;
    }

    if(buf_type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
    {
        v4l2elem_profiler.startProcessing();
    }

    ret = v4l2_ioctl(fd, VIDIOC_QBUF, &v4l2_buf);
    if (ret)
    {
        is_in_error = 1;
        PLANE_SYS_ERROR_MSG("Error while Qing buffer");
    }
    else
    {
        PLANE_DEBUG_MSG("Qed buffer " << v4l2_buf.index);
        pthread_cond_broadcast(&plane_cond);
        total_queued_buffers++;
        num_queued_buffers++;
    }
    pthread_mutex_unlock(&plane_lock);

    return ret;
}

int
NvV4l2ElementPlane::mapOutputBuffers(struct v4l2_buffer &v4l2_buf, int dmabuff_fd)
{
    int ret;
    uint32_t i;
    NvBufferParams params;
    pthread_mutex_lock(&plane_lock);
    unsigned char *data;

    switch (memory_type)
    {
        case V4L2_MEMORY_DMABUF:
            ret = NvBufferGetParams(dmabuff_fd, &params);
            if(ret < 0)
            {
                PLANE_SYS_ERROR_MSG("Error: NvBufferGetParams Failed\n");
                pthread_mutex_unlock(&plane_lock);
                return ret;
            }
            for (i = 0; i < n_planes; i++)
            {
                buffers[v4l2_buf.index]->planes[i].fd = dmabuff_fd;
                v4l2_buf.m.planes[i].m.fd = buffers[v4l2_buf.index]->planes[i].fd;
                buffers[v4l2_buf.index]->planes[i].mem_offset = params.offset[i];
                ret = NvBufferMemMap (dmabuff_fd,i,NvBufferMem_Read_Write, (void **)&data);
                if (ret < 0)
                {
                    is_in_error = 1;
                    PLANE_SYS_ERROR_MSG("Error while Mapping buffer");
                    pthread_mutex_unlock(&plane_lock);
                    return ret;
                }
                buffers[v4l2_buf.index]->planes[i].data=data;
            }
            break;
        default:
            pthread_mutex_unlock(&plane_lock);
            return -1;
    }
    if(ret == 0)
    {
        PLANE_DEBUG_MSG("Mapped Nvbuffer to buffers " << v4l2_buf.index);
    }
    pthread_mutex_unlock(&plane_lock);

    return ret;
}

int
NvV4l2ElementPlane::unmapOutputBuffers(int index, int dmabuff_fd)
{
    int ret = 0;
    uint32_t i;
    pthread_mutex_lock(&plane_lock);

    switch (memory_type)
    {
        case V4L2_MEMORY_DMABUF:
            for (i = 0; i < n_planes; i++)
            {
                ret = NvBufferMemUnMap (dmabuff_fd, i, (void **)&buffers[index]->planes[i].data);
                if (ret < 0)
                {
                    is_in_error = 1;
                    PLANE_SYS_ERROR_MSG("Error while Unmapping buffer");
                    pthread_mutex_unlock(&plane_lock);
                    return ret;
                }
            }
            break;
        default:
            pthread_mutex_unlock(&plane_lock);
            return -1;
    }
    if(ret == 0)
    {
        PLANE_DEBUG_MSG("Unmapped Nvbuffer to buffers " << index);
    }
    pthread_mutex_unlock(&plane_lock);

    return ret;
}

int
NvV4l2ElementPlane::getFormat(struct v4l2_format &format)
{
    format.type = buf_type;
    CHECK_V4L2_RETURN(v4l2_ioctl(fd, VIDIOC_G_FMT, &format),
            "Getting format");
}

int
NvV4l2ElementPlane::setFormat(struct v4l2_format &format)
{
    int ret;
    int j;

    format.type = buf_type;
    ret = v4l2_ioctl(fd, VIDIOC_S_FMT, &format);
    if (ret)
    {
        PLANE_SYS_ERROR_MSG("Error in VIDIOC_S_FMT");
        is_in_error = 1;
    }
    else
    {
        PLANE_DEBUG_MSG("VIDIOC_S_FMT at capture plane successful");
        n_planes = format.fmt.pix_mp.num_planes;
        for (j = 0; j < n_planes; j++)
        {
            planefmts[j].stride = format.fmt.pix_mp.plane_fmt[j].bytesperline;
            planefmts[j].sizeimage = format.fmt.pix_mp.plane_fmt[j].sizeimage;
        }
    }

    return ret;
}

int
NvV4l2ElementPlane::getCrop(struct v4l2_crop & crop)
{
    crop.type = buf_type;

    CHECK_V4L2_RETURN(v4l2_ioctl(fd, VIDIOC_G_CROP, &crop),
            "Getting crop params");
}

int
NvV4l2ElementPlane::setSelection(uint32_t target, uint32_t flags, struct v4l2_rect & rect)
{
    struct v4l2_selection select;

    switch (buf_type)
    {
        case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
            select.type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
            break;
        case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
            select.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
            break;
        default:
            PLANE_ERROR_MSG("Unsupported v4l2_buf_type " << buf_type);
            return -1;
    }

    select.target = target;
    select.flags = flags;
    select.r = rect;

    CHECK_V4L2_RETURN(v4l2_ioctl(fd, VIDIOC_S_SELECTION, &select),
            "Setting selection");
}

void
NvV4l2ElementPlane::setBufferPlaneFormat(int n_planes,
        NvBuffer::NvBufferPlaneFormat * planefmts)
{
    int i;

    this->n_planes = n_planes;
    for (i = 0; i < n_planes; i++)
    {
        this->planefmts[i] = planefmts[i];
    }
}

void
NvV4l2ElementPlane::deinitPlane()
{
    if (num_buffers > 0)
         return;

    setStreamStatus(false);
    waitForDQThread(-1);
    for (uint32_t i = 0; i < num_buffers; i++)
    {
        switch (memory_type)
        {
            case V4L2_MEMORY_USERPTR:
                buffers[i]->deallocateMemory();
                break;
            case V4L2_MEMORY_MMAP:
                buffers[i]->unmap();
                break;
            case V4L2_MEMORY_DMABUF:
                break;
            default:
                return;
        }
    }
    reqbufs(memory_type, 0);
    PLANE_DEBUG_MSG("deinit successful");
}

int
NvV4l2ElementPlane::reqbufs(enum v4l2_memory mem_type, uint32_t num)
{
    struct v4l2_requestbuffers reqbufs;
    int ret;

    memset(&reqbufs, 0, sizeof(struct v4l2_requestbuffers));
    reqbufs.count = num;
    reqbufs.type = buf_type;
    switch (mem_type)
    {
        case V4L2_MEMORY_USERPTR:
            for (uint32_t i = 0; i < n_planes; i++)
            {
                planefmts[i].stride =
                    planefmts[i].width * planefmts[i].bytesperpixel;
                if(!planefmts[i].sizeimage)
                {
                    planefmts[i].sizeimage =
                        planefmts[i].width * planefmts[i].height;
                }
            }
            break;
        case V4L2_MEMORY_MMAP:
        case V4L2_MEMORY_DMABUF:
            break;
        default:
            PLANE_ERROR_MSG("Error in VIDIOC_REQBUFS:Unknown memory type " <<
                    mem_type);
            return -1;
    }
    memory_type = mem_type;

    reqbufs.memory = mem_type;
    ret = v4l2_ioctl(fd, VIDIOC_REQBUFS, &reqbufs);
    if (ret)
    {
        PLANE_SYS_ERROR_MSG("Error in VIDIOC_REQBUFS at output plane");
        is_in_error = 1;
    }
    else
    {
        if (reqbufs.count)
        {
            buffers = new NvBuffer *[reqbufs.count];
            for (uint32_t i = 0; i < reqbufs.count; i++)
            {
                buffers[i] =
                    new NvBuffer(buf_type, mem_type, n_planes, planefmts, i);
            }
        }
        else
        {
            for (uint32_t i = 0; i < num_buffers; i++)
            {
                delete buffers[i];
            }
            delete[] buffers;
            buffers = NULL;
        }
        num_buffers = reqbufs.count;
        PLANE_DEBUG_MSG("Reqbuf returned " << reqbufs.count << " buffers");
    }

    return ret;
}

int
NvV4l2ElementPlane::setStreamStatus(bool status)
{
    int ret;

    if (status == streamon)
    {
        PLANE_DEBUG_MSG("Already in " << ((status) ? "STREAMON" : "STREAMOFF"));
        return 0;
    }

    pthread_mutex_lock(&plane_lock);
    if (status)
    {
        ret = v4l2_ioctl(fd, VIDIOC_STREAMON, &buf_type);
    }
    else
    {
        ret = v4l2_ioctl(fd, VIDIOC_STREAMOFF, &buf_type);
    }
    if (ret)
    {
        PLANE_SYS_ERROR_MSG("Error in " <<
                ((status) ? "STREAMON" : "STREAMOFF"));
        is_in_error = 1;
    }
    else
    {
        PLANE_DEBUG_MSG(((status) ? "STREAMON" : "STREAMOFF") << " successful");
        streamon = status;
        if (!streamon)
        {
            num_queued_buffers = 0;
            pthread_cond_broadcast(&plane_cond);
        }

        if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
        {
            if (status == false)
            {
                v4l2elem_profiler.disableProfiling();
            }
        }

    }

    pthread_mutex_unlock(&plane_lock);
    return ret;
}

bool
NvV4l2ElementPlane::getStreamStatus()
{
    return streamon;
}

int
NvV4l2ElementPlane::setStreamParms(struct v4l2_streamparm &parm)
{
    int ret;

    parm.type = buf_type;
    ret = v4l2_ioctl(fd, VIDIOC_S_PARM, &parm);

    if(ret == 0)
    {
        PLANE_DEBUG_MSG("Successfully set stream parameters");
    }
    else
    {
        PLANE_SYS_ERROR_MSG("Error while setting stream parameters");
    }
    return ret;
}

int
NvV4l2ElementPlane::queryBuffer(uint32_t i)
{
    struct v4l2_buffer v4l2_buf;
    struct v4l2_plane planes[MAX_PLANES];
    int ret;
    uint32_t j;

    memset(&v4l2_buf, 0, sizeof(struct v4l2_buffer));
    memset(planes, 0, sizeof(planes));
    v4l2_buf.index = i;
    v4l2_buf.type = buf_type;
    v4l2_buf.memory = memory_type;
    v4l2_buf.m.planes = planes;
    v4l2_buf.length = n_planes;

    ret = v4l2_ioctl(fd, VIDIOC_QUERYBUF, &v4l2_buf);
    if (ret)
    {
        PLANE_SYS_ERROR_MSG("Error in QueryBuf for " << i << "th buffer");
        is_in_error = 1;
    }
    else
    {
        PLANE_DEBUG_MSG("QueryBuf for " << i << "th buffer successful");

        for (j = 0; j < v4l2_buf.length; j++)
        {
            buffers[i]->planes[j].length = v4l2_buf.m.planes[j].length;
            buffers[i]->planes[j].mem_offset =
                v4l2_buf.m.planes[j].m.mem_offset;
        }
    }

    return ret;
}

int
NvV4l2ElementPlane::exportBuffer(uint32_t i)
{
    struct v4l2_exportbuffer expbuf;
    int ret;
    int j;

    memset(&expbuf, 0, sizeof(expbuf));
    expbuf.type = buf_type;
    expbuf.index = i;

    for (j = 0; j < n_planes; j++)
    {
        expbuf.plane = j;
        ret = v4l2_ioctl(fd, VIDIOC_EXPBUF, &expbuf);
        if (ret)
        {
            PLANE_SYS_ERROR_MSG("Error in ExportBuf for Buffer " << i <<
                    ", Plane " << j);
            is_in_error = 1;
            return -1;
        }
        else
        {
            PLANE_DEBUG_MSG("ExportBuf successful for Buffer " << i <<
                    ", Plane " << j << ", fd = " << expbuf.fd);
            buffers[i]->planes[j].fd = expbuf.fd;
        }
    }
    return 0;
}

int
NvV4l2ElementPlane::setupPlane(enum v4l2_memory mem_type, uint32_t num_buffers,
        bool map, bool allocate)
{
    uint32_t i;

    if (reqbufs(mem_type, num_buffers))
    {
        goto error;
    }

    for (i = 0; i < this->num_buffers; i++)
    {
        switch (mem_type)
        {
            case V4L2_MEMORY_USERPTR:
                if (allocate)
                {
                    if (buffers[i]->allocateMemory())
                    {
                        goto error;
                    }
                }
                break;
            case V4L2_MEMORY_MMAP:
                if (queryBuffer(i))
                {
                    goto error;
                }
                if (exportBuffer(i))
                {
                    goto error;
                }
                if (map)
                {
                    if (buffers[i]->map())
                    {
                        goto error;
                    }
                }
                break;
            default:
                continue;
        }
    }
    return 0;

error:
    PLANE_ERROR_MSG("Error during setup");
    is_in_error = 1;
    deinitPlane();
    return -1;
}

int
NvV4l2ElementPlane::waitAllBuffersQueued(uint32_t max_wait_ms)
{
    struct timespec timeToWait;
    struct timeval now;
    int return_val = 0;
    int ret;

    gettimeofday(&now, NULL);

    timeToWait.tv_nsec = (now.tv_usec + (max_wait_ms % 1000) * 1000L) * 1000L;
    timeToWait.tv_sec = now.tv_sec + max_wait_ms / 1000 +
        timeToWait.tv_nsec / 1000000000L;
    timeToWait.tv_nsec = timeToWait.tv_nsec % 1000000000L;

    pthread_mutex_lock(&plane_lock);
    while (num_queued_buffers < num_buffers)
    {
        ret = pthread_cond_timedwait(&plane_cond, &plane_lock, &timeToWait);
        if (ret == ETIMEDOUT)
        {
            return_val = -1;
            break;
        }
    }
    pthread_mutex_unlock(&plane_lock);

    CHECK_V4L2_RETURN(return_val, "Waiting for all buffers to get queued");
}

int
NvV4l2ElementPlane::waitAllBuffersDequeued(uint32_t max_wait_ms)
{
    struct timespec timeToWait;
    struct timeval now;
    int return_val = 0;
    int ret;

    gettimeofday(&now, NULL);

    timeToWait.tv_nsec = (now.tv_usec + (max_wait_ms % 1000) * 1000L) * 1000L;
    timeToWait.tv_sec = now.tv_sec + max_wait_ms / 1000 +
        timeToWait.tv_nsec / 1000000000L;
    timeToWait.tv_nsec = timeToWait.tv_nsec % 1000000000L;

    pthread_mutex_lock(&plane_lock);
    while (num_queued_buffers)
    {
        ret = pthread_cond_timedwait(&plane_cond, &plane_lock, &timeToWait);
        if (ret == ETIMEDOUT)
        {
            return_val = -1;
            break;
        }
    }
    pthread_mutex_unlock(&plane_lock);

    CHECK_V4L2_RETURN(return_val, "Waiting for all buffers to get dequeued");
}

bool NvV4l2ElementPlane::setDQThreadCallback(dqThreadCallback callback)
{
    if (dqthread_running)
        return false;
    this->callback = callback;
    return true;
}

void *
NvV4l2ElementPlane::dqThread(void *data)
{
    NvV4l2ElementPlane *plane = (NvV4l2ElementPlane *) data;
    const char *comp_name = plane->comp_name;
    const char *plane_name = plane->plane_name;

    PLANE_DEBUG_MSG("Starting DQthread");
    prctl (PR_SET_NAME, plane_name, 0, 0, 0);
    plane->stop_dqthread = false;
    while (!plane->stop_dqthread)
    {
        struct v4l2_buffer v4l2_buf;
        struct v4l2_plane planes[MAX_PLANES];
        NvBuffer *buffer;
        NvBuffer *shared_buffer;
        bool ret;

        memset(&v4l2_buf, 0, sizeof(v4l2_buf));
        memset(planes, 0, sizeof(planes));
        v4l2_buf.m.planes = planes;
        v4l2_buf.length = plane->n_planes;

        if (plane->dqBuffer(v4l2_buf, &buffer, &shared_buffer, -1) < 0)
        {
            if (errno != EAGAIN)
            {
                plane->is_in_error = 1;
            }
            if (errno != EAGAIN || plane->streamon)
            {
                ret = plane->callback(NULL, NULL, NULL, plane->dqThread_data);
            }
            if (!plane->streamon)
            {
                break;
            }
        }
        else
        {
            ret = plane->callback(&v4l2_buf, buffer, shared_buffer,
                    plane->dqThread_data);
        }
        if (!ret)
        {
            break;
        }
    }
    plane->stop_dqthread = false;

    pthread_mutex_lock(&plane->plane_lock);
    plane->dqthread_running = false;
    pthread_cond_broadcast(&plane->plane_cond);
    pthread_mutex_unlock(&plane->plane_lock);
    PLANE_DEBUG_MSG("Exiting DQthread");
    return NULL;
}

int
NvV4l2ElementPlane::startDQThread(void *data)
{
    pthread_mutex_lock(&plane_lock);
    if (dqthread_running)
    {
        PLANE_DEBUG_MSG("DQ Thread already started");
        pthread_mutex_unlock(&plane_lock);
        return 0;
    }
    dqThread_data = data;
    pthread_create(&dq_thread, NULL, dqThread, this);
    dqthread_running = true;
    pthread_mutex_unlock(&plane_lock);
    PLANE_DEBUG_MSG("Started DQ Thread");
    return 0;
}

int
NvV4l2ElementPlane::stopDQThread()
{
    if (!dqthread_running)
    {
        PLANE_WARN_MSG("DQ Thread is not running");
    }
    if (!dq_thread)
    {
        PLANE_WARN_MSG("DQ Thread already stopped");
        return 0;
    }
    if (blocking)
    {
        PLANE_WARN_MSG("Should not be called in blocking mode");
        return 0;
    }
    stop_dqthread = true;
    pthread_join(dq_thread, NULL);
    dq_thread = 0;
    PLANE_DEBUG_MSG("Stopped DQ Thread");

    return 0;
}

int
NvV4l2ElementPlane::waitForDQThread(uint32_t max_wait_ms)
{
    struct timespec timeToWait;
    struct timeval now;
    int return_val = 0;
    int ret = 0;

    gettimeofday(&now, NULL);

    timeToWait.tv_nsec = (now.tv_usec + (max_wait_ms % 1000) * 1000L) * 1000L;
    timeToWait.tv_sec = now.tv_sec + max_wait_ms / 1000 +
        timeToWait.tv_nsec / 1000000000L;
    timeToWait.tv_nsec = timeToWait.tv_nsec % 1000000000L;

    pthread_mutex_lock(&plane_lock);
    if (!dq_thread)
    {
        pthread_mutex_unlock(&plane_lock);
        PLANE_WARN_MSG("DQ Thread already stopped");
        return return_val;
    }
    while (dqthread_running)
    {
        ret = pthread_cond_timedwait(&plane_cond, &plane_lock, &timeToWait);
        if (ret == ETIMEDOUT)
        {
            return_val = -1;
            break;
        }
    }
    pthread_mutex_unlock(&plane_lock);

    if (ret == 0)
    {
        pthread_join(dq_thread, NULL);
        dq_thread = 0;
        PLANE_DEBUG_MSG("Stopped DQ Thread");
    }
    else
    {
        PLANE_ERROR_MSG("Timed out waiting for dqthread");
    }
    return return_val;
}
