//
//  ActivityCell.h
//  YouEat
//
//  Created by Alessandro Vincelli on 7/13/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ActivityCell : UITableViewCell {
		
		UIImageView *imageView;
		UILabel *nameLabel;
		UILabel *overviewLabel;
		UILabel *prepTimeLabel;
	}
	
	@property (nonatomic, retain) UIImageView *imageView;
	@property (nonatomic, retain) UILabel *nameLabel;
	@property (nonatomic, retain) UILabel *overviewLabel;
	@property (nonatomic, retain) UILabel *prepTimeLabel;


@end
