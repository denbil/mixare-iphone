//
//  ListViewController.m
//  Mixare
//
//  Created by jakob on 05.11.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"
#import "WebViewController.h"

#define kTextFieldWidth	180.0
#define kViewTag				1
#define kLeftMargin				100.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			11.0

#define kTextFieldHeight		30.0
static NSString *kSectionTitleKey = @"sectionTitleKey";


@implementation ListViewController
@synthesize dataSourceArray= source; 

- (void)dealloc
{	
	//dealloc mem
	
	[dataSourceArray release];
	[source release];
	
	[super dealloc];
}



- (void)viewDidLoad{	
    [super viewDidLoad];
	
}

// called after the view controller's view is released and set to nil.
// For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.
// So release any properties that are loaded in viewDidLoad or can be recreated lazily.
//
- (void)viewDidUnload 
{
    [super viewDidUnload];
	
	// release the controls and set them nil in case they were ever created
	// note: we can't use "self.xxx = nil" since they are read only properties
	//
	self.dataSourceArray = nil;	// this will release and set to nil
	source = nil;
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return (source != nil) ? [source count] :0;
}

// to determine specific row height for each cell, override this.
// In this example, each row is determined by its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return ([indexPath row] == 0) ? 60.0 : 60.0;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = nil;
	//NSUInteger row = [indexPath row];
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];
	if(source != nil){
		cell.textLabel.text = [[source objectAtIndex:indexPath.row]valueForKey:@"title"];
		cell.detailTextLabel.text = [[source objectAtIndex:indexPath.row]valueForKey:@"sum"];
	}else{
		//
	}
	return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate

// the table's selection has changed, switch to that item's UIViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"in select row");
	WebViewController *targetViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
	if([[[source objectAtIndex:indexPath.row]valueForKey:@"source"] isEqualToString:@"BUZZ"]){
		targetViewController.url = [NSString stringWithFormat:@"%@",[[source objectAtIndex:indexPath.row]valueForKey:@"url"]];
	}else{
		targetViewController.url = [NSString stringWithFormat:@"http://%@",[[source objectAtIndex:indexPath.row]valueForKey:@"url"]];
	}
	[[self navigationController] pushViewController:targetViewController animated:YES];
}

@end