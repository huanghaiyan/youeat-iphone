//
//  RootViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 08/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "YouEatConnection.h"
#import "CoreLocation/CoreLocation.h"

@interface RootViewController : UITableViewController <UISearchBarDelegate, CLLocationManagerDelegate>{
	YouEatConnection *youEatConnection;
	IBOutlet UISearchBar *searchBar;
	NSMutableArray *listOfRisto;
	NSMutableArray *listOfRistoPosition;
	NSMutableData *responseData;	
	BOOL searching;
	BOOL letUserSelectRow;
    CLLocationManager *locationManager;
}

- (void) searchRistorantiView;
- (void) searchCloseRistorantiView;
- (void) doneSearching_Clicked:(id)sender;
- (NSDictionary*) sendRestRequest:(NSString*)url;

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
