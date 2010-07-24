//
//  AccountViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 6/29/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;	

@interface LoggedUserViewController : UITableViewController <UINavigationBarDelegate>{
	UITableView *tableViewMenu;
	bool *islogged;
}

- (void)showLogin;
- (void)cancelLogin;

@property (nonatomic, retain) IBOutlet UITableView *tableViewMenu;
@property (nonatomic) bool *islogged;

@end
