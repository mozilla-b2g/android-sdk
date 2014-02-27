# This build script corresponds to a library containing many definitions
# common to both the guest and the host. They relate to
#
LOCAL_PATH := $(call my-dir)

commonSources := \
        GLClientState.cpp \
        GLSharedGroup.cpp \
        glUtils.cpp \
        SocketStream.cpp \
        TcpStream.cpp \
        TimeUtils.cpp

host_commonSources := $(commonSources)

ifeq ($(HOST_OS),windows)
    host_commonSources += Win32PipeStream.cpp
else
    host_commonSources += UnixStream.cpp
endif

ifneq ($(shell uname -m), x86_64)

### OpenglCodecCommon  host ##############################################
$(call emugl-begin-host-static-library,libOpenglCodecCommon)

LOCAL_SRC_FILES := $(host_commonSources)

$(call emugl-export,STATIC_LIBRARIES,libcutils)
$(call emugl-export,C_INCLUDES,$(LOCAL_PATH))
$(call emugl-end-module)

else # x86_64

### OpenglCodecCommon  host, 64-bit #########################################
$(call emugl-begin-host-static-library,lib64OpenglCodecCommon)

LOCAL_SRC_FILES := $(host_commonSources)

$(call emugl-export,STATIC_LIBRARIES,lib64cutils)
$(call emugl-export,C_INCLUDES,$(LOCAL_PATH))
$(call emugl-export,CFLAGS,-m64)
$(call emugl-end-module)

endif
