//
//  RestUtil.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "RestUtil.h"
#import "JSON/JSON.h"

@implementation RestUtil

@synthesize connectionURL;

- (NSDictionary*) sendRestRequest:(NSString *)url{	
	NSURLRequest *request;
	NSDictionary *statuses;	
	
	SBJSON *parser = [[SBJSON alloc] init];
	
	NSString *urlString = [[self connectionURL] stringByAppendingString:url]; 
	request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];	
	
	//	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	// Perform request and get JSON back as a NSData object
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	
	// Get JSON as a NSString from NSData response
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	// parse the JSON response into an object
	// Here we're using NSArray since we're parsing an array of JSON status objects
	statuses = [parser objectWithString:json_string error:nil];
	[parser release];
	return statuses;
}

- (NSString *)connectionURL {
	
	if (connectionURL == nil) {
		connectionURL = [[NSString alloc] init];
		// Get the temperature data from the TemperatureData property list.
		NSString *connectionURLDataPath = [[NSBundle mainBundle] pathForResource:@"YouEat" ofType:@"plist"];
		NSDictionary *array = [[NSDictionary alloc] initWithContentsOfFile:connectionURLDataPath];
		connectionURL = [[NSString alloc] initWithFormat:@"%@://%@:%@%@", [array objectForKey:@"protocol"], [array objectForKey:@"host"], [array objectForKey:@"port"], [array objectForKey:@"basePath"]];
		[array release];
	}
	return connectionURL;
}

- (void)dealloc {
	[connectionURL release];
    [super dealloc];
}

@end
