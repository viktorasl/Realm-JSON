//
//  Vehicle.h
//  RealmJSONDemo
//
//  Created by Viktoras Laukevičius on 20/07/16.
//  Copyright © 2016 Matthew Cheok. All rights reserved.
//

#import <Realm/Realm.h>

@interface Vehicle : RLMObject

@property (nonatomic) CGFloat maxSpeed;
@property (nonatomic) NSString *licensePlate;

@end
