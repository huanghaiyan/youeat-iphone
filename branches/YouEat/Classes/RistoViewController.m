//
//  RistoViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RistoViewController.h"
#import "Annotation.h"


@implementation RistoViewController

@synthesize selectedRisto, address, tags, ristoranteName, mapView, phoneButton, description;

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
	self.navigationItem.title = @"Details";
    self.title = @"Details";
	// name
	self.ristoranteName.text = [selectedRisto objectForKey:@"name"];
	// address
	self.address.text = [NSString stringWithFormat:@"%@, %@", [[selectedRisto objectForKey:@"city"] objectForKey:@"name"], [selectedRisto objectForKey:@"address"]];
	
	//tags
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
	
	//description
	NSDictionary *descriptions = [selectedRisto objectForKey:@"descriptions"] ;	
	
	
	NSEnumerator *descriptionEnum = [descriptions objectEnumerator];
	NSString *descriptionText = @"";	
	NSDictionary *descriptionItem;
	while ((descriptionItem = [descriptionEnum nextObject])) {
		NSString *textItem = [descriptionItem objectForKey:@"description"];
		if(textItem != nil && textItem != NULL && (NSNull *)textItem != [NSNull null]){
			descriptionText = [descriptionText stringByAppendingString:textItem];		
		}
	}
	self.description.text = descriptionText;	
	
	//Phone number
	NSString *phoneText = [selectedRisto objectForKey:@"phoneNumber"];
	if(phoneText != nil && phoneText != NULL && (NSNull *)phoneText != [NSNull null]){
		phoneText = [phoneText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		phoneText = [phoneText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
		//NSNumberFormatter *formatter=[[NSNumberFormatter alloc] init];
		//[formatter setPositiveFormat:@"+# (###) ###-####"];
		//phoneText = [formatter stringForObjectValue:[NSNumber numberWithInt:phoneText]];
		self.phoneButton.titleLabel.text = phoneText;	
	}
	self.phoneButton.titleLabel.adjustsFontSizeToFitWidth = TRUE;
	[self.phoneButton addTarget:self action:@selector(callRisto:) forControlEvents:UIControlEventTouchUpInside];	
	
	// Set the map
    MKCoordinateRegion region;
    region.center.latitude = [[selectedRisto objectForKey:@"latitude"] doubleValue] ;
    region.center.longitude = [[selectedRisto objectForKey:@"longitude"] doubleValue] ;
	
	MKCoordinateSpan span = {0.002, 0.002};
    region.span = span;
    [self.mapView setRegion:region animated:YES];
	CLLocationCoordinate2D pinlocation=mapView.userLocation.coordinate;
	pinlocation.latitude = [[selectedRisto objectForKey:@"latitude"] doubleValue] ;
    pinlocation.longitude = [[selectedRisto objectForKey:@"longitude"] doubleValue] ;
	
    Annotation *annotation = [[Annotation alloc] initWithCoordinate:pinlocation ];
    [self.mapView addAnnotation:annotation];
	
}

- (void)callRisto:(id)sender{
	NSString *composeNumberString = [selectedRisto objectForKey:@"phoneNumber"];
	composeNumberString = [composeNumberString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	composeNumberString = [composeNumberString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
	composeNumberString = [NSString stringWithFormat:@"tel:%@", composeNumberString];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:composeNumberString]];
}

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
	[description release];
	[phoneButton release];
    [super dealloc];
}

@end

