#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

#define kPackage @"com.tomaszpoliszuk.colorpickertablecellexample"

@interface PSListController (CPColorPickerTableCellExample)
@end

@interface CPColorPickerTableCellExample : PSListController
@end
@implementation CPColorPickerTableCellExample
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"CPColorPickerTableCellExample" target:self];
	}
	return _specifiers;
}
- (void)resetSettings {
	NSUserDefaults *tweakSettings = [[NSUserDefaults alloc] initWithSuiteName:kPackage];
	UIAlertController *resetSettingsAlert = [UIAlertController alertControllerWithTitle:@"Reset Example Settings" message:@"Do you want to reset settings?" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action) {
		for(NSString *key in [[tweakSettings dictionaryRepresentation] allKeys]) {
			[tweakSettings removeObjectForKey:key];
		}
		[tweakSettings synchronize];
		[self reloadSpecifiers];
	}];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
	[resetSettingsAlert addAction:cancel];
	[resetSettingsAlert addAction:confirm];
	[self presentViewController:resetSettingsAlert animated:YES completion:nil];
}
@end
