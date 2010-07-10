//
//  LoggedUser.m
//  YouEat
//
//  Created by Alessandro Vincelli on 7/4/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "LoggedUser.h"

static NSString* loggedUserID;

@implementation LoggedUser

+ (NSString*)loggedUserID {
    return loggedUserID;
}

+ (void)setloggedUserID:(NSString*)newLoggedUserID {
    if (loggedUserID != newLoggedUserID) {
        [loggedUserID release];
        loggedUserID = [newLoggedUserID copy];
    }
}
@end
