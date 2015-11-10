//
//  errorDetailController.m
//  SAABCodes
//
//  Created by Paul Derbyshire on 04/11/2015.
//  Copyright © 2015 derbs. All rights reserved.
//

#import "errorDetailController.h"

@interface errorDetailController ()

@end

@implementation errorDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(IBAction)copyToClipboard:(id)sender {
	if (self.detailDictionary) {
		NSMutableString *copyString = [[NSMutableString alloc] initWithFormat:@"Code %@\n",self.detailDictionary[@"Code"]];
		[copyString appendString:self.detailDictionary[@"Description"]];
		
		[[NSPasteboard generalPasteboard] declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
		[[NSPasteboard generalPasteboard] setString:copyString forType:NSStringPboardType];
	}
	
}


-(void)dealloc {
//	NSLog(@"errorDetailController dealloc");
}

@end
