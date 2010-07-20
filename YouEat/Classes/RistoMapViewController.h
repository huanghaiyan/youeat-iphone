//
//  RistoMapViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 7/20/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RistoMapViewController : UIViewController {
	NSDictionary *selectedRisto;
	MKMapView *mapView;
}

@property (nonatomic, retain) NSDictionary *selectedRisto;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end