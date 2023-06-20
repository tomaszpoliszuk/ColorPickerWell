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


#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSControlTableCell.h>

@interface UIColor ()
@property (nonatomic, readonly) NSString *accessibilityName;	//	iOS 14+
- (double)alphaComponent;
@end

@interface UIColorWell ()
- (void)addTarget:(id)arg1 action:(SEL)arg2 forEvents:(int)arg3;
- (void)setPickerTitle:(id)arg1;
@end

@interface UIControl ()
- (void)addTarget:(id)arg1 action:(SEL)arg2 forEvents:(int)arg3;
@end
