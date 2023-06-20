#/bin/sh

mkdir -p "$THEOS/include/ColorPickerWell"
cp -Rv "./headers_public/UIColor+ColorPickerWell.h" "$THEOS/include/ColorPickerWell"

export DEVELOPER_DIR=/Volumes/Xcode_11_7/Xcode.app/Contents/Developer
make clean
make FINALPACKAGE=1
mkdir -p "$THEOS/lib/iphone/rootful"
cp -Rv "./.theos/obj/ColorPickerWell.framework" "$THEOS/lib/iphone/rootful"

make clean
make FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=rootless
mkdir -p "$THEOS/lib/iphone/rootless"
cp -Rv "./.theos/obj/ColorPickerWell.framework" "$THEOS/lib/iphone/rootless"

echo "Successfully installed ColorPickerWell"
