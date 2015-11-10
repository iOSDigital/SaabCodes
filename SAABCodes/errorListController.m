//
//  ViewController.m
//  SAABCodes
//
//  Created by Paul Derbyshire on 04/11/2015.
//  Copyright © 2015 derbs. All rights reserved.
//

#import "errorListController.h"
#import "errorDetailController.h"



@interface errorListController () {
	
}
@property (nonatomic,strong) errorDetailController *popoverDetails;
@end




@implementation errorListController



- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.tableViewMain setTarget:self];
	[self.tableViewMain setAction:@selector(tableDoubleClickAction)];
	NSData *errorData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ErrorCodes" ofType:@"json"]];

	NSError *jsonError;
	NSDictionary *originalDictionary = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:&jsonError];
	NSSortDescriptor *codeSorter = [NSSortDescriptor sortDescriptorWithKey:@"Code" ascending:YES];
	self.originalArray = [originalDictionary.copy sortedArrayUsingDescriptors:@[codeSorter]];
	self.filteredArray = [self.originalArray mutableCopy];
}




-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	return self.filteredArray.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
				  row:(NSInteger)row {
	
	if ([tableColumn.identifier isEqualToString:@"columnCode"]) {
		NSTableCellView *result = [tableView makeViewWithIdentifier:@"cellMain" owner:self];
		NSString *codeString = [[self.filteredArray objectAtIndex:row] valueForKey:@"Code"];
		NSString *cellString = codeString;
		result.textField.stringValue = cellString;
		return result;
		
	}else {
		NSTableCellView *result = [tableView makeViewWithIdentifier:@"cellDescription" owner:self];
		NSString *cellString = [[self.filteredArray objectAtIndex:row] valueForKey:@"Description"];
		result.textField.stringValue = cellString;
		return result;
	}
}


-(void)tableViewSelectionDidChange:(NSNotification *)notification {
	
	NSInteger clickedRow = [self.tableViewMain selectedRow];
	if (clickedRow < 0) {
		return;
	}
	
	NSDictionary *detailDict = [self.filteredArray objectAtIndex:clickedRow];
	
	NSRect cellRect = [self.tableViewMain frameOfCellAtColumn:1 row:clickedRow];
	
	if (self.presentedViewControllers.count > 0) {
		[self dismissViewController:[self.presentedViewControllers objectAtIndex:0]];
	}
	
	errorDetailController *detailController = [[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"popoverController"];
	[detailController setDetailDictionary:detailDict];
	
	[self presentViewController:detailController asPopoverRelativeToRect:cellRect ofView:self.tableViewMain preferredEdge:NSRectEdgeMaxX behavior:NSPopoverBehaviorTransient];
}

-(void)tableDoubleClickAction {
	
	if (self.presentedViewControllers.count > 0) {
		return;
	}
	if ([self.tableViewMain selectedRow] < 0) {
		return;
	}
	
	NSInteger clickedRow = [self.tableViewMain clickedRow];
	NSDictionary *detailDict = [self.filteredArray objectAtIndex:clickedRow];
	
	NSRect cellRect = [self.tableViewMain frameOfCellAtColumn:1 row:clickedRow];
	errorDetailController *controllerDetails = [[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"popoverController"];
	[controllerDetails setDetailDictionary:detailDict];
	
	[self presentViewController:controllerDetails asPopoverRelativeToRect:cellRect ofView:self.tableViewMain preferredEdge:NSRectEdgeMaxX behavior:NSPopoverBehaviorTransient];
}



-(void)searchTextDidChange:(NSString *)searchText {
	if (!searchText || searchText.length == 0) {
		self.filteredArray = [self.originalArray mutableCopy];
	}else{
		NSPredicate *searchCodePredicate = [NSPredicate predicateWithFormat:@"Code CONTAINS[cd] %@",searchText];
		NSPredicate *searchDescriptionPredicate = [NSPredicate predicateWithFormat:@"Description CONTAINS[cd] %@",searchText];
		NSCompoundPredicate *searchPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[searchCodePredicate,searchDescriptionPredicate]];
		
		self.filteredArray = [[self.originalArray filteredArrayUsingPredicate:searchPredicate] mutableCopy];
	}
	
	[self.tableViewMain reloadData];
}







- (void)setRepresentedObject:(id)representedObject {
	[super setRepresentedObject:representedObject];
}

@end
