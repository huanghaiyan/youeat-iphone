//
//  YouEatViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YouEatViewController.h"
#import "ListRestaurants.h"

@implementation YouEatViewController
@synthesize restUtil, listOfRisto, alertView, searchInput, locationManager, location;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void) searchRisto:(NSString *)searchText{
	
	NSString *urlString = @"";
	NSString *pattern = [searchText stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];

	if([searchText length] > 2 && location == nil) {
        //findPaginatedRistoranti/{pattern}/{firstResult}/{maxResults}
        urlString = [NSString stringWithFormat:@"/findFreeTextSearchCloseRistoranti/%@/%@/%@/%@/%@/%@", pattern, @"1", @"1", @"900000000000", @"0", @"20"];         
	}
    else if([searchText length] > 2 && location != nil) {
        NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        //findFreeTextSearchCloseRistoranti/{pattern}/{latitude}/{longitude}/{distanceInMeters}/{firstResult}/{maxResults}
        urlString = [NSString stringWithFormat:@"/findFreeTextSearchCloseRistoranti/%@/%@/%@/%@/%@/%@", pattern, latitude, longitude, @"90000000000", @"0", @"20"]; 
        
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //performs the search
    [restUtil sendRestRequest:urlString];

}

- (void) searchBarSearchButtonClicked:(UIButton *)uiButton {
    UIImage *backgroundImage = [UIImage imageNamed:@"bg-alert.png"];
    alertView = [[JKCustomAlert alloc] initWithImage:backgroundImage text:NSLocalizedString(@"Ricerca ristoranti in corso", nil) delegate: self];
    [alertView show];
  	[self searchRisto:@"pizzeria"];
//	[self searchRisto:searchInput.text];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"YouEat";
  	restUtil = [[[RestUtil alloc] init] retain ];
    [restUtil setDelegate:self];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [self.view setBackgroundColor:background];
    [background release];

    // SEARCH button
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchBtn setFrame:CGRectMake(80.0f, 220.0f, 160.0f, 30.0f)];
    [searchBtn setTitle:@"Cerca" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBarSearchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];

    
    // SEARCH title label
    UILabel *searchTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 100.0f, 15.0f)];
    [searchTitle setText:@"Search risto"];
    [searchTitle setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [searchTitle setTextColor:[UIColor grayColor]];

    
    // SEARCH INPUT
    [self setSearchInput: [[UITextField alloc] init]];
    [searchInput setFrame:CGRectMake(10.0f, 40.0f, 260.0f, 30.0f)];
    [searchInput setPlaceholder:@"Search by name, city, tag"];
    [searchInput setDelegate: self];
    [searchInput setBorderStyle:UITextBorderStyleRoundedRect];
    [searchInput release];
    
    // SEARCH Background label
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 100.0f, 280.0f, 100.0f)];
    CAGradientLayer* lay = [CAGradientLayer layer];
    lay.colors = [NSArray arrayWithObjects:
                  (id)[UIColor colorWithWhite:1 alpha:1].CGColor,
                  [UIColor colorWithRed:0.9 green:0.3 blue:0.0 alpha:0].CGColor, nil];
    lay.frame = v.layer.bounds;
    [v.layer addSublayer:lay];
    lay.borderWidth = 0.5;
    lay.borderColor = [UIColor grayColor].CGColor;
    lay.cornerRadius = 8;
    
    [v addSubview:searchInput];
    [v addSubview:searchTitle];
    [self.view addSubview:v];

    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    // Once configured, the location manager must be "started".
    NSLog(@"startUpdatingLocation");
    [self setLocation: locationManager.location];
  	[locationManager startUpdatingLocation];
	[locationManager startMonitoringSignificantLocationChanges];
	NSLog(@"END searchCloseRistorantiView");
    
}

- (void)responseParsed: (NSArray*)array{
    [self setListOfRisto:array];
    NSLog(@"listOfRisto count = %u", [listOfRisto count]);
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    ListRestaurants *ristos = [[[ListRestaurants alloc] initWithStyle: UITableViewStylePlain] autorelease];
    [ristos setRistos:listOfRisto];
    [[self navigationController] pushViewController: ristos animated: YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"Location updated ");  
    [self setLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error updating the location %@", [error localizedFailureReason] );  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   	[restUtil release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)stopRequestEvent{
    [alertView retain];
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [alertView release];
}

@end
