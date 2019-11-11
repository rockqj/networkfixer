export TARGET=iphone:clang::13
export ARCHS=arm64
export DEBUG=0

include $(THEOS)/makefiles/common.mk

TOOL_NAME = networkfixer

$(TOOL_NAME)_FILES = main.m
$(TOOL_NAME)_CFLAGS = -fobjc-arc
$(TOOL_NAME)_CODESIGN_FLAGS = -Sent.plist

include $(THEOS_MAKE_PATH)/tool.mk

after-install::
	install.exec "/usr/bin/networkfixer"
