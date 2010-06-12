//
//  RistoViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "RistoViewController.h"
#import "Annotation.h"


@implementation RistoViewController

@synthesize selectedRisto, address, tags, ristoranteName, mapView,  description;
@synthesize buttonBarSegmentedControl, currentPicker, wwwPickerView, wwwPickerDataSource, phonePickerView, phonePickerDataSource;



// return the picker frame based on its size, positioned at the bottom of the page
- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(	0.0,
								   screenRect.size.height - 128.0 - size.height,
								   size.width,
								   size.height);
	return pickerRect;
}


- (void)createPicker
{
	// starts with no current picker
	currentPicker2 = -1;

	//***WWW
	wwwPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	CGSize pickerSize = [wwwPickerView sizeThatFits:CGSizeZero];
	wwwPickerView.frame = [self pickerFrameWithSize:pickerSize];

	wwwPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	wwwPickerView.showsSelectionIndicator = YES;	// note this is default to NO
	
	// this view controller is the data source and delegate
	wwwPickerDataSource = [[WWWPickerDataSource alloc] init];

	NSString *www = nil;
	if([selectedRisto objectForKey:@"www"] != nil && [selectedRisto objectForKey:@"www"] != NULL && (NSNull *)[selectedRisto objectForKey:@"www"] != [NSNull null]){
		www = [selectedRisto objectForKey:@"www"];
	}
	
	NSString *email = nil;
	if([selectedRisto objectForKey:@"email"] != nil && [selectedRisto objectForKey:@"email"] != NULL && (NSNull *)[selectedRisto objectForKey:@"email"] != [NSNull null]){
		email = [selectedRisto objectForKey:@"email"];
	}
	
	wwwPickerDataSource.wwwPickerArray = [[NSArray arrayWithObjects:
										   www, email,  nil] retain];
	
	wwwPickerView.delegate = wwwPickerDataSource;
	wwwPickerView.dataSource = wwwPickerDataSource;
//	
//	// add this picker to our view controller, initially hidden
	wwwPickerView.hidden = YES;
	[self.view addSubview:wwwPickerView];
	
	//***PHONE
	phonePickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	pickerSize = [phonePickerView sizeThatFits:CGSizeZero];
	phonePickerView.frame = [self pickerFrameWithSize:pickerSize];
	
	phonePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	phonePickerView.showsSelectionIndicator = YES;	// note this is default to NO
	
	// this view controller is the data source and delegate
	phonePickerDataSource = [[PhonePickerDataSource alloc] init];
	
	NSString *phoneNumber = [selectedRisto objectForKey:@"phoneNumber"];
	NSString *mobilePhoneNumber = [selectedRisto objectForKey:@"mobilePhoneNumber"];
	
	NSMutableArray *phones = [[NSMutableArray alloc] init];
	if(phoneNumber != nil && phoneNumber != NULL && (NSNull *)phoneNumber != [NSNull null]){
		phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
		[phones addObject:phoneNumber];
	}

	if(mobilePhoneNumber != nil && mobilePhoneNumber != NULL && (NSNull *)mobilePhoneNumber != [NSNull null]){
		mobilePhoneNumber = [mobilePhoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		mobilePhoneNumber = [mobilePhoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
		[phones addObject:mobilePhoneNumber];
	}
		
	phonePickerDataSource.wwwPickerArray = phones;
	
	phonePickerView.delegate = phonePickerDataSource;
	phonePickerView.dataSource = phonePickerDataSource;
	
	// add this picker to our view controller, initially hidden
	phonePickerView.hidden = YES;
	
	[self.view addSubview:phonePickerView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self createPicker];
	
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
		self.tags.text = tagText;
	}
	else {
		self.tags.hidden = true;
	}
	
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

- (void)showPicker:(UIView *)picker
{
	// hide the current picker and show the new one
	if (currentPicker)
	{
		currentPicker.hidden = YES;
	}
	picker.hidden = NO;
	
	currentPicker = picker;	// remember the current picker so we can remove it later when another one is chosen
}


- (IBAction)togglePickers:(id)sender
{
	UISegmentedControl *segControl = sender;
	switch (segControl.selectedSegmentIndex)
	{
		case 0:	// WWW UIPickerView
		{
			if(currentPicker2 == 0){
				currentPicker.hidden = YES;
				break;
			}
			[self showPicker:wwwPickerView];
			currentPicker2 = 0;
			break;
		}
		case 1: // Phone UIPickerView
		{	
			if(currentPicker2 == 1){
				currentPicker.hidden = YES;
				break;
			}
			[self showPicker:phonePickerView];
			currentPicker2 = 1;
			break;			
		}
	}
}

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


- (void)viewDidUnload
{
	[super viewDidUnload];
	
	// release and set out IBOutlets to nil
	self.buttonBarSegmentedControl = nil;
	self.wwwPickerView = nil;
	self.wwwPickerDataSource = nil;
}

- (void)dealloc {
	[selectedRisto release];
	[address release];
	[tags release];
	[ristoranteName release];
	[description release];
	[wwwPickerDataSource release];
	[wwwPickerView release];
	[phonePickerDataSource release];
	[phonePickerView release];
	[buttonBarSegmentedControl release];
    [super dealloc];
}

@end

