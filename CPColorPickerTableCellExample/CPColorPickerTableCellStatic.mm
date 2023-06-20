#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface PSListController (CPColorPickerTableCellStatic)
@end

@interface CPColorPickerTableCellStatic : PSListController
@end
@implementation CPColorPickerTableCellStatic
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"CPColorPickerTableCellStatic" target:self];
	}
	return _specifiers;
}
@end
