//
//  ViewController.h
//  SAABCodes
//
//  Created by Paul Derbyshire on 04/11/2015.
//  Copyright © 2015 derbs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface errorListController : NSViewController <NSTableViewDataSource,NSTableViewDelegate> {
	
}


@property (nonatomic, strong)	NSArray				*originalArray;
@property (nonatomic, strong)	NSMutableArray		*filteredArray;
@property (nonatomic, weak)		IBOutlet NSTableView	*tableViewMain;

-(void)searchTextDidChange:(NSString *)searchText;

@end

