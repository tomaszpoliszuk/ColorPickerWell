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


@interface CPColorWell : UIControl {
	bool _supportsAlpha;
	_CPColorWellConicalGradientBackgroundView *_gradientView;
	NSString *_title;
	PFColorAlert *_colorPicker;
	UIButton *_button;
	UIColor *_selectedColor;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic) bool supportsAlpha;
- (NSString *)title;
- (void)setPickerTitle:(NSString *)pickerTitle;
- (void)setTitle:(NSString *)title;
- (void)setSupportsAlpha:(bool)arg1;
- (bool)supportsAlpha;
- (UIColor *)selectedColor;
- (void)setSelectedColor:(UIColor *)selectedColor;
- (id)initWithFrame:(CGRect)frame;
@end
