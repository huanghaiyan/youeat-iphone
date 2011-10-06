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
    self.navigationItem.title = @"your title";
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
        cell =
        [[[UITableViewCell alloc]
          initWithFrame:CGRectZero
          reuseIdentifier:CellIdentifier]
         autorelease];
    }
    UILabel *topLabel =
    [[[UILabel alloc]
      initWithFrame:
      CGRectMake(
                 cell.indentationWidth,
                 5.0f,
                 cell.frame.size.width,
                 20.0f)]
     autorelease];
    topLabel.text = [ristoItem objectForKey:@"name"];
    [cell.contentView addSubview:topLabel];

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
