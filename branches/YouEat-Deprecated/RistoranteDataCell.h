//
//  RistoranteDataCell.h
//  YouEat
//
//  Created by Alessandro Vincelli on 11/04/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RistoranteDataCell : UITableViewCell {

    UILabel *address;
}

@property (nonatomic, retain) IBOutlet UILabel *address;

- (void)setAddressData:(NSDictionary *)addressData;

@end

