// claudy jongstra
//  RistoViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
// farnietoina frabro scalo

#import "RistoViewController.h"
#import "Annotation.h"
#import "RestUtil.h"
#import "UrlUtil.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"


@implementation RistoViewController

@synthesize selectedRisto, address, tags, ristoranteName, mapView,  description, buttonHidePicker;
@synthesize buttonBarSegmentedControl, currentPicker, wwwPickerView, wwwPickerDataSource, phonePickerView, phonePickerDataSource;
@synthesize buttonAddRemoveAsFavourite, buttonITried, request;


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
	//CGSize pickerSize = [wwwPickerView sizeThatFits:CGSizeZero];
	wwwPickerView.frame = CGRectMake(0.0, 128.0, 320.0, 120.0);

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
	
	//wwwPickerDataSource.contentStretch = CGRectMake(0., 0., [self bounds].size.height, [self bounds].size.width);
	
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
	//pickerSize = [phonePickerView sizeThatFits:CGSizeZero];
	phonePickerView.frame = CGRectMake(0.0, 128.0, 320.0, 120.0);
	
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
	[self.view addSubview:phonePickerView];
	
	// add this picker to our view controller, initially hidden
	phonePickerView.hidden = YES;
	
	// Hide picker Button
	buttonHidePicker = [[UIButton alloc] initWithFrame:CGRectZero];
	buttonHidePicker.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	buttonHidePicker.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	buttonHidePicker = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	buttonHidePicker.frame = CGRectMake(55, 136.0, 195.0, 30.0);
	[buttonHidePicker setTitle:@"Hide" forState:UIControlStateNormal];
	buttonHidePicker.hidden = YES;
	[buttonHidePicker addTarget:self action:@selector(hidePicker) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonHidePicker];	
	
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
	buttonHidePicker.hidden = NO;
}

- (void)hidePicker{
	currentPicker.hidden = YES;
	buttonHidePicker.hidden = YES;
	buttonITried.hidden = YES;
	buttonAddRemoveAsFavourite.hidden = YES;
}

- (void)showActions
{

	[self hidePicker];
	// Button I tried
	buttonITried.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	buttonITried.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	buttonITried = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	buttonITried.frame = CGRectMake(55, 176.0, 195.0, 30.0);
	[buttonITried setTitle:@"I tried" forState:UIControlStateNormal];
	buttonITried.hidden = NO;
	[buttonITried addTarget:self action:@selector(sendITriedRequest) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonITried];
	
	// Button Add as favourite
	buttonAddRemoveAsFavourite.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	buttonAddRemoveAsFavourite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	buttonAddRemoveAsFavourite = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	buttonAddRemoveAsFavourite.frame = CGRectMake(55, 216.0, 195.0, 30.0);
	
	[buttonAddRemoveAsFavourite setTitle:@"Add as favorite" forState:UIControlStateNormal];
	[buttonAddRemoveAsFavourite addTarget:self action:@selector(sendAddRestaurantsAsFavouriteRequest) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonAddRemoveAsFavourite];
	buttonHidePicker.hidden = NO;
	[self sendIsFavoriteRestaurantRequest];
}


- (IBAction)togglePickers:(id)sender
{
	buttonITried.hidden = YES;
	buttonAddRemoveAsFavourite.hidden = YES;
	currentPicker.hidden = YES;
	UISegmentedControl *segControl = sender;
	switch (segControl.selectedSegmentIndex)
	{
		case 0:	// WWW UIPickerView
		{
			[self showPicker:wwwPickerView];
			currentPicker2 = 0;
			break;
		}
		case 1: // Phone UIPickerView
		{	
			[self showPicker:phonePickerView];
			currentPicker2 = 1;
			break;			
		}
		case 2: // Actions
		{	
			[self showActions];
			currentPicker2 = 2;
			break;			
		}
			
	}
}

- (IBAction)sendITriedRequest
{
	NSString *url = [URLUtil getConnectionUrl];
	NSString *urlRequest = [NSString stringWithFormat:@"/security/iTriedRestaurants/%@", [selectedRisto objectForKey:@"id"]]; 
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:urlRequest]]]];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(sendITriedRequestComplete:)];
	[request setDidFailSelector:@selector(sendITriedRequestFailed:)];
	[request startAsynchronous];
}

- (IBAction)sendITriedRequestFailed:(ASIHTTPRequest *)theRequest
{
	//
}

- (IBAction)sendITriedRequestComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([request responseStatusCode] == 200);
	if(success){
		//retry the user info
		[self hidePicker];
	}
	else{
		//todo
	}	
}

- (IBAction)sendAddRestaurantsAsFavouriteRequest
{
	NSString *url = [URLUtil getConnectionUrl];
	NSString *urlRequest = [NSString stringWithFormat:@"/security/addOrRemoveRestaurantsAsFavorite/%@", [selectedRisto objectForKey:@"id"]]; 
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:urlRequest]]]];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(sendAddRestaurantsAsFavouriteRequestComplete:)];
	[request setDidFailSelector:@selector(sendAddRestaurantsAsFavouriteRequestFailed:)];
	[request startAsynchronous];
}

- (IBAction)sendAddRestaurantsAsFavouriteRequestFailed:(ASIHTTPRequest *)theRequest
{
	//
}

- (IBAction)sendAddRestaurantsAsFavouriteRequestComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([request responseStatusCode] == 200);
	if(success){
		//retry the user info
		[self hidePicker];
	}
	else{
		//todo
	}	
}

- (IBAction)sendIsFavoriteRestaurantRequest
{
	
	NSString *url = [URLUtil getConnectionUrl];
	NSString *urlRequest = [NSString stringWithFormat:@"/security/isFavoriteRestaurant/%@", [selectedRisto objectForKey:@"id"]]; 
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:urlRequest]]]];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(sendIsFavoriteRestaurantRequestComplete:)];
	[request setDidFailSelector:@selector(sendIsFavoriteRestaurantRequestFailed:)];
	[request startAsynchronous];
}

- (IBAction)sendIsFavoriteRestaurantRequestFailed:(ASIHTTPRequest *)theRequest
{
	//
}

- (IBAction)sendIsFavoriteRestaurantRequestComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([request responseStatusCode] == 200);
//	[indicatorView stopAnimating];
	if(success){
		SBJSON *parser = [[SBJSON alloc] init];
		NSString *json_string = [[NSString alloc] initWithData:[theRequest responseData] encoding:NSUTF8StringEncoding];
		NSDictionary *statuses = [parser objectWithString:json_string error:nil];
		NSDictionary *response = [statuses objectForKey:@"youEatBooleanResponse"];
		if([response objectForKey:@"response"]){
			[buttonAddRemoveAsFavourite setTitle:@"Remove as favorite" forState:UIControlStateNormal];
		}
		else {
			[buttonAddRemoveAsFavourite setTitle:@"Add as favorite" forState:UIControlStateNormal];
		}
	}
	else{
		//todo
	}	
}

#pragma mark -
#pragma mark Table view data source



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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
	[buttonITried release];
	[buttonAddRemoveAsFavourite release];
	[request release];
    [super dealloc];
}

@end

