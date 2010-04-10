//
//  RistoranteDetailViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 10/04/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RistoranteDetailViewController : UIViewController {
	IBOutlet UILabel *ristoranteName;
	NSDictionary *selectedRisto;
}

@property (nonatomic, retain) NSDictionary *selectedRisto;

@end
