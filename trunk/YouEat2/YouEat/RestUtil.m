//
//  RestUtil.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "RestUtil.h"


@implementation RestUtil

@synthesize connectionURL, delegate;

- (id)init
{
    self = [super init];
    if (self) {
        _parser = [[SBJsonParser alloc] init];
        _writer = [[SBJsonWriter alloc] init];
        _writer.humanReadable = YES;
        _writer.sortKeys = YES;
        // We don't want *all* the individual messages from the
        // SBJsonStreamParser, just the top-level objects. The stream
        // parser adapter exists for this purpose.
        _adapter = [[SBJsonStreamParserAdapter alloc] init];
        
        // Set ourselves as the delegate, so we receive the messages
        // from the adapter.
        _adapter.delegate = self;
        
        // Create a new stream parser..
        _streamParser = [[SBJsonStreamParser alloc] init];
        
        // .. and set our adapter as its delegate.
        _streamParser.delegate = _adapter;
        
        // Normally it's an error if JSON is followed by anything but
        // whitespace. Setting this means that the parser will be
        // expecting the stream to contain multiple whitespace-separated
        // JSON documents.
        _streamParser.supportMultipleDocuments = YES;

    }
    return self;
}

- (void) sendRestRequest:(NSString *)url{	
	NSString *urlString = [[self connectionURL] stringByAppendingString:url]; 
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:60.0];	
	[[[NSURLConnection alloc] initWithRequest:theRequest delegate:self] autorelease];
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

#pragma mark SBJsonStreamParserAdapterDelegate methods

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
    [NSException raise:@"unexpected" format:@"Should not get here"];
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
    // contains the list of NSDictionary(Risto Details)
    //TODO send the temposs to calling paged
    //TODO ristorantePositionAndDistanceList
    NSArray *temposs = [dict objectForKey:@"ristorantePositionAndDistanceList"];
    [delegate responseParsed:temposs];
    NSLog(@"Connection didReceiveResponse: %@ ", [dict objectForKey:@"ristorantePositionAndDistanceList"]);
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
	
	// Parse the new chunk of data. The parser will append it to
	// its internal buffer, then parse from where it left off in
	// the last chunk.
    SBJsonStreamParserStatus status = [_streamParser parse:data];
    
    if (status == SBJsonStreamParserError) {
        //tweet.text = [NSString stringWithFormat: @"The parser encountered an error: %@", _streamParser.error];
        NSLog(@"Parser error: %@", _streamParser.error);
        
    } else if (status == SBJsonStreamParserWaitingForData) {
        NSLog(@"Parser waiting for more data");
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    	NSLog(@"Connection connectionDidFinishLoading");
}

- (void)dealloc
{
    NSLog(@"dealloc REstUtil");
    _adapter.delegate = nil;
    _streamParser.delegate = nil;
    [_parser release];
    [_writer release];
    [_streamParser release];
    [_adapter release];
  	[connectionURL release];
    [super dealloc];
}

@end
