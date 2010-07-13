//
//  IconUtil.m
//  YouEat
//
//  Created by Alessandro Vincelli on 7/13/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "IconUtil.h"

@implementation IconUtil

+ (NSString*) getActivityIcon:(NSString*)activityType{
	if ([activityType caseInsensitiveCompare: @"modified"] == NSOrderedSame) {
		return @"pencil_64.png";
	} else if ([activityType caseInsensitiveCompare: @"voted"] == NSOrderedSame){
		return @"voted.png";
	} else if ([activityType caseInsensitiveCompare: @"ate here"] == NSOrderedSame){
		return @"tick_64.png";
	} else if ([activityType caseInsensitiveCompare: @"added as favourite"] == NSOrderedSame){
		return @"clip.png";
	} else if ([activityType caseInsensitiveCompare: @"removed as favourite"] == NSOrderedSame){
		return @"removed-clip.png";
	}
	return @"plus_64.png";
}

@end
