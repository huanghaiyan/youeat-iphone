//
//  URLUtil.m
//  YouEat
//
//  Created by Alessandro Vincelli on 7/1/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "URLUtil.h"


@implementation URLUtil

+ (NSString *)getConnectionUrl {
	NSString *connectionURL = [[NSString alloc] init];
	// Get the temperature data from the TemperatureData property list.
	NSString *connectionURLDataPath = [[NSBundle mainBundle] pathForResource:@"YouEat" ofType:@"plist"];
	NSDictionary *array = [[NSDictionary alloc] initWithContentsOfFile:connectionURLDataPath];
	connectionURL = [[NSString alloc] initWithFormat:@"%@://%@:%@%@", [array objectForKey:@"protocol"], [array objectForKey:@"host"], [array objectForKey:@"port"], [array objectForKey:@"basePath"]];
	[array release];
	return connectionURL;
}

@end
