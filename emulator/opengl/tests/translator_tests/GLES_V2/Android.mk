LOCAL_PATH:= $(call my-dir)

$(call emugl-begin-host-executable,triangleV2)
$(call emugl-import,libEGL_translator libGLES_V2_translator)

PREBUILT := $(HOST_PREBUILT_TAG)
LOCAL_SDL_CONFIG ?= prebuilts/tools/$(PREBUILT)/sdl/bin/sdl-config
LOCAL_SDL_CFLAGS := $(shell $(LOCAL_SDL_CONFIG) --cflags)
LOCAL_SDL_LDLIBS := $(filter-out %.a %.lib,$(shell $(LOCAL_SDL_CONFIG) --static-libs))

LOCAL_SRC_FILES:= \
        triangleV2.cpp

LOCAL_CFLAGS += $(LOCAL_SDL_CFLAGS) -g -O0
LOCAL_LDLIBS += $(LOCAL_SDL_LDLIBS)

LOCAL_STATIC_LIBRARIES += libSDL libSDLmain

ifeq ($(HOST_OS),darwin)
  $(call emugl-add-darwin-libs)
  $(call emugl-import,libMac_view)
endif

$(call emugl-end-module)

