ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
export ARCHS = arm64 arm64e
export TARGET = iphone:clang:14.5:15.0
else
export ARCHS = armv7 armv7s arm64 arm64e
export TARGET = iphone:clang:14.5:7
endif

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = ColorPickerWell

$(FRAMEWORK_NAME)_FILES = $(wildcard *.xm)
$(FRAMEWORK_NAME)_INSTALL_PATH = /Library/Frameworks
$(FRAMEWORK_NAME)_CFLAGS = -fobjc-arc
$(FRAMEWORK_NAME)_FRAMEWORKS = UIKit CoreGraphics Foundation
$(FRAMEWORK_NAME)_PRIVATE_FRAMEWORKS = Preferences
ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
$(FRAMEWORK_NAME)_LDFLAGS += -install_name @rpath/ColorPickerWell.framework/ColorPickerWell
endif

include $(THEOS_MAKE_PATH)/framework.mk
ifeq ($(PACKAGE_BUILDNAME),debug)
SUBPROJECTS += CPColorPickerTableCellExample
endif
include $(THEOS_MAKE_PATH)/aggregate.mk
