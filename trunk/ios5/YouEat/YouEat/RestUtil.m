//
//  RestUtil.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "RestUtil.h"

@implementation RestUtil

@synthesize connectionURL, delegate, receivedData;

- (id)init
{
    self = [super init];
    if (self) {


    }
    return self;
}

- (void) sendRestRequest:(NSString *)url{	
	NSString *urlString = [[self connectionURL] stringByAppendingString:url]; 
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:60.0];	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }
}

- (NSString *)connectionURL {
	
	if (connectionURL == nil) {
		connectionURL = [[NSString alloc] init];
		// Get the temperature data from the TemperatureData property list.
		NSString *connectionURLDataPath = [[NSBundle mainBundle] pathForResource:@"YouEat" ofType:@"plist"];
		NSDictionary *array = [[NSDictionary alloc] initWithContentsOfFile:connectionURLDataPath];
		connectionURL = [[NSString alloc] initWithFormat:@"%@://%@:%@%@", [array objectForKey:@"protocol"], [array objectForKey:@"host"], [array objectForKey:@"port"], [array objectForKey:@"basePath"]];
	}
	return connectionURL;
}

- (void) searchRisto:(NSString *)searchText: (CLLocation*) location{
	
	NSString *urlString = @"";
	NSString *pattern = [searchText stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
	if([searchText length] > 2 && location == nil) {
        //findPaginatedRistoranti/{pattern}/{firstResult}/{maxResults}
        urlString = [NSString stringWithFormat:@"/findFreeTextSearchCloseRistoranti/%@/%@/%@/%@/%@/%@", pattern, @"1", @"1", @"90000", @"0", @"40"];
	}
    else if([searchText length] > 2 && location != nil) {
        NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        //findFreeTextSearchCloseRistoranti/{pattern}/{latitude}/{longitude}/{distanceInMeters}/{firstResult}/{maxResults}
        urlString = [NSString stringWithFormat:@"/findFreeTextSearchCloseRistoranti/%@/%@/%@/%@/%@/%@", pattern, latitude, longitude, @"90000", @"0", @"40"]; 
        
    }
    [self sendRestRequest:urlString];
    
}


#pragma mark NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Connection didReceiveResponse: %@ - %@", response, [response MIMEType]);
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Connection didReceiveAuthenticationChallenge: %@", challenge);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Connection didReceiveData of length: %u", data.length);
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
   	NSLog(@"Connection connectionDidFinishLoading");
    NSError *myError = nil;
    NSDictionary *dict	= [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:&myError];
    NSArray *temposs = [dict objectForKey:@"ristorantePositionAndDistanceList"];
    NSLog(@"Connection didReceiveResponse: %@ ", [dict objectForKey:@"ristorantePositionAndDistanceList"]);
    [delegate responseParsed:temposs];
    //NSLog(@"Parser error: %@", myError.description);
}

@end
