//
//  RistoViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RistoViewController : UIViewController {
	
	UILabel *ristoranteName;
	UILabel *tags;
	UILabel *address;
//	UIButton *phoneButton;
	NSDictionary *selectedRisto;
}

@property (nonatomic, retain) NSDictionary *selectedRisto;
@property (nonatomic, retain) IBOutlet UILabel *address;
@property (nonatomic, retain) IBOutlet UILabel *tags;
@property (nonatomic, retain) IBOutlet UILabel *ristoranteName;
//@property (nonatomic, retain) IBOutlet UIButton * phoneButton;


@end
