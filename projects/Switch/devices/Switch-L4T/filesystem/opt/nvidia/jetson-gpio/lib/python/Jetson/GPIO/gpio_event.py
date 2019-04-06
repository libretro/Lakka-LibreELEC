# Copyright (c) 2012-2017 Ben Croston <ben@croston.org>.
# Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

# Python2 has module thread. Renamed to _thread in Python3
try:
    import thread
except:
    import _thread as thread

from select import epoll, EPOLLIN, EPOLLET, EPOLLPRI
from datetime import datetime

try:
    InterruptedError = InterruptedError
except:
    InterruptedError = IOError

# sysfs root
ROOT = "/sys/class/gpio"

# Edge possibilities
NO_EDGE = 0
RISING_EDGE = 1
FALLING_EDGE = 2
BOTH_EDGE = 3

# epoll thread object
_epoll_fd_thread = None

# epoll blocking wait object
_epoll_fd_blocking = None

# dictionary of GPIO class objects. key = gpio number,
# value = GPIO class object
_gpio_event_list = {}

# variable to keep track of thread state
_thread_running = False

# string representations for edges to write to sysfs
_edge_str = ["none", "rising", "falling", "both"]

# lock object for thread
_mutex = thread.allocate_lock()

class _Gpios:

    def __init__(self, gpio, edge=None, bouncetime=None):
        self.edge = edge
        self.value_fd = open(ROOT + "/gpio%i" % gpio + "/value", 'r')
        self.initial_thread = True
        self.initial_wait = True
        self.thread_added = False
        self.bouncetime = bouncetime
        self.gpio = gpio
        self.callbacks = []
        self.lastcall = 0
        self.event_occurred = False

    def __del__(self):
        self.value_fd.close()
        del self.callbacks

def add_edge_detect(gpio, edge, bouncetime):
    global _epoll_fd_thread
    gpios = None
    res = gpio_event_added(gpio)

    # event not added
    if not res:
        gpios = _Gpios(gpio, edge, bouncetime)
        _set_edge(gpio, edge)

    # event already added
    elif res == edge:
        gpios = _get_gpio_object(gpio)
        if ((bouncetime is not None and gpios.bouncetime != bouncetime) or
                gpios.thread_added):
            return 1
    else:
        return 1
    # create epoll object for fd if not already open
    if _epoll_fd_thread is None:
        _epoll_fd_thread = epoll()
        if _epoll_fd_thread is None:
            return 2

    # add eventmask and fd to epoll object
    try:
        _epoll_fd_thread.register(gpios.value_fd, EPOLLIN | EPOLLET | EPOLLPRI)
    except IOError:
        remove_edge_detect(gpio)
        return 2

    gpios.thread_added = 1
    _gpio_event_list[gpio] = gpios

    # create and start poll thread if not already running
    if not _thread_running:
        try:
            thread.start_new_thread(_poll_thread, ())
        except RuntimeError:
            remove_edge_detect(gpio)
            return 2
    return 0

def remove_edge_detect(gpio):
    if gpio not in _gpio_event_list:
        return

    if _epoll_fd_thread is not None:
        _epoll_fd_thread.unregister(_gpio_event_list[gpio].value_fd)

    _set_edge(gpio, NO_EDGE)

    _mutex.acquire()
    del _gpio_event_list[gpio]
    _mutex.release()

def add_edge_callback(gpio, callback):
    if gpio not in _gpio_event_list or not _gpio_event_list[gpio].thread_added:
        return

    _gpio_event_list[gpio].callbacks.append(callback)

def edge_event_detected(gpio):
    retval = False
    if gpio in _gpio_event_list:
        _mutex.acquire()
        if _gpio_event_list[gpio].event_occurred:
            _gpio_event_list[gpio].event_occurred = False
            retval =  True
        _mutex.release()
        return retval

def gpio_event_added(gpio):
    if gpio not in _gpio_event_list:
        return NO_EDGE

    return _gpio_event_list[gpio].edge

def _get_gpio_object(gpio):
    if gpio not in _gpio_event_list:
        return None
    return _gpio_event_list[gpio]

def _set_edge(gpio, edge):
    edge_path = ROOT + "/gpio%i" % gpio + "/edge"

    with open(edge_path, 'w') as edge_file:
        edge_file.write(_edge_str[edge])

def _get_gpio_obj_key(fd):
    for key in _gpio_event_list:
        if _gpio_event_list[key].value_fd == fd:
            return key
    return None

def _get_gpio_file_object(fileno):
    for key in _gpio_event_list:
        if _gpio_event_list[key].value_fd.fileno() == fileno:
            return _gpio_event_list[key].value_fd
    return None

def _poll_thread():
    global _thread_running

    _thread_running = True
    while _thread_running:
        try:
            events = _epoll_fd_thread.poll(maxevents=1)
            fd = events[0][0]
            _mutex.acquire()

            # check if file object has been deleted or closed from main thread
            fd = _get_gpio_file_object(fd)
            if fd is None or fd.closed:
                _mutex.release()
                continue

            # read file to make sure event is valid
            fd.seek(0)
            if len(fd.read().rstrip()) != 1:
                _thread_running = False
                _mutex.release()
                thread.exit()

            # check key to make sure gpio object has not been deleted
            # from main thread
            key = _get_gpio_obj_key(fd)
            if key is None:
                _mutex.release()
                continue

            gpio_obj = _gpio_event_list[key]

            # ignore first epoll trigger
            if gpio_obj.initial_thread:
                gpio_obj.initial_thread = False
                _gpio_event_list[key] = gpio_obj
                _mutex.release()

            else:
                # debounce the input event for the specified bouncetime
                time = datetime.now()
                time = time.second * 1E6 + time.microsecond
                if (gpio_obj.bouncetime is None or
                        (time - gpio_obj.lastcall > gpio_obj.bouncetime * 1000) or
                        (gpio_obj.lastcall == 0) or gpio_obj.lastcall > time):
                    gpio_obj.lastcall = time
                    gpio_obj.event_occurred = True
                    _gpio_event_list[key] = gpio_obj
                    _mutex.release()
                    for cb_func in gpio_obj.callbacks:
                        cb_func()

        # if interrupted by a signal, continue to start of the loop
        except InterruptedError:
            if _mutex.locked():
                _mutex.release()
            continue
        except AttributeError:
            break
    thread.exit()

def blocking_wait_for_edge(gpio, edge, bouncetime, timeout):
    global _epoll_fd_blocking
    gpio_obj = None
    finished = False
    res = None
    initial_edge = True

    if timeout is None:
        timeout = -1
    else:
        timeout = float(timeout) / 1000

    if gpio in _gpio_event_list:
        if _gpio_event_list[gpio].callbacks:
            return -1

    # check if gpio edge already added. Add if not already added
    added_edge = gpio_event_added(gpio)

    # get existing record
    if added_edge == edge:
        gpio_obj = _get_gpio_object(gpio)
        if (gpio_obj.bouncetime is not None and
                gpio_obj.bouncetime != bouncetime):
            return -1

    # not added. create new record
    elif added_edge == NO_EDGE:
        gpio_obj = _Gpios(gpio, edge, bouncetime)
        _set_edge(gpio, edge)
        _gpio_event_list[gpio] = gpio_obj

    # added_edge != edge. Event is for different edge
    else:
        _mutex.acquire()
        gpio_obj = _get_gpio_object(gpio)
        _set_edge(gpio, edge)
        gpio_obj.edge = edge
        gpio_obj.bouncetime = bouncetime
        gpio_obj.initial_wait = True
        _gpio_event_list[gpio] = gpio_obj
        _mutex.release()

    # create epoll blocking object if not already created
    if _epoll_fd_blocking is None:
        _epoll_fd_blocking = epoll()
        if _epoll_fd_blocking is None:
            return -2

    # register gpio value fd with epoll
    try:
        _epoll_fd_blocking.register(gpio_obj.value_fd, EPOLLIN | EPOLLET |
                                    EPOLLPRI)
    except IOError:
        print("IOError occured while register epoll blocking for GPIO %s"
              % gpio)
        return -2

    while not finished:
        # retry polling if interrupted by signal
        try:
            res = _epoll_fd_blocking.poll(timeout, maxevents=1)
        except InterruptedError:
            continue

        # First trigger is with current state so ignore
        if initial_edge:
            initial_edge = False
            continue

        # debounce input for specified time
        else:
            time = datetime.now()
            time = time.second * 1E6 + time.microsecond
            if ((gpio_obj.bouncetime is None) or
                    (time - gpio_obj.lastcall > gpio_obj.bouncetime * 1000) or
                    (gpio_obj.lastcall == 0) or (gpio_obj.lastcall > time)):
                gpio_obj.lastcall = time
                _mutex.acquire()
                _gpio_event_list[gpio] = gpio_obj
                _mutex.release()
                finished = True

    # check if the event detected was valid
    if res:
        fileno = res[0][0]
        fd = gpio_obj.value_fd
        if fileno != fd.fileno():
            _epoll_fd_blocking.unregister(gpio_obj.value_fd)
            print("File object not found after wait for GPIO %s" % gpio)
            return -2
        else:
            _mutex.acquire()
            fd.seek(0)
            value_str = fd.read().rstrip()
            _mutex.release()
            if len(value_str) != 1:
                _epoll_fd_blocking.unregister(gpio_obj.value_fd)
                print("Length of value string was not 1 for GPIO %s" % gpio)
                return -2

    _epoll_fd_blocking.unregister(gpio_obj.value_fd)

    # 0 if timeout occured - res == []
    # 1 if event was valid
    return int(res != [])

def event_cleanup(gpio=None):
    global _epoll_fd_thread, _epoll_fd_blocking, _thread_running

    _thread_running = False
    if gpio in _gpio_event_list:
        remove_edge_detect(gpio)

    if _gpio_event_list == {}:
        if _epoll_fd_blocking is not None:
            _epoll_fd_blocking.close()
            _epoll_fd_blocking = None

        if _epoll_fd_thread is not None:
            _epoll_fd_thread.close()
            _epoll_fd_thread = None