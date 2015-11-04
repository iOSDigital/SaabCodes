//
//  errorWindowController.m
//  SAABCodes
//
//  Created by Paul Derbyshire on 04/11/2015.
//  Copyright © 2015 derbs. All rights reserved.
//

#import "errorWindowController.h"

@interface errorWindowController () {
	
}
@property (nonatomic, weak) errorListController *listController;
@end



@implementation errorWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
	self.listController = (errorListController *)self.contentViewController;
}



//-(BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor {
//	NSLog(@"%@",fieldEditor.string);
//	return YES;
//}
//-(BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
//	NSLog(@"%@",fieldEditor.string);
//	return YES;
//}
-(void)controlTextDidChange:(NSNotification *)obj {
	NSString *searchString = ((NSSearchField *)obj.object).stringValue;
	[self.listController searchTextDidChange:searchString];
}

@end
