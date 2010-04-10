//
//  YouEatConnection.m
//  YouEat
//
//  Created by Alessandro Vincelli on 10/04/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "YouEatConnection.h"
#import "JSON/JSON.h"

@implementation YouEatConnection


- (NSDictionary*) sendRequest:(NSString *)url{	
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


@end
