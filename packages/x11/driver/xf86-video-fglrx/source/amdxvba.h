/*******************************************************************************
*
* Copyright (c) 2011, Advanced Micro Devices, Inc.
* All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following are met:
* 
* Neither the name of the copyright holder nor the names of its
* contributors may be used to endorse or promote products derived from
* this software without specific, prior, written permission.
* 
* You must reproduce the above copyright notice.
* 
* You must include the following terms in your license and/or other
* materials provided with the software.
* 
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
* HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
* LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
* DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
* THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* 
* Without limiting the foregoing, the software may implement third
* party technologies (e.g. third party libraries) for which you must
* obtain licenses from parties other than AMD.  You agree that AMD has
* not obtained or conveyed to you, and that you shall be responsible for
* obtaining the rights to use and/or distribute the applicable underlying
* intellectual property rights related to the third party technologies.
* These third party technologies are not licensed hereunder.
* 
* Without limiting the foregoing, for MPEG-2 products, the following
* additional notices are provided: For MPEG-2 Encoding Products (those
* that are "Sold" to end-users, directly or indirectly):
* 
*     NO LICENSE IS GRANTED HEREIN, BY IMPLICATION OR OTHERWISE,
*     TO YOU OR YOUR CUSTOMERS TO USE MPEG-2 ENCODING PRODUCTS,
*     MPEG-2 DISTRIBUTION ENCODING PRODUCTS, MPEG-2 ENCODING SOFTWARE,
*     AND/OR MPEG-2 BUNDLED ENCODING SOFTWARE FOR ENCODING OR HAVING
*     ENCODED ONE OR MORE MPEG-2 VIDEO EVENTS FOR RECORDING ON AN
*     MPEG-2 PACKAGED MEDIUM FOR ANY USE OR DISTRIBUTION OTHER THAN
*     PERSONAL USE OF LICENSEE'S CUSTOMER.
* 
* For MPEG-2 Intermediate Products (those that are NOT "Sold" to
* end-users, directly or indirectly):
* 
*     NO LICENSE IS GRANTED HEREIN, BY IMPLICATION OR OTHERWISE,
*     TO YOU OR YOUR CUSTOMERS TO USE MPEG-2 INTERMEDIATE PRODUCTS
*     MANUFACTURED OR SOLD BY YOU.
* 
* If you use the software (in whole or in part), you shall adhere to
* all applicable U.S., European, and other export laws, including but
* not limited to the U.S. Export Administration Regulations ("EAR"),
* (15 C.F.R. Sections 730 through 774), and E.U. Council Regulation (EC)
* No 1334/2000 of 22 June 2000.  Further, pursuant to Section 740.6 of
* the EAR, you hereby certify that, except pursuant to a license granted
* by the United States Department of Commerce Bureau of Industry and
* Security or as otherwise permitted pursuant to a License Exception
* under the U.S. Export Administration Regulations ("EAR"), you will
* not (1) export, re-export or release to a national of a country in
* Country Groups D:1, E:1 or E:2 any restricted technology, software,
* or source code you receive hereunder, or (2) export to Country Groups
* D:1, E:1 or E:2 the direct product of such technology or software, if
* such foreign produced direct product is subject to national security
* controls as identified on the Commerce Control List (currently found
* in Supplement 1 to Part 774 of EAR).  For the most current Country
* Group listings, or for additional information about the EAR or your
* obligations under those regulations, please refer to the U.S. Bureau
* of Industry and Security's website at http://www.bis.doc.gov/.
*
*******************************************************************************/

#ifndef _XVBA_H
#define _XVBA_H

// A minor revision change indicates a backward-compatible change; a major revision change indicates a backward-incompatible
#define XVBA_VERSION_MAJOR         0
#define XVBA_VERSION_MINOR         74
#define XVBA_VERSION ((XVBA_VERSION_MAJOR << 16) | XVBA_VERSION_MINOR)

#define NUM_OF_XVBA_DECODE_CAP              3
#define NUM_OF_XVBA_GET_SURFACE_TARGET      3

#ifdef __cplusplus
extern "C" {
#endif

typedef enum _XVBA_SURFACE_FLAG
{
    XVBA_FRAME = 0,
    XVBA_TOP_FIELD,
    XVBA_BOTTOM_FIELD,

} XVBA_SURFACE_FLAG;

/*  Four-character-code (FOURCC) */
#define XVBA_FOURCC(a,b,c,d)\
    (((unsigned int)(a)<<0) |\
    ((unsigned int)(b)<<8) |\
    ((unsigned int)(c)<<16)|\
    ((unsigned int)(d)<<24))

typedef enum _XVBA_SURFACE_FORMAT
{
    XVBA_NV12       = XVBA_FOURCC('N','V','1','2'), /* 12bit  Y/CbCr 4:2:0 planar  */
    XVBA_YUY2       = XVBA_FOURCC('Y','U','Y','2'), /* 16bit  YUV 4:2:2 */
    XVBA_ARGB       = XVBA_FOURCC('A','R','G','B'), /* 32bit  ARGB-8-8-8-8  */
    XVBA_AYUV       = XVBA_FOURCC('A','Y','U','V'), /* 32bit  AYUV-8-8-8-8  */
    XVBA_YV12       = XVBA_FOURCC('Y','V','1','2'), /* 12bit  Y/V/U 4:2:0 planar  */
} XVBA_SURFACE_FORMAT;

typedef struct _XVBA_GetSurface_Target
{
    unsigned int    size;       ///< structure size
    XVBA_SURFACE_FORMAT surfaceType;
    XVBA_SURFACE_FLAG   flag;
} XVBA_GetSurface_Target;

/**
 *  XVBA Query Extension
 */
Bool
XVBAQueryExtension
(
    Display     *display,
    int         *version
);

/******************************************************************/
/*    XVBA Context                                                */
/******************************************************************/

/**
 *  XVBA Context Create
 */
typedef struct
{
    unsigned int    size;       ///< structure size
    Display         *display;
    Drawable        draw;

} XVBA_Create_Context_Input;

typedef struct
{
    unsigned int    size;       ///< structure size
    void            *context;

} XVBA_Create_Context_Output;

Status
XVBACreateContext
(
    XVBA_Create_Context_Input   *create_context_input,
    XVBA_Create_Context_Output  *create_context_output
);

/**
 *  XVBA Context Destroy
 */
Status
XVBADestroyContext
(
    void    *context
);


/******************************************************************/
/*    XVBA Sessions                                                */
/******************************************************************/

/**
 *  XVBA Context Query Session Info
 */
typedef struct
{
    unsigned int    size;       ///< structure size
    void            *context;

} XVBA_GetSessionInfo_Input;

typedef struct
{
    unsigned int    size;                       ///< structure size
    unsigned int    getcapdecode_output_size;   ///< 0 = Decode not supported, NZ = Decode session is supported and the value is used for XVBAGetCapDecode output struct size
    unsigned int    xvba_gsio_reserved_0;
    unsigned int    xvba_gsio_reserved_1;
} XVBA_GetSessionInfo_Output;

Status
XVBAGetSessionInfo
(
    XVBA_GetSessionInfo_Input   *get_session_info_input,
    XVBA_GetSessionInfo_Output  *get_session_info_output
);

/******************************************************************/
/*   XVBA decode errors                                           */
/******************************************************************/

typedef enum
{
    XVBA_DECODE_NO_ERROR = 0,
    XVBA_DECODE_BAD_PICTURE,    ///< the entire picture is corrupted . All MBs are invalid
    XVBA_DECODE_BAD_SLICE,      ///< part of the picture, slice, wasn.t decoded properly . all MBs in this slice are bad
    XVBA_DECODE_BAD_MB          ///< some MBs are not decoded properly

} XVBA_DECODE_ERROR;

typedef struct
{
    unsigned int        size;           ///< structure size
    XVBA_DECODE_ERROR   type;
    unsigned int        num_of_bad_mbs; ///< number of marcoblocks that were not properly decoded

} XVBADecodeError;

/******************************************************************/
/*    XVBA Surface                                               */
/******************************************************************/

/**
 *  XVBA Surface create
 */
typedef struct
{
    unsigned int        size;
    void                *session;
    unsigned int        width;
    unsigned int        height;
    XVBA_SURFACE_FORMAT surface_type;

} XVBA_Create_Surface_Input;

typedef struct
{
    unsigned int    size;
    void            *surface;   ///< Pointer to XVBASurface

} XVBA_Create_Surface_Output;

Status
XVBACreateSurface(
    XVBA_Create_Surface_Input   *create_surface_input,
    XVBA_Create_Surface_Output  *create_surface_output
);

/**
 *  XVBA Surface destroy
 */
Status
XVBADestroySurface(
    void        *surface
);


/**
 *  Synchronization query_status_flags
 */
typedef enum
{
    XVBA_GET_SURFACE_STATUS = 1,    ///< get surface status; is surface still used by GPU
    XVBA_GET_DECODE_ERRORS          ///< get decode errors for target surface

} XVBA_QUERY_STATUS;

/**
 *  Synchronization status flags
 */
#define XVBA_STILL_PENDING      0x00000001 ///< surface is still used by HW
#define XVBA_COMPLETED          0x00000002 ///< HW completed job on this surface
#define XVBA_NO_ERROR_DECODE    0x00000004 ///< no decode errors
#define XVBA_ERROR_DECODE       0x00000008 ///< decode errors for queried surface


/**
 *  XVBA Surface synchronization
 */
typedef struct
{
   unsigned int         size;
   void                 *session;
   void                 *surface;
   XVBA_QUERY_STATUS    query_status;

} XVBA_Surface_Sync_Input;

typedef struct
{
   unsigned int         size;
   unsigned int         status_flags;
   XVBADecodeError      decode_error;

} XVBA_Surface_Sync_Output;

Status
XVBASyncSurface (
    XVBA_Surface_Sync_Input     *surface_sync_input,
    XVBA_Surface_Sync_Output    *surface_sync_output
);


// Conversion from OGL to XVBA surface

typedef struct
{
    unsigned int 	size;
    void            *session;
    void            *glcontext;
    unsigned int    gltexture;

} XVBA_Create_GLShared_Surface_Input;

typedef struct
{
    unsigned int    size;
    void            *surface;	// Pointer to XVBASurface

} XVBA_Create_GLShared_Surface_Output;

Status
XVBACreateGLSharedSurface (
    XVBA_Create_GLShared_Surface_Input  *create_glshared_surface_input,
    XVBA_Create_GLShared_Surface_Output *create_glshared_surface_output
);


/**
 *  XVBA Get Surface
 */
typedef struct {
    unsigned int    size;           ///< structure size
    void            *session;       // XVBA session
    void            *src_surface;   // source XVBA surface
    void            *target_buffer;    // application supplied system memory buffer
    unsigned int    target_pitch;      // pitch of the destination buffer
    unsigned int    target_width;      // width of the destination buffer
    unsigned int    target_height;     // height of the destination buffer
    XVBA_GetSurface_Target target_parameter; // destination buffer format and flag
    unsigned int    reserved [4];   // reserved
} XVBA_Get_Surface_Input;

Status
XVBAGetSurface (
    XVBA_Get_Surface_Input   *get_surface_input
);

/**
 *  XVBA Transfer Surface
 */
typedef struct {
    unsigned int    size;           ///< structure size
    void            *session;       // XVBA session
    void            *src_surface;   // source XVBA surface
    void            *target_surface;   // destination XVBA surface
    XVBA_SURFACE_FLAG    flag;      // top, bottom or frame
    unsigned int    reserved [4];   // reserved
} XVBA_Transfer_Surface_Input;

Status
XVBATransferSurface (
    XVBA_Transfer_Surface_Input   *transfer_surface_input
);

/******************************************************************/
/*    XVBA Buffers                                                */
/******************************************************************/

typedef enum
{
    XVBA_NONE = 0,
    XVBA_PICTURE_DESCRIPTION_BUFFER,
    XVBA_DATA_BUFFER,
    XVBA_DATA_CTRL_BUFFER,
    XVBA_QM_BUFFER

} XVBA_BUFFER;

typedef struct
{
    unsigned int    size;               ///< structure size
    XVBA_BUFFER     buffer_type;
    unsigned int    buffer_size;        ///< allocated size of data in bytes
    void            *bufferXVBA;        ///< pointer to XVBA decode data buffer
    unsigned int    data_size_in_buffer;///< Used in Decode call only
    int             data_offset;        ///< Used in Decode call only
    void            *appPrivate;        ///< used only by application to store pointer to its private data.

} XVBABufferDescriptor;

/**
 *  XVBA Decode buffers create
 */
typedef struct
{
    unsigned int    size;               ///< structure size
    void            *session;
    XVBA_BUFFER     buffer_type;
    unsigned int    num_of_buffers;

} XVBA_Create_DecodeBuff_Input;

typedef struct
{
    unsigned int            size;       ///< structure size
    unsigned int            num_of_buffers_in_list;
    XVBABufferDescriptor    *buffer_list;

} XVBA_Create_DecodeBuff_Output;

Status
XVBACreateDecodeBuffers (
    XVBA_Create_DecodeBuff_Input    *create_decodebuff_input,
    XVBA_Create_DecodeBuff_Output   *create_decodebuff_output
);

/**
 *  XVBA Decode buffers destroy
 */
typedef struct
{
    unsigned int            size;
    void                    *session;
    unsigned int            num_of_buffers_in_list;
    XVBABufferDescriptor    *buffer_list;

} XVBA_Destroy_Decode_Buffers_Input;

Status
XVBADestroyDecodeBuffers (
    XVBA_Destroy_Decode_Buffers_Input *buffer_list
);


/******************************************************************/
/*   XVBA Decode session (XVBADecodeCap)                          */
/******************************************************************/

/**
 *  XVBADecodeCap flags
 */
typedef enum
{
    XVBA_NOFLAG = 0,
    XVBA_H264_BASELINE,
    XVBA_H264_MAIN,
    XVBA_H264_HIGH,

    XVBA_VC1_SIMPLE,
    XVBA_VC1_MAIN,
    XVBA_VC1_ADVANCED,

} XVBA_DECODE_FLAGS;

/**
 *  XVBADecodeCap capability_id
 */
typedef enum
{
    XVBA_H264    = 0x100,///< bitstream level of acceleration
    XVBA_VC1,            ///< bitstream level of acceleration
    XVBA_MPEG2_IDCT,     ///< iDCT and motion compensation level of acceleration
    XVBA_MPEG2_VLD       ///< bitstream level of acceleration

} XVBA_CAPABILITY_ID;

typedef struct {
    unsigned int        size;           ///< structure size
    XVBA_CAPABILITY_ID  capability_id;  ///< Unique descriptor for decode capability
    XVBA_DECODE_FLAGS   flags;          ///< defines for additional information about capability
    XVBA_SURFACE_FORMAT surface_type;   ///< Surface type: fourcc YUV or RGB supported with this capability.
    
} XVBADecodeCap;

/**
 *  XVBADecodeCap Query Info
 */
typedef struct {
    unsigned int    size;       ///< structure size
    void            *context;

} XVBA_GetCapDecode_Input;

typedef struct {
    unsigned int    size;       ///< structure size
    unsigned int    num_of_decodecaps;
    XVBADecodeCap   decode_caps_list[NUM_OF_XVBA_DECODE_CAP];
    unsigned int    num_of_getsurface_target;
    XVBA_GetSurface_Target getsurface_target_list[NUM_OF_XVBA_GET_SURFACE_TARGET];
} XVBA_GetCapDecode_Output;

Status
XVBAGetCapDecode (
    XVBA_GetCapDecode_Input     *decodecap_list_input,
    XVBA_GetCapDecode_Output    *decodecap_list_output
);

/**
 *  XVBADecodeCap create
 */
typedef struct {
   unsigned int         size;           ///< structure size
   unsigned int         width;          ///< decoded video width
   unsigned int         height;         ///< decoded video height
   void                 *context;
   XVBADecodeCap        *decode_cap;    ///< capability from the driver reported list

} XVBA_Create_Decode_Session_Input;

typedef struct {
    unsigned int    size;              ///< structure size
    void            *session;          ///< Pointer to the created decode session

} XVBA_Create_Decode_Session_Output;

Status
XVBACreateDecode (
    XVBA_Create_Decode_Session_Input    *create_decode_session_input,
    XVBA_Create_Decode_Session_Output   *create_decode_session_output
);

/**
 *  XVBADecodeCap destroy
 */
Status
XVBADestroyDecode (
    void *session
);


/******************************************************************/
/*   XVBA Decode API                                              */
/******************************************************************/
#define XVBA_PREDICTION_FIELD       0x01
#define XVBA_PREDICTION_FRAME       0x02
#define XVBA_PREDICTION_DUAL_PRIME  0x03
#define XVBA_PREDICTION_16x8        0x02

#define XVBA_SECOND_FIELD       0x00000004


/**
 *  XVBA inits picture decoding
 */
typedef struct
{
    unsigned int    size;               ///< structure size
    void            *session;           ///< pointer to decode session
    void            *target_surface;    ///< decode target

} XVBA_Decode_Picture_Start_Input;

Status
XVBAStartDecodePicture (
    XVBA_Decode_Picture_Start_Input  *decode_picture_start
);

/**
 *  XVBA picture decode
 */
typedef struct
{
    unsigned int            size;                   ///< structure size
    void                    *session;               ///< pointer to decode session
    unsigned int            num_of_buffers_in_list; ///< number of decode compressed data buffers
    XVBABufferDescriptor    **buffer_list;          ///< array of XVBABufferDescriptor structures

} XVBA_Decode_Picture_Input;

Status
XVBADecodePicture (
    XVBA_Decode_Picture_Input *decode_picture_input
);

/**
 *  XVBA end picture decode
 */
typedef struct
{
    unsigned int    size;
    void            *session;

} XVBA_Decode_Picture_End_Input;

Status
XVBAEndDecodePicture (
    XVBA_Decode_Picture_End_Input *decode_picture_end_input
);

/******************************************************************/
/*   XVBA Decode Data buffers                                     */
/******************************************************************/

/*
 * XVBA compressed data type: XVBA_PICTURE_DESCRIPTOR_BUFFER
 */
typedef struct
{
   //VC-1, MPEG2 bitstream references
    void            *past_surface;
    void            *future_surface;

    unsigned int    profile;
    unsigned int    level;

    unsigned int    width_in_mb;
    unsigned int    height_in_mb;
    unsigned int    picture_structure;

    union {
        struct {
            unsigned int    residual_colour_transform_flag      : 1;
            unsigned int    delta_pic_always_zero_flag          : 1;
            unsigned int    gaps_in_frame_num_value_allowed_flag: 1;
            unsigned int    frame_mbs_only_flag                 : 1;
            unsigned int    mb_adaptive_frame_field_flag        : 1;
            unsigned int    direct_8x8_inference_flag           : 1;
            unsigned int    xvba_avc_sps_reserved               : 26;
        } avc;

        struct {
            unsigned int    postprocflag        : 1;
            unsigned int    pulldown            : 1;
            unsigned int    interlace           : 1;
            unsigned int    tfcntrflag          : 1;
            unsigned int    finterpflag         : 1;
            unsigned int    reserved            : 1;
            unsigned int    psf                 : 1;
            unsigned int    second_field        : 1;
            unsigned int    xvba_vc1_sps_reserved : 24;
        } vc1;

        unsigned int    flags;
    } sps_info;

    unsigned char   chroma_format;
    unsigned char   avc_bit_depth_luma_minus8;
    unsigned char   avc_bit_depth_chroma_minus8;
    unsigned char   avc_log2_max_frame_num_minus4;

    unsigned char   avc_pic_order_cnt_type;
    unsigned char   avc_log2_max_pic_order_cnt_lsb_minus4;
    unsigned char   avc_num_ref_frames;
    unsigned char   avc_reserved_8bit;

    union {
        struct {
            unsigned int    entropy_coding_mode_flag        : 1;
            unsigned int    pic_order_present_flag          : 1;
            unsigned int    weighted_pred_flag              : 1;
            unsigned int    weighted_bipred_idc             : 2;
            unsigned int    deblocking_filter_control_present_flag  : 1;
            unsigned int    constrained_intra_pred_flag     : 1;
            unsigned int    redundant_pic_cnt_present_flag  : 1;
            unsigned int    transform_8x8_mode_flag         : 1;
            unsigned int    xvba_avc_pps_reserved           : 23;
        } avc;

        struct {
            unsigned int    panscan_flag        : 1;
            unsigned int    refdist_flag        : 1;
            unsigned int    loopfilter          : 1;
            unsigned int    fastuvmc            : 1;
            unsigned int    extended_mv         : 1;
            unsigned int    dquant              : 2;
            unsigned int    vstransform         : 1;
            unsigned int    overlap             : 1;
            unsigned int    quantizer           : 2;
            unsigned int    extended_dmv        : 1;
            unsigned int    maxbframes          : 3;
            unsigned int    rangered            : 1;
            unsigned int    syncmarker          : 1;
            unsigned int    multires            : 1;
            unsigned int    reserved            : 2;
            unsigned int    range_mapy_flag     : 1;
            unsigned int    range_mapy          : 3;
            unsigned int    range_mapuv_flag    : 1;
            unsigned int    range_mapuv         : 3;
            unsigned int    xvba_vc1_pps_reserved: 4;
        } vc1;

        unsigned int    flags;
    } pps_info;

    unsigned char   avc_num_slice_groups_minus1;
    unsigned char   avc_slice_group_map_type;
    unsigned char   avc_num_ref_idx_l0_active_minus1;
    unsigned char   avc_num_ref_idx_l1_active_minus1;

    char            avc_pic_init_qp_minus26;
    char            avc_pic_init_qs_minus26;
    char            avc_chroma_qp_index_offset;
    char            avc_second_chroma_qp_index_offset;

    unsigned short  avc_slice_group_change_rate_minus1;
    unsigned short  avc_reserved_16bit;

    unsigned int    avc_frame_num;
    unsigned int    avc_frame_num_list[16]; ///< bit 31 is used to indicate long/short term
    int             avc_curr_field_order_cnt_list[2];
    int             avc_field_order_cnt_list[16][2];

    unsigned char   avc_slice_group_map[810];

    int             avc_intra_flag;
    int             avc_reference;

    int             xvba_reserved[14];

} XVBAPictureDescriptor;

/**
 * XVBA Compressed data type: XVBA_DATA_CTRL_BUFFER
 * (H264 and VC1 only)
 */
typedef struct
{
  unsigned int  SliceBitsInBuffer;
  unsigned int  SliceDataLocation;
  unsigned int  SliceBytesInBuffer;
  unsigned int  reserved[5];

} XVBADataCtrl;

/**
 * XVBA Compressed data type: XVBA_DATA_BUFFER
 * (MPEG2 iDCT level decode only)
 */
typedef struct
{
    struct
    {
        unsigned short  index: 15; ///< contains rates scan index of the coefficient within the block.
                                   ///< cannot be greater or equal to (block width * block height)
        unsigned short  endofblock:  1;
    } idx;
    short   coeff;                 ///< value of the coefficient in the block; mismatch control and
                                   ///< clipping is host.s responsibility

} XVBAMpeg2Residual;

typedef struct
{
  short horizontal;
  short vertical;
} XVBAMpeg2MV;

typedef struct
{
  unsigned short    mb_address;
  struct
  {
    unsigned short  mb_intra            : 1;
    unsigned short  motion_fw           : 1;
    unsigned short  motion_back         : 1;
    unsigned short  reserved2           : 2;
    unsigned short  field_residual      : 1;
    unsigned short  mb_scan_mode        : 2;
    unsigned short  motion_type         : 2;
    unsigned short  reserved1           : 2;
    unsigned short  motion_vector_sel0  : 1;
    unsigned short  motion_vector_sel1  : 1;
    unsigned short  motion_vector_sel2  : 1;
    unsigned short  motion_vector_sel3  : 1;
  } mpeg2data1;

  struct
  {
    unsigned int    mb_data_resid_location  : 24;
    unsigned int    skipped_mb              : 8;
  } mpeg2data2;

  unsigned short    pattern_code;
  unsigned char     numcoeff[6];

} XVBAMpeg2IntraMB;

typedef struct
{
  unsigned short    mb_address;
  struct
  {
    unsigned short  mb_intra            : 1;
    unsigned short  motion_fw           : 1;
    unsigned short  motion_back         : 1;
    unsigned short  reserved2           : 2;
    unsigned short  field_residual      : 1;
    unsigned short  mb_scan_mode        : 2;
    unsigned short  motion_type         : 2;
    unsigned short  reserved1           : 2;
    unsigned short  motion_vector_sel0  : 1;
    unsigned short  motion_vector_sel1  : 1;
    unsigned short  motion_vector_sel2  : 1;
    unsigned short  motion_vector_sel3  : 1;
  } mpeg2data1;

  struct
  {
    unsigned int    mb_data_resid_location  : 24;
    unsigned int    skipped_mb              : 8;
  } mpeg2data2;

  unsigned short    pattern_code;
  unsigned char     numcoeff[6];

  XVBAMpeg2MV       motion_vector[4];

} XVBAMpeg2NonIntraMB;

/**
 * XVBA compressed data type: XVBA_QM_BUFFER
 * (H264 and VC1 only)
 */
typedef struct
{
  unsigned char     bScalingLists4x4[6][16];
  unsigned char     bScalingLists8x8[2][64];

} XVBAQuantMatrixAvc;

#ifdef __cplusplus
}
#endif

#endif //_XVBA_H
