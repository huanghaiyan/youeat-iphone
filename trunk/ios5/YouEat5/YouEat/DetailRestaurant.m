//
//  DetailRestaurant.m
//  YouEat
//
//  Created by Alessandro Vincelli on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailRestaurant.h"


@implementation DetailRestaurant
@synthesize ristoItem, distanceInMeters, ristoPosition, navigationItem, navigationBar, tw, ristos, location, pattern;


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
    tw = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, self.view.frame.size.width, self.view.frame.size.height - 30.0f)];
    [tw setDelegate:self];
    [tw setDataSource:self];
    [self.view addSubview:tw];
    
    navigationItem = [[UINavigationItem alloc] initWithTitle:[ristoItem objectForKey:@"name"]];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back to results",nil) style:UIBarButtonItemStylePlain target:self action:@selector(goBackResults:)];
    [navigationItem setLeftBarButtonItem: backButton];
    
    navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 40.0f)];
    [navigationBar setDelegate: self];
    [navigationBar setItems:[[NSArray alloc] initWithObjects:navigationItem, nil]];;
    [navigationBar setBarStyle:UIBarStyleBlack];
    //[navigationBar setTranslucent:YES];
    [navigationBar setOpaque:YES];
    [self.view addSubview:navigationBar];
    
    [self setNavigationBar:navigationBar];
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

- (void) goBackResults:(UIButton *)uiButton {
    [self performSegueWithIdentifier:@"ristodetails2ristolist" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier compare: @"ristodetails2ristolist"] == NSOrderedSame){
        [segue.destinationViewController setRistos:ristos];
        [segue.destinationViewController setLocation:location];
        [segue.destinationViewController setPattern:pattern];        
    }    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    // objects TO be CACHED
    NSNumber *rating = [ristoItem objectForKey:@"rating"];
    UIImage *star = [UIImage imageNamed:@"star-gold-mini.png"];
    UIImage *starOff = [UIImage imageNamed:@"star-gold-mini-off.png"];
    UIColor *backgroundImg = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"logo-mela-160.png"]];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (indexPath.row == 0) {        
            // TOP LABEL - TITLE
            UILabel *topLabel = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth, 2.0f, cell.frame.size.width - (cell.indentationWidth * 2), 18.0f)];
            topLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
            [topLabel setFont:[UIFont fontWithName:@"Verdana-Bold" size:[UIFont systemFontSize]]];
            [topLabel setTextColor: [UIColor colorWithRed:0.9 green:0.4 blue:0.0 alpha:1]];
            topLabel.adjustsFontSizeToFitWidth = YES;	
            topLabel.text = [ristoItem objectForKey:@"name"];
            [cell.contentView addSubview:topLabel];
            // ADDRESS and DISTANCE LABEL
            UILabel *addrLabel = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth, 20.0f, cell.frame.size.width, 15.0f)];
            [addrLabel setFont:[UIFont fontWithName:@"Verdana" size:[UIFont smallSystemFontSize]]];
            addrLabel.adjustsFontSizeToFitWidth = YES;
            NSString *city = [[ristoItem objectForKey:@"city"] objectForKey:@"name"];
            NSString *address = [ristoItem objectForKey:@"address"];
            int intDistance = distanceInMeters.intValue > 1000 ? distanceInMeters.intValue / 1000 : distanceInMeters.intValue;
            NSString *distance = [NSString stringWithFormat: @"%u%@", intDistance, (distanceInMeters.intValue > 1000) ? @"km" : @"m"];
            addrLabel.text = [NSString stringWithFormat:@"%@, %@ - %@", city, address, distance]; 
            [cell.contentView addSubview:addrLabel];
            // RATING STARS LABEL
            UILabel *starLabel = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth, 35.0f, 10.0f, 10.0f)];
            UIColor *starLabelImg = [[UIColor alloc] initWithPatternImage: (rating.intValue) < 1 ? starOff : star ];
            [starLabel setBackgroundColor:starLabelImg];
            [cell.contentView addSubview:starLabel];
            UILabel *starLabel2 = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth + 12.0f, 35.0f, 10.0f, 10.0f)];
            UIColor *starLabelImg2 = [[UIColor alloc] initWithPatternImage: rating.intValue < 2 ? starOff : star ];
            [starLabel2 setBackgroundColor:starLabelImg2];
            [cell.contentView addSubview:starLabel2];
            
            UILabel *starLabel3 = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth + 24.0f, 35.0f, 10.0f, 10.0f)];
            UIColor *starLabelImg3 = [[UIColor alloc] initWithPatternImage: rating.intValue < 3 ? starOff : star ];
            [starLabel3 setBackgroundColor:starLabelImg3];
            [cell.contentView addSubview:starLabel3];
            
            UILabel *starLabel4 = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth + 36.0f, 35.0f, 10.0f, 10.0f)];
            UIColor *starLabelImg4 = [[UIColor alloc] initWithPatternImage: rating.intValue < 4 ? starOff : star ];
            [starLabel4 setBackgroundColor:starLabelImg4];
            [cell.contentView addSubview:starLabel4];
            
            UILabel *starLabel5 = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth + 48.0f, 35.0f, 10.0f, 10.0f)];
            UIColor *starLabelImg5 = [[UIColor alloc] initWithPatternImage: rating.intValue < 5 ? starOff : star ];
            [starLabel5 setBackgroundColor:starLabelImg5];
            [cell.contentView addSubview:starLabel5];
        }
        
        else if (indexPath.row == 1) {                
            // IMG LABEL
            UILabel *imgLabel = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth, 2.0f, 80.0f, 80.0f)];
            //    UIImage *backgroundImage = [UIImage imageNamed:@"logo-mela-trasp-160.png"];
            [imgLabel setBackgroundColor:backgroundImg];
            [cell.contentView addSubview:imgLabel];
            
        }

        else if (indexPath.row == 2) {
            // PHONE NUMBER
            NSString *phoneNumber = [ristoItem objectForKey:@"phoneNumber"];
            if(phoneNumber != nil && phoneNumber != NULL && (NSNull *)phoneNumber != [NSNull null]){
                phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
                UIButton *callPhoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

                [callPhoneButton setFrame:CGRectMake((float)((cell.frame.size.width - 150) / 2), 2.0f, 150.0f, 44.0f)];
                [callPhoneButton setTitle:phoneNumber forState:UIControlStateNormal];
                callPhoneButton.titleLabel.font            = [UIFont fontWithName:@"Verdana-Bold" size:[UIFont systemFontSize]];
                callPhoneButton.titleLabel.lineBreakMode   = UILineBreakModeTailTruncation;
                callPhoneButton.titleLabel.adjustsFontSizeToFitWidth = YES;
                [callPhoneButton addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:callPhoneButton];
            }
        }
        else if (indexPath.row == 3) {
            // EMAIL
            NSString *email = [ristoItem objectForKey:@"email"];
            if(email != nil && email != NULL && (NSNull *)email != [NSNull null]){
                UILabel *emailLabel = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth, 2.0f, cell.frame.size.width, 18.0f)];
                [emailLabel setFont:[UIFont fontWithName:@"Verdana" size:[UIFont smallSystemFontSize]]];
                emailLabel.adjustsFontSizeToFitWidth = YES;	
                emailLabel.text = email;
                [cell.contentView addSubview:emailLabel];
            }
        }
        
        else if (indexPath.row == 4) {
            // WWW
            NSString *www = [ristoItem objectForKey:@"www"];
            if(www != nil && www != NULL && (NSNull *)www != [NSNull null]){
                UILabel *wwwLabel = [[UILabel alloc] initWithFrame: CGRectMake(cell.indentationWidth, 2.0f, cell.frame.size.width, 18.0f)];
                [wwwLabel setFont:[UIFont fontWithName:@"Verdana" size:[UIFont smallSystemFontSize]]];
                wwwLabel.adjustsFontSizeToFitWidth = YES;	
                wwwLabel.text = www;
                [cell.contentView addSubview:wwwLabel];
            }
            
        }
        else if (indexPath.row == 5) {
            // DESCRIPTION LABEL
            NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
            UITextView *descriptionView = [[UITextView alloc] initWithFrame: CGRectMake(cell.indentationWidth, 2.0f, cell.frame.size.width - (cell.indentationWidth * 2) , 77.0f)];
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
            [descriptionView setFont:[UIFont fontWithName:@"Verdana" size:[UIFont smallSystemFontSize]]];
            descriptionView.text = descriptionText;
            [cell.contentView addSubview:descriptionView];
        }
        // PHONE LABEL
        //        NSString *phoneNumber = [ristoItem objectForKey:@"phoneNumber"];
        //        if(phoneNumber != nil && phoneNumber != NULL && (NSNull *)phoneNumber != [NSNull null]){
        //            phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //            phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
        //        }
        //        UIButton *callButton = [UIButton buttonWithType: UIButtonTypeCustom];
        //        [callButton setFrame: CGRectMake(cell.indentationWidth + 210.0f, 35.0f, 100.0f, 15.0f)];
        //        [callButton.titleLabel setFont:[UIFont fontWithName:@"Verdana-Bold" size:[UIFont smallSystemFontSize]]];
        //        [callButton setTitle:phoneNumber forState:UIControlStateNormal];
        //        [callButton setTitleColor:[UIColor colorWithRed:0.9 green:0.4 blue:0.0 alpha:1] forState:UIControlStateNormal];
        //        [callButton sizeToFit];
        //        [callButton setTag:indexPath.row];
        //        [callButton addTarget:self action:@selector(callButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        //        [cell.contentView addSubview:callButton];
    
    }
    // Configure the cell...
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 60.0f;        
    }
    else if(indexPath.row == 1){
        return 90.0f;        
    }
    else if(indexPath.row == 2){
        return 50.0f;        
    }
    else if(indexPath.row == 3){
        return 40.0f;        
    }
    else if(indexPath.row == 4){
        return 40.0f;        
    }
    else if(indexPath.row == 5){
        return 100.0f;        
    }
    return 10.0f;
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    if(indexPath.row == 2){
        //TODO phone call
        //[self callPhonenumber];
    }
    
}

-(IBAction)callPhone:(id)sender {    
    NSString *numberToCallOri = [ristoItem objectForKey:@"phoneNumber"];
    NSString *numberToCall = [numberToCallOri stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    numberToCall = [numberToCall stringByReplacingOccurrencesOfString:@" " withString:@""];
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        numberToCall = [NSString stringWithFormat:@"tel://%@", numberToCall];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numberToCall]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
    }    
}


@end
