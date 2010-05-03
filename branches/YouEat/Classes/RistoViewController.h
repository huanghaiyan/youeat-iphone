//
//  RistoViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface RistoViewController : UIViewController {
	
	UILabel *ristoranteName;
	UILabel *tags;
	UILabel *address;
	UILabel *phoneNumber;
	UILabel *www;
	UIButton *phoneButton;
	UITextView *description;
	NSDictionary *selectedRisto;
	MKMapView *mapView;
}

@property (nonatomic, retain) NSDictionary *selectedRisto;
@property (nonatomic, retain) IBOutlet UILabel *address;
@property (nonatomic, retain) IBOutlet UILabel *tags;
@property (nonatomic, retain) IBOutlet UILabel *ristoranteName;
@property (nonatomic, retain) IBOutlet UILabel *phoneNumber;
@property (nonatomic, retain) IBOutlet UILabel *www;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIButton * phoneButton;
@property (nonatomic, retain) IBOutlet UITextView * description;

- (void)callRisto:(id)sender;

@end
