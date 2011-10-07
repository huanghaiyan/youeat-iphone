//
//  ListRestaurants.m
//  YouEat
//
//  Created by Alessandro Vincelli on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ListRestaurants.h"

@implementation ListRestaurants

@synthesize ristos;

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Results";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"ristos count = %u", [ristos count]);
	return [ristos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
	NSDictionary *ristoItem = [[ristos objectAtIndex:indexPath.row] objectForKey:@"ristorante"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        // PHONE LABEL
        NSString *phoneNumber = [ristoItem objectForKey:@"phoneNumber"];
        if(phoneNumber != nil && phoneNumber != NULL && (NSNull *)phoneNumber != [NSNull null]){
            phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
        }
        UIButton *callButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [callButton setFrame: CGRectMake(cell.indentationWidth + 210.0f, 35.0f, 100.0f, 15.0f)];
        [callButton.titleLabel setFont:[UIFont fontWithName:@"Verdana-Bold" size:[UIFont smallSystemFontSize]]];
        [callButton setTitle:phoneNumber forState:UIControlStateNormal];
        [callButton setTitleColor:[UIColor colorWithRed:0.9 green:0.4 blue:0.0 alpha:1] forState:UIControlStateNormal];
        [callButton sizeToFit];
        [callButton setTag:indexPath.row];
        [callButton addTarget:self action:@selector(callButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:callButton];
    }
    // TOP LABEL - TITLE
    UILabel *topLabel = [[[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth, 2.0f, cell.frame.size.width, 18.0f)] autorelease];
    topLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    [topLabel setFont:[UIFont fontWithName:@"Verdana-Bold" size:[UIFont smallSystemFontSize]]];
    [topLabel setTextColor: [UIColor colorWithRed:0.9 green:0.4 blue:0.0 alpha:1]];
    topLabel.adjustsFontSizeToFitWidth = YES;	
    topLabel.text = [ristoItem objectForKey:@"name"];
    [cell.contentView addSubview:topLabel];
    
    // ADDRESS and DISTANCE LABEL
    UILabel *addrLabel = [[[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth, 20.0f, cell.frame.size.width, 10.0f)] autorelease];
    [addrLabel setFont:[UIFont fontWithName:@"Verdana" size:[UIFont smallSystemFontSize] - 4 ]];
    addrLabel.adjustsFontSizeToFitWidth = YES;
    NSString *city = [[ristoItem objectForKey:@"city"] objectForKey:@"name"];
    NSString *address = [ristoItem objectForKey:@"address"];
    NSDecimalNumber *distanceInMeters = [[ristos objectAtIndex:indexPath.row] objectForKey:@"distanceInMeters"];
    int intDistance = distanceInMeters.intValue > 1000 ? distanceInMeters.intValue / 100 : distanceInMeters.intValue;
    NSString *distance = [NSString stringWithFormat: @"%u%@", intDistance, (distanceInMeters.intValue > 1000) ? @"km" : @"m"];
    addrLabel.text = [NSString stringWithFormat:@"%@, %@ - %@", city, address, distance]; 
    [cell.contentView addSubview:addrLabel];

    
    // IMG LABEL
    UILabel *imgLabel = [[[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth, 35.0f, 80.0f, 80.0f)] autorelease];
    [imgLabel setBackgroundColor:[UIColor lightGrayColor]];
    [cell.contentView addSubview:imgLabel];

    // RATING STARS LABEL
    NSNumber *rating = [ristoItem objectForKey:@"rating"];
    UIImage *star = [UIImage imageNamed:@"star-gold-mini.png"];
    UIImage *starOff = [UIImage imageNamed:@"star-gold-mini-off.png"];
    
    UILabel *starLabel = [[[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth + 90.0f, 35.0f, 10.0f, 10.0f)] autorelease];
    UIColor *starLabelImg = [[[UIColor alloc] initWithPatternImage: (rating.intValue) < 1 ? starOff : star ] autorelease];
    [starLabel setBackgroundColor:starLabelImg];
    [cell.contentView addSubview:starLabel];
    
    UILabel *starLabel2 = [[[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth + 102.0f, 35.0f, 10.0f, 10.0f)] autorelease];
    UIColor *starLabelImg2 = [[[UIColor alloc] initWithPatternImage: rating.intValue < 2 ? starOff : star ] autorelease];
    [starLabel2 setBackgroundColor:starLabelImg2];
    [cell.contentView addSubview:starLabel2];
    
    UILabel *starLabel3 = [[[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth + 114.0f, 35.0f, 10.0f, 10.0f)] autorelease];
    UIColor *starLabelImg3 = [[[UIColor alloc] initWithPatternImage: rating.intValue < 3 ? starOff : star ] autorelease];
    [starLabel3 setBackgroundColor:starLabelImg3];
    [cell.contentView addSubview:starLabel3];
    
    UILabel *starLabel4 = [[[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth + 126.0f, 35.0f, 10.0f, 10.0f)] autorelease];
    UIColor *starLabelImg4 = [[[UIColor alloc] initWithPatternImage: rating.intValue < 4 ? starOff : star ] autorelease];
    [starLabel4 setBackgroundColor:starLabelImg4];
    [cell.contentView addSubview:starLabel4];
    
    UILabel *starLabel5 = [[[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth + 138.0f, 35.0f, 10.0f, 10.0f)] autorelease];
    UIColor *starLabelImg5 = [[[UIColor alloc] initWithPatternImage: rating.intValue < 5 ? starOff : star ] autorelease];
    [starLabel5 setBackgroundColor:starLabelImg5];
    [cell.contentView addSubview:starLabel5];

    // DESCRIPTION LABEL
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    UITextView *descriptionView = [[[UITextView alloc] initWithFrame: CGRectMake(cell.indentationWidth + 85.0f, 55.0f, 220.0f, 70.0f)] autorelease];
	NSDictionary *descriptions = [ristoItem objectForKey:@"descriptions"] ;		
	NSString *descriptionText = @"";	
    for (NSDictionary *descriptionItem in descriptions) {
		NSString *descItem = [descriptionItem objectForKey:@"description"];
   		NSString *langItem = [[descriptionItem objectForKey:@"language"] objectForKey:@"language"];
		if([langItem isEqualToString: language] && descItem != NULL && (NSNull *)descItem != [NSNull null] && descItem.length > 0){
			descriptionText = [descriptionText stringByAppendingString:descItem];		
		}

    }
    [descriptionView setEditable: FALSE];
    [descriptionView setFont:[UIFont fontWithName:@"Verdana" size:[UIFont smallSystemFontSize] - 4 ]];
    descriptionView.text = descriptionText;
    [cell.contentView addSubview:descriptionView];
    
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
//		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    //NSString's sizeWithFont:constrainedToSize:lineBreakMode:
//	// Configure the cell.
//	NSDictionary *ristoItem = [[ristos objectAtIndex:indexPath.row] objectForKey:@"ristorante"];
//    cell.textLabel.adjustsFontSizeToFitWidth = YES;
//	cell.textLabel.text = [ristoItem objectForKey:@"name"];
//	NSString *city = [[ristoItem objectForKey:@"city"] objectForKey:@"name"];
//	NSString *address = [ristoItem objectForKey:@"address"];
//	NSString *distance = @"";
//	if([ristos count] > 0 ){
//		NSDictionary *ristoPositionItem = [ristos objectAtIndex:indexPath.row];
//		distance = [distance stringByAppendingString:@""];
//		NSDecimalNumber *distanceInMeters = [ristoPositionItem objectForKey:@"distanceInMeters"];
//		distance = [distance stringByAppendingString:[distanceInMeters stringValue]];
//		distance = [distance stringByAppendingString:@" m."];
//	}
//    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;	
//	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ - %@", distance, city, address]; ;
    return cell;
}

-(void) callButtonPressed: (id)sender
{
	int rowtoCall = [sender tag];
  	NSString *phoneNumberToCall = [[[ristos objectAtIndex:rowtoCall] objectForKey:@"ristorante"] objectForKey:@"phoneNumber"] ;
    phoneNumberToCall = [phoneNumberToCall stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    phoneNumberToCall = [phoneNumberToCall stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
    //TODO attach the call to button above
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumberToCall]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
        [Notpermitted release];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	NSDictionary *selectedRisto = [ristos objectAtIndex:indexPath.row];
//    [self showRisto:selectedRisto animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}

//- (void)showRisto:(NSDictionary *)risto animated:(BOOL)animated {
//	RistoScrollViewController *detailViewController = [[RistoScrollViewController alloc] initWithNibName:@"RistoScrollView" bundle:[NSBundle mainBundle]];
//	detailViewController.selectedRisto = risto;    
//    [self.navigationController pushViewController:detailViewController animated:animated];
//    [detailViewController release];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

@end
