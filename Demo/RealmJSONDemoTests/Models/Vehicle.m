//
//  Vehicle.m
//  RealmJSONDemo
//
//  Created by Viktoras Laukevičius on 20/07/16.
//  Copyright © 2016 Matthew Cheok. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle

+ (NSDictionary *)JSONInboundMappingDictionary
{
    return @{
        @"maxSpeed": @"maxSpeed",
        @"licensePlate": @"licensePlate"
    };
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{
        @"licensePlate": [NSNull null]
    };
}

@end
