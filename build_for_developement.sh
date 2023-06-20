#/bin/sh

#	build for regular jailbreaks
export DEVELOPER_DIR=/Volumes/Xcode_11_7/Xcode.app/Contents/Developer
make clean
make package

rm -r "$THEOS/lib/ColorPickerWell.framework"

#	build for rootless jailbreaks
export -n DEVELOPER_DIR
make clean
make package THEOS_PACKAGE_SCHEME=rootless

rm -r "$THEOS/lib/ColorPickerWell.framework"
