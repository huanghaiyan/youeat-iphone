//
//  AVREsourcesUtil.m
//  youeat
//
//  Created by Alessandro Vincelli on 11/1/11.
//  Copyright (c) 2011 Wedjaa. All rights reserved.
//

#import "AVREsourcesUtil.h"

@implementation AVREsourcesUtil


+ (NSString *)getConnectionUrl {
	NSString *connectionURL = [[NSString alloc] init];
    NSString *connectionURLDataPath = [[NSBundle mainBundle] pathForResource:@"YouEat" ofType:@"plist"];
    NSDictionary *array = [[NSDictionary alloc] initWithContentsOfFile:connectionURLDataPath];
    connectionURL = [[NSString alloc] initWithFormat:@"%@://%@:%@%@", [array objectForKey:@"protocol"], [array objectForKey:@"host"], [array objectForKey:@"port"], [array objectForKey:@"basePath"]];
	return connectionURL;
}

+ (int) getElemenentPerPage{
    NSString *connectionURLDataPath = [[NSBundle mainBundle] pathForResource:@"YouEat" ofType:@"plist"];
    NSDictionary *array = [[NSDictionary alloc] initWithContentsOfFile:connectionURLDataPath];
    return [(NSNumber*)[array objectForKey:@"elementPerPage"] intValue];                                                                                                  
}


@end
