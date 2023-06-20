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

@implementation CPColorWell
- (void)_commonInit {
	[self setSupportsAlpha:NO];
	double buttonSize = 24;
	double gradientViewSize = 28;
	if ( [[[%c(UIDevice) currentDevice] model] rangeOfString:@"iPad"].location != NSNotFound ) {
		buttonSize = 32;
		gradientViewSize = 32;
	}
	_button = [[UIButton alloc] initWithFrame:CGRectMake(2, 2, buttonSize, buttonSize)];
	_button.tag = 218;
//	👾 https://en.wikipedia.org/w/index.php?title=List_of_HTTP_status_codes&oldid=1066646591#218
	_button.layer.cornerRadius = _button.frame.size.width / 2;
	[_button addTarget:self action:@selector(invokeColorPicker) forControlEvents:UIControlEventTouchUpInside];
//	[_button addTarget:self action:@selector(invokeColorPicker) forControlEvents:UIControlEventValueChanged];
	_gradientView = [[_CPColorWellConicalGradientBackgroundView alloc] initWithFrame:CGRectMake(0, 0, gradientViewSize, gradientViewSize)];
	_gradientView.layer.cornerRadius = _gradientView.frame.size.width / 2;
	if (@available(iOS 12, *)) {
		_gradientView.layer.startPoint = CGPointMake(0.5, 0.5);
		_gradientView.layer.endPoint = CGPointMake(0.5, 0);
		_gradientView.layer.type = @"conic";
		_gradientView.layer.colors = @[
			(id)[UIColor colorWithRed:0.999896    green:1.00005     blue:-0.346248 alpha:1].CGColor,
			(id)[UIColor colorWithRed:1.074       green:0.462588    blue:-0.210468 alpha:1].CGColor,
			(id)[UIColor colorWithRed:1.09303     green:-0.22667    blue:-0.150102 alpha:1].CGColor,
			(id)[UIColor colorWithRed:1.09304     green:-0.226576   blue:1.03369   alpha:1].CGColor,
			(id)[UIColor colorWithRed:0.000184822 green:0.000434548 blue:1.0419    alpha:1].CGColor,
			(id)[UIColor colorWithRed:-0.511752   green:1.01832     blue:1.00846   alpha:1].CGColor,
			(id)[UIColor colorWithRed:-0.511767   green:1.01831     blue:-0.310667 alpha:1].CGColor,
			(id)[UIColor colorWithRed:0.552587    green:0.888607    blue:-0.278987 alpha:1].CGColor,
			(id)[UIColor colorWithRed:0.999896    green:1.00005     blue:-0.346248 alpha:1].CGColor
		];
	} else {
		NSBundle *colorPickerBundle = [NSBundle bundleWithIdentifier:@"com.tomaszpoliszuk.colorpickertablecell"];
		UIImage *imageToSet = [[UIImage imageNamed:@"conicGradient" inBundle:colorPickerBundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		_gradientView.layer.contents = (id)imageToSet.CGImage;
		_gradientView.layer.contentsGravity = kCAGravityResizeAspectFill;
		_gradientView.layer.geometryFlipped = true;
	}
	[self addSubview:_gradientView];
	[self addSubview:_button];
	[self updateButton];
}
- (id)initWithFrame:(CGRect)frame {
	double wellSize = 32;
	self = [super initWithFrame:CGRectMake(0, 0, wellSize, wellSize)];
	[self _commonInit];
	return self;
}
- (void)invokeColorPicker {
	[self sendActionsForControlEvents:UIControlEventTouchUpInside];
	if ( [self libcolorpickerInstalled] ) {
		UIColor *startColor = self.selectedColor;
		[self setPickerTitle:[self title]];
		PFColorAlert *alert = [NSClassFromString(@"PFColorAlert") colorAlertWithStartColor:startColor showAlpha:[self supportsAlpha]];
		[alert displayWithCompletion:^void (UIColor *pickedColor) {
			_colorPicker = alert;
			[self setSelectedColor:pickedColor];
		}];
	}
}
- (NSString *)title {
	return _title;
}
- (void)setPickerTitle:(NSString *)pickerTitle {
	_title = pickerTitle;
}
- (void)setTitle:(NSString *)title {
	[self setPickerTitle:title];
}
- (bool)supportsAlpha {
	return _supportsAlpha;
}
- (void)setSupportsAlpha:(bool)supportsAlpha {
	_supportsAlpha = supportsAlpha;
}
- (UIColor *)selectedColor {
	return _selectedColor;
}
- (void)setSelectedColor:(UIColor *)selectedColor {
	_selectedColor = selectedColor;
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	[self updateButton];
}
- (void)updateButton {
	if (_selectedColor) {
		_button.backgroundColor = _selectedColor;
		_button.layer.borderWidth = 2;
		if ( @available(iOS 13, *) ) {
			_button.layer.borderColor = [UIColor systemBackgroundColor].CGColor;
		} else {
			_button.layer.borderColor = [UIColor whiteColor].CGColor;
		}
	} else {
		_button.layer.borderWidth = 0;
	}
	[self setNeedsDisplay];
}
- (bool)libcolorpickerInstalled {
	void *libcolorpickerHandle = dlopen("/usr/lib/libcolorpicker.dylib", RTLD_NOW);
	return ( libcolorpickerHandle );
}

@end
