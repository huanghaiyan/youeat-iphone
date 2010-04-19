//
//  FirstViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 19/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FirstViewController.h"
#import "JSON/JSON.h"

@implementation FirstViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (NSDictionary*) sendRestRequest:(NSString *)url{	
	NSURLRequest *request;
	NSDictionary *statuses;
	NSString *baseURL = @"http://localhost:8080/rest/";
	
	
	SBJSON *parser = [[SBJSON alloc] init];
	
	NSString *urlString = [baseURL stringByAppendingString:url]; 
	request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];	
	
	//	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	// Perform request and get JSON back as a NSData object
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	
	// Get JSON as a NSString from NSData response
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	// parse the JSON response into an object
	// Here we're using NSArray since we're parsing an array of JSON status objects
	statuses = [parser objectWithString:json_string error:nil];
	return statuses;
}



- (void)dealloc {
    [super dealloc];
}

@end
