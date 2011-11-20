//
//  RestUtil.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "RestUtil.h"
#import "AVREsourcesUtil.h"

@implementation RestUtil

@synthesize connectionURL, delegate, receivedData, theConnection;

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
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }
}

- (void) stopRestRequest{	
    [theConnection cancel];
}

- (NSString *)connectionURL {
	if (connectionURL == nil) {
        connectionURL = [AVREsourcesUtil getConnectionUrl];
	}
	return connectionURL;
}

- (void) searchRisto:(NSString *)searchText: (int) firstResult: (int) maxResults: (CLLocation*) location{
	
	NSString *urlString = @"";
	NSString *pattern = [searchText stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
	if(location == nil) {
        //findPaginatedRistoranti/{pattern}/{firstResult}/{maxResults}
        urlString = [NSString stringWithFormat:@"/findFreeTextSearchCloseRistoranti/%@/%@/%@/%@/%@/%@", pattern, @"1", @"1", @"9000", firstResult, maxResults];
	}
    else if(location != nil) {
        NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        //findFreeTextSearchCloseRistoranti/{pattern}/{latitude}/{longitude}/{distanceInMeters}/{firstResult}/{maxResults}
        urlString = [NSString stringWithFormat:@"/findFreeTextSearchCloseRistoranti/%@/%@/%@/%@/%d/%d", pattern, latitude, longitude, @"9000", firstResult, maxResults]; 
        
    }
#if	DEBUG
   	NSLog(@"urlString: %@", urlString);
#endif
    [self sendRestRequest:urlString];
    
}


#pragma mark NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
#if	DEBUG
	NSLog(@"Connection didReceiveResponse: %@ - %@", response, [response MIMEType]);
#endif
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Connection didReceiveAuthenticationChallenge: %@", challenge);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
#if	DEBUG
	NSLog(@"Connection didReceiveData of length: %u", data.length);
#endif
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    [delegate errorOccuredRestUtil:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
#if	DEBUG
   	NSLog(@"Connection connectionDidFinishLoading");
#endif
    NSError *myError = nil;
    NSDictionary *dict	= [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:&myError];
    NSArray *temposs = [dict objectForKey:@"ristorantePositionAndDistanceList"];
#if	DEBUG    
    NSLog(@"Connection didReceiveResponse: %@ ", [dict objectForKey:@"ristorantePositionAndDistanceList"]);
#endif
    [delegate responseParsed:temposs];
}

@end
