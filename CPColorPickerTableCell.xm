/* ColorPickerWell
 * (c) Copyright 2022-2023 Tomasz Poliszuk
 *
 * ColorPickerWell is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * ColorPickerWell is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ColorPickerWell. If not, see <https://www.gnu.org/licenses/>.
 */


#include <dlfcn.h>
#include "headers_private/ColorPickerWell.h"

@implementation CPColorPickerTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier specifier:specifier];
	if (self) {
		specifier.cellType = PSStaticTextCell;
		if (@available(iOS 14, *)) {
			self.colorPreview = [[UIColorWell alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
			[self.colorPreview addTarget:self action:@selector(colorChanged) forEvents:UIControlEventValueChanged];
			[self setAccessoryView:self.colorPreview];
		} else {
			self.colorPreviewLegacy = [[CPColorWell alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
			[self.colorPreviewLegacy addTarget:self action:@selector(colorChanged) forEvents:UIControlEventValueChanged];
			[self setAccessoryView:self.colorPreviewLegacy];
		}
	}
	return self;
}
- (void)setCurrentValue {
	NSString *colorString = self._CPTC_getColor;
	if ( colorString ) {
		if (@available(iOS 14, *)) {
			self.colorPreview.selectedColor = [UIColor _CPW_colorFromString:colorString];
			self.detailTextLabel.text = [self _CPTC_colorNameFromColor:self.colorPreview.selectedColor];
		} else {
			self.colorPreviewLegacy.selectedColor = [UIColor _CPW_colorFromString:colorString];
			self.detailTextLabel.text = [self _CPTC_colorNameFromColor:self.colorPreviewLegacy.selectedColor];
		}
	} else {
		self.detailTextLabel.text = @" ";
	}
}
- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];
	specifier.cellType = PSStaticTextCell;
	[self setCurrentValue];
	[self _CPTC_updateCell];
}
- (NSString *)_CPTC_pickerTitle {
	if ( self.specifier.properties[@"pickerTitle"] ) {
		return self.specifier.properties[@"pickerTitle"];
	}
	return self.specifier.name;
}
- (bool)_CPTC_supportsAlpha {
	return self.specifier.properties[@"supportsAlpha"] ? ((NSNumber *)self.specifier.properties[@"supportsAlpha"]).boolValue : NO;
}
- (void)_CPTC_setColor:(UIColor *)color {
	[self.specifier performSetterWithValue:[color _CPW_rgbaString]];
}
- (NSString *)_CPTC_getColor {
	return [self.specifier performGetter];
}
- (NSString *)_CPTC_colorNameFromColor:(UIColor *)color {
	return [NSString stringWithFormat:@"%@", [color _CPW_colorName]];
}
- (void)_CPTC_updateCell {
	if (@available(iOS 14, *)) {
		[self.colorPreview setPickerTitle:[self _CPTC_pickerTitle]];
		[self.colorPreview setSupportsAlpha:[self _CPTC_supportsAlpha]];
	} else {
		[self.colorPreviewLegacy setPickerTitle:[self _CPTC_pickerTitle]];
		[self.colorPreviewLegacy setSupportsAlpha:[self _CPTC_supportsAlpha]];
	}
}
- (void)colorChanged {
	UIColor *selectedColor;
	if (@available(iOS 14, *)) {
		selectedColor = self.colorPreview.selectedColor;
		[self _CPTC_setColor:selectedColor];
		NSString *selectedColorString = [selectedColor _CPW_colorName];
		self.detailTextLabel.text = selectedColorString;
		[self.colorPreview setPickerTitle:selectedColorString];
	} else {
		selectedColor = self.colorPreviewLegacy.selectedColor;
		[self _CPTC_setColor:selectedColor];
		NSString *selectedColorString = [selectedColor _CPW_colorName];
		self.detailTextLabel.text = selectedColorString;
		[self.colorPreviewLegacy setPickerTitle:selectedColorString];
	}
}
@end
