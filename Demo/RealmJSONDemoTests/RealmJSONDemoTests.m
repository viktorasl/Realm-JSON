//
//  RealmJSONDemoTests.m
//  RealmJSONDemoTests
//
//  Created by Matthew Cheok on 27/7/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Vehicle.h"
#import <Realm+JSON/RLMObject+JSON.h>

@interface RealmJSONDemoTests : XCTestCase

@end

@implementation RealmJSONDemoTests

- (void)setUp
{
    [super setUp];

    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *testsRealmPath = [documentsPath stringByAppendingString:@"realm+json_tests.realm"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:testsRealmPath]) {
        NSError *err;
        [fileManager removeItemAtPath:testsRealmPath error:&err];
        XCTAssertNil(err);
    }
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL fileURLWithPath:testsRealmPath];
    [RLMRealmConfiguration setDefaultConfiguration:config];

    // Need to explicitly call so that scheme would be lazily initialized
    [RLMRealm defaultRealm];
}

- (void)testInitializationFromJSON
{
    Vehicle *bike = [[Vehicle alloc] initWithJSONDictionary:@{
         @"maxSpeed": @30
    }];
    XCTAssertEqual(bike.maxSpeed, 30.0);
    XCTAssertNil(bike.licensePlate);
    
    Vehicle *honda = [[Vehicle alloc] initWithJSONDictionary:@{
        @"maxSpeed": @220,
        @"licensePlate": @"CAR999"
    }];
    XCTAssertEqual(honda.maxSpeed, 220.);
    XCTAssertEqual(honda.licensePlate, @"CAR999");
}

@end
