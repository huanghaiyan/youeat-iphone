//
//  LoggedUser.h
//  YouEat
//
//  Created by Alessandro Vincelli on 7/4/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggedUser : NSObject {

}

+ (NSString*)loggedUserID;
+ (void)setloggedUserID:(NSString*)newLoggedUserID;

@end
