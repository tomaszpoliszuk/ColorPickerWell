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

@implementation _CPColorWellConicalGradientBackgroundView
@dynamic layer;
+ (Class)layerClass {
	return NSClassFromString(@"CAGradientLayer");
}
- (id)initWithFrame:(CGRect)frame {
	double gradientSize = 28;
	double alphaLayerSize = 28;
	if ( [[[%c(UIDevice) currentDevice] model] rangeOfString:@"iPad"].location != NSNotFound ) {
		gradientSize = 36;
		alphaLayerSize = 32;
	}
	self = [super initWithFrame:CGRectMake(0, 0, gradientSize, gradientSize)];
	_alphaLayer = [NSClassFromString(@"CAGradientLayer") layer];
	_alphaLayer.frame = CGRectMake(0, 0, alphaLayerSize, alphaLayerSize);
	_alphaLayer.cornerRadius = _alphaLayer.frame.size.width / 2;
	_alphaLayer.startPoint = CGPointMake(0.5, 0.5);
	_alphaLayer.endPoint = CGPointMake(1, 1);
	_alphaLayer.type = @"radial";
	_alphaLayer.colors = @[
		(id)[UIColor colorWithWhite:1 alpha:1].CGColor,
		(id)[UIColor colorWithWhite:1 alpha:0.3].CGColor
	];
	[self.layer insertSublayer:_alphaLayer atIndex:0];
	return self;
}
@end
