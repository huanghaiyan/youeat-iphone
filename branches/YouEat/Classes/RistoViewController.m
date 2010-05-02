//
//  RistoViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RistoViewController.h"


@implementation RistoViewController

@synthesize selectedRisto, address, tags, ristoranteName;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Selected restaurant";
    self.title = @"Risto";
	self.ristoranteName.text = [selectedRisto objectForKey:@"name"];
	self.address.text = [NSString stringWithFormat:@"%@, %@", [[selectedRisto objectForKey:@"city"] objectForKey:@"name"], [selectedRisto objectForKey:@"address"]];
	
	NSDictionary *tagsList = [selectedRisto objectForKey:@"tags"];	
	NSString *tagText = @"";	
	if (!(tagsList == nil)){
		NSEnumerator *tagEnum = [tagsList objectEnumerator];
		NSDictionary *tagObject;
		while ((tagObject = [tagEnum nextObject])) {
			tagText = [tagText stringByAppendingString:[tagObject objectForKey:@"tag"]];
			tagText = [tagText stringByAppendingString:@" "];
		}		
	}
	self.tags.text = tagText;
	
	//Phne number
	NSString *phoneText = [selectedRisto objectForKey:@"phoneNumber"];
	if (phoneText == [NSNull null] || phoneText.length == 0 ) {
		phoneText = @"";
	}
	else{	
		phoneText = [phoneText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		phoneText = [phoneText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
		//NSNumberFormatter *formatter=[[NSNumberFormatter alloc] init];
		//[formatter setPositiveFormat:@"+# (###) ###-####"];
		//phoneText = [formatter stringForObjectValue:[NSNumber numberWithInt:phoneText]];
	}
}
//	self.phoneButton.titleLabel.text = phoneText;	
//	self.phoneButton.titleLabel.adjustsFontSizeToFitWidth = TRUE;
//	[self.phoneButton addTarget:self action:@selector(callRisto:) forControlEvents:UIControlEventTouchUpInside];

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[selectedRisto release];
	[address release];
	[tags release];
	[ristoranteName release];
    [super dealloc];
}


@end

