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


#include "headers_private/ColorPickerWell.h"

@implementation UIColor (ColorPickerWell)
+ (UIColor *)_CPW_colorFromString:(NSString *)colorString {
	if ([colorString rangeOfString:@","].location == NSNotFound) {
		return [UIColor _CPW_colorFromHexString:colorString];
	} else {
		return [UIColor _CPW_colorFromRgbaString:colorString];
	}
}
+ (UIColor *)_CPW_colorFromHexString:(NSString *)hexString {
	NSString *noHashString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
	NSString *noHashStringShort = [noHashString substringToIndex:6];
	int red = 0;
	int green = 0;
	int blue = 0;
	int alpha = 255;
	if ( [hexString length] <= 4 ) {
		sscanf([noHashString UTF8String], "%01X%01X%01X%01X", &red, &green, &blue, &alpha);
		return [UIColor colorWithRed:red/16.0 green:green/16.0 blue:blue/16.0 alpha:alpha/16.0];
	} else if ( [hexString length] > 9 ) {
		sscanf([noHashStringShort UTF8String], "%02X%02X%02X%02X", &red, &green, &blue, &alpha);
		return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
	} else {
		sscanf([noHashString UTF8String], "%02X%02X%02X%02X", &red, &green, &blue, &alpha);
		return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
	}
}
+ (UIColor *)_CPW_colorFromRgbaString:(NSString *)rgbaString {
	NSArray *rgbaParts = [rgbaString componentsSeparatedByString: @","];
	float red = [rgbaParts[0] floatValue];
	float green = [rgbaParts[1] floatValue];
	float blue = [rgbaParts[2] floatValue];
	float alpha = [rgbaParts[3] floatValue];
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
- (NSString *)_CPW_hexString {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	CGFloat red		= components[0];
	CGFloat green	= components[1];
	CGFloat blue	= components[2];
	CGFloat alpha	= components[3];
	if ( alpha == 1 ) {
		return [NSString stringWithFormat:@"#%02X%02X%02X", (int)(red * 255), (int)(green * 255), (int)(blue * 255)];
	} else {
		return [NSString stringWithFormat:@"#%02X%02X%02X%02X", (int)(red * 255), (int)(green * 255), (int)(blue * 255), (int)(alpha * 255)];
	}
}
- (NSString *)_CPW_rgbaString {
	CGFloat red, green, blue, alpha;
	if (![self getRed:&red green:&green blue:&blue alpha:&alpha]) {
		[self getWhite:&red alpha:&alpha];
		green = red;
		blue = red;
	}
	return [NSString stringWithFormat:@"%f, %f, %f, %f", (CGFloat)red, (CGFloat)green, (CGFloat)blue, (CGFloat)alpha];
}
- (NSString *)_CPW_colorName {
	if ( [self respondsToSelector:@selector(accessibilityName)] ) {
		return [self accessibilityName];
	} else {
		return [self _CPW_hexString];
	}
}
@end
