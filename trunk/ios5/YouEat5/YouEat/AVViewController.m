//
//  AVViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 10/14/11.
//  Copyright (c) 2011 Wedjaa. All rights reserved.
//

#import "AVViewController.h"
#import "ListRestaurants.h"
#import "AboutViewController.h"
#import "AVREsourcesUtil.h"

@implementation AVViewController

@synthesize restUtil, listOfRisto, alertView, searchInput, locationManager, location, aboutBtn;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void) searchBarSearchButtonClicked:(UIButton *)uiButton {
    UIImage *backgroundImage = [UIImage imageNamed:@"bg-alert.png"];
    alertView = [[JKCustomAlert alloc] initWithImage:backgroundImage text:NSLocalizedString(@"Searching restaurants", nil) delegate: self];
    [alertView show];
    [alertView setAlertActionDelegate:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//  	[restUtil searchRisto:@"pizzeria": location];
  	[restUtil searchRisto:searchInput.text: 0: [AVREsourcesUtil getElemenentPerPage]: location];
}

- (void) goToAbout:(UIButton *)uiButton {
    [self performSegueWithIdentifier:@"home2about" sender:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    restUtil = [[RestUtil alloc] init];
    [restUtil setDelegate:self];
    self.navigationItem.title = @"YouEat";
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [self.view setBackgroundColor:background];
    
    // SEARCH button
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchBtn setFrame:CGRectMake(80.0f, 220.0f, 160.0f, 35.0f)];
    [searchBtn setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBarSearchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    
    // SEARCH title label
    UILabel *searchTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 250.0f, 18.0f)];
    [searchTitle setText:NSLocalizedString(@"Search restaurants around your position", nil)];
    [searchTitle setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [searchTitle setTextColor:[UIColor grayColor]];
    [searchTitle setAdjustsFontSizeToFitWidth:YES];
    
    
    // SEARCH INPUT
    [self setSearchInput: [[UITextField alloc] init]];
    [searchInput setFrame:CGRectMake(10.0f, 40.0f, 260.0f, 30.0f)];
    [searchInput setPlaceholder:NSLocalizedString(@"name, city, tag", nil)];
    [searchInput setDelegate: self];
    [searchInput setBorderStyle:UITextBorderStyleRoundedRect];
    
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
    
    // ABOUT button
    aboutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [aboutBtn setFrame:CGRectMake(280.0f, 350.0f, 17.0f, 80.0f)];
    [aboutBtn setTitle:@"About" forState:UIControlStateNormal];
    [aboutBtn setBackgroundImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
    [aboutBtn addTarget:self action:@selector(goToAbout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aboutBtn];
    
    // Starts the location system
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    // Once configured, the location manager must be "started".
#if	DEBUG
    NSLog(@"startUpdatingLocation");
#endif    
    [self setLocation: locationManager.location];
  	[locationManager startUpdatingLocation];
	[locationManager startMonitoringSignificantLocationChanges];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier compare: @"home2ristolist"] == NSOrderedSame){
        [segue.destinationViewController setLocation:location];  
        [segue.destinationViewController setPattern:searchInput.text];  
        [segue.destinationViewController setRistos:listOfRisto];    
    }    
}

- (void)responseParsed: (NSArray*)array{
    [self setListOfRisto:array];
#if	DEBUG
    NSLog(@"listOfRisto count = %u", [listOfRisto count]);
#endif
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self performSegueWithIdentifier:@"home2ristolist" sender:self];
}

- (void)errorOccuredRestUtil: (NSError*)error{
    [alertView setAlertText: [error localizedDescription]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
#if	DEBUG
    NSLog(@"Location updated ");  
#endif
    [self setLocation:newLocation];
    [[self locationManager] stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
#if	DEBUG    
    NSLog(@"Error updating the location %@", [error localizedFailureReason] );  
#endif
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    UITouch *theTouch = [touches anyObject];
    
//    CGPoint endPoint = [theTouch locationInView:self.view];
    
//    xCoord.text = [NSString stringWithFormat:@"start = %f, %f", startPoint.x, startPoint.y];
//    yCoord.text = [NSString stringWithFormat:@"end = %f, %f", endPoint.x, endPoint.y];
}

- (void)viewDidUnload
{
    [super viewDidUnload];    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)stopRequestEvent{
    [restUtil stopRestRequest];
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
