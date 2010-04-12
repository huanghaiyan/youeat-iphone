//
//  RistoranteDataCell.m
//  YouEat
//
//  Created by Alessandro Vincelli on 11/04/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "RistoranteDataCell.h"


@implementation RistoranteDataCell

@synthesize address;


- (void)setAddressData:(NSDictionary *)addressData {
    address.text = [addressData objectForKey:@"address"];
}


- (void)dealloc {
    [address release];
    [super dealloc];
}

@end

