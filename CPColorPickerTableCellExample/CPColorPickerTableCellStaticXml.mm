#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface PSListController (CPColorPickerTableCellStaticXml)
@end

@interface CPColorPickerTableCellStaticXml : PSListController
@end
@implementation CPColorPickerTableCellStaticXml
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"CPColorPickerTableCellStaticXml" target:self];
	}
	return _specifiers;
}
@end
