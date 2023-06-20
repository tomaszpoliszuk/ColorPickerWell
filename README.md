# Color Picker Well

## This dependency provides:
* CPColorWell (recreation of UIColorWell that uses libcolorpicker or it's replacements for color picker part) compatible with iOS 7 - 13
* CPColorPickerTableCell to set color from preferences - uses UIColorWell on iOS 14+ and CPColorWell for lower versions, compatible with iOS 9+
* UIColor extensions

## Installation
* Run [build_for_theos.sh](build_for_theos.sh) (change `DEVELOPER_DIR` path to your instance of Xcode 11.7)
* Add `$(TWEAK_NAME)_EXTRA_FRAMEWORKS = ColorPickerTableCell` to makefile of your project
* Add `#import <ColorPickerTableCell/CPColorPickerTableCell.h>` to your headers

## Examples
* in subproject `CPColorPickerTableCellExample` check:
	* `CPColorPickerTableCellStatic` & `CPColorPickerTableCellStaticXml` for simple plist-based implementation examples
	* `CPColorPickerTableCellDynamic` for dynamic implementation examples
* To get color from saved settings string use `[UIColor _CPW_colorFromString:COLOR_STRING_FROM_SETTINGS_HERE]`

## Live Examples
Check out this projects to see actual implementations of Color Picker Table Cell:
* [DockController](https://github.com/tomaszpoliszuk/DockController/commit/ebf23361b8686d3578af8c0a963705352e60c70f)

## TODO
* add iOS 7-8 support for CPColorPickerTableCell
