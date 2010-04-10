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
	IBOutlet UILabel *ristoranteName;
	IBOutlet UILabel *tags;
	IBOutlet UILabel *address;
	IBOutlet UILabel *description;
	IBOutlet MKMapView *mapView;
	NSDictionary *selectedRisto;
}

@property (nonatomic, retain) NSDictionary *selectedRisto;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
