//
//  RistoranteDetailViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 10/04/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface RistoranteDetailViewController : UIViewController <MKMapViewDelegate>{
	UILabel *ristoranteName;
	UILabel *tags;
	UILabel *address;
	UILabel *phone;
	UITextView *description;
	MKMapView *mapView;
	NSDictionary *selectedRisto;
	UIView *ristoDataCell;  
}

@property (nonatomic, retain) NSDictionary *selectedRisto;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIView *ristoDataCell;
@property (nonatomic, retain) IBOutlet UITextView *description;
@property (nonatomic, retain) IBOutlet UILabel *address;
@property (nonatomic, retain) IBOutlet UILabel *tags;
@property (nonatomic, retain) IBOutlet UILabel *phone;
@property (nonatomic, retain) IBOutlet UILabel *ristoranteName;

@end
