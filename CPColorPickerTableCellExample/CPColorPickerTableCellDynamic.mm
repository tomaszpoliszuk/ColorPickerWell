#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

#define kPackage @"com.tomaszpoliszuk.colorpickertablecellexample"
#define kSettingsChanged @"com.tomaszpoliszuk.colorpickertablecellexample.settingschanged"

@interface CPColorPickerTableCellDynamic : PSListController
@end

@implementation CPColorPickerTableCellDynamic
-(PSSpecifier *)createGroupSpecifierNamed:(NSString *)name {
	PSSpecifier *specifier = [PSSpecifier groupSpecifierWithName:name];
	return specifier;
}

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [NSMutableArray new];

		PSSpecifier *dynamicCPColorPickerTableCell = [PSSpecifier preferenceSpecifierNamed:@"no alpha, default"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSStaticTextCell
			edit:nil
		];
		[dynamicCPColorPickerTableCell setProperty:@"noAlphaDefaultDynamic" forKey:@"key"];
		[dynamicCPColorPickerTableCell setProperty:kPackage forKey:@"defaults"];
		[dynamicCPColorPickerTableCell setProperty:@"YES" forKey:@"allowMultilineTitleKey"];
		[dynamicCPColorPickerTableCell setProperty:kSettingsChanged forKey:@"PostNotification"];
		[dynamicCPColorPickerTableCell setProperty:NSClassFromString(@"CPColorPickerTableCell") forKey:@"cellClass"];
		[dynamicCPColorPickerTableCell setProperty:@"#339966" forKey:@"default"];

		PSSpecifier *dynamicCPColorPickerTableCell2 = [PSSpecifier preferenceSpecifierNamed:@"no alpha, no default"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSStaticTextCell
			edit:nil
		];
		[dynamicCPColorPickerTableCell2 setProperty:@"noAlphaNoDefaultDynamic" forKey:@"key"];
		[dynamicCPColorPickerTableCell2 setProperty:kPackage forKey:@"defaults"];
		[dynamicCPColorPickerTableCell2 setProperty:kSettingsChanged forKey:@"PostNotification"];
		[dynamicCPColorPickerTableCell2 setProperty:@"YES" forKey:@"allowMultilineTitleKey"];
		[dynamicCPColorPickerTableCell2 setProperty:NSClassFromString(@"CPColorPickerTableCell") forKey:@"cellClass"];

		PSSpecifier *dynamicCPColorPickerTableCellALpha = [PSSpecifier preferenceSpecifierNamed:@"alpha, default"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSStaticTextCell
			edit:nil
		];
		[dynamicCPColorPickerTableCellALpha setProperty:@"alphaDefaultDynamic" forKey:@"key"];
		[dynamicCPColorPickerTableCellALpha setProperty:kPackage forKey:@"defaults"];
		[dynamicCPColorPickerTableCellALpha setProperty:@"YES" forKey:@"supportsAlpha"];
		[dynamicCPColorPickerTableCellALpha setProperty:@"YES" forKey:@"allowMultilineTitleKey"];
		[dynamicCPColorPickerTableCellALpha setProperty:kSettingsChanged forKey:@"PostNotification"];
		[dynamicCPColorPickerTableCellALpha setProperty:NSClassFromString(@"CPColorPickerTableCell") forKey:@"cellClass"];
		[dynamicCPColorPickerTableCellALpha setProperty:@"#66339966" forKey:@"default"];

		PSSpecifier *dynamicCPColorPickerTableCellALpha2 = [PSSpecifier preferenceSpecifierNamed:@"alpha, no default, custom picker title"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSStaticTextCell
			edit:nil
		];
		[dynamicCPColorPickerTableCellALpha2 setProperty:@"alphaNoDefaultDynamic" forKey:@"key"];
		[dynamicCPColorPickerTableCellALpha2 setProperty:kPackage forKey:@"defaults"];
		[dynamicCPColorPickerTableCellALpha2 setProperty:@"Picker Title" forKey:@"pickerTitle"];
		[dynamicCPColorPickerTableCellALpha2 setProperty:@"YES" forKey:@"supportsAlpha"];
		[dynamicCPColorPickerTableCellALpha2 setProperty:@"YES" forKey:@"allowMultilineTitleKey"];
		[dynamicCPColorPickerTableCellALpha2 setProperty:kSettingsChanged forKey:@"PostNotification"];
		[dynamicCPColorPickerTableCellALpha2 setProperty:NSClassFromString(@"CPColorPickerTableCell") forKey:@"cellClass"];

		[_specifiers addObject:dynamicCPColorPickerTableCell];
		[_specifiers addObject:dynamicCPColorPickerTableCell2];
		[_specifiers addObject:dynamicCPColorPickerTableCellALpha];
		[_specifiers addObject:dynamicCPColorPickerTableCellALpha2];
	}
	return _specifiers;
}
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	[super setPreferenceValue:value specifier:specifier];
}
@end
