//
//  EDANullTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 14.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EDANull.h"

@interface EDANullTests : XCTestCase

@end

@implementation EDANullTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialize {
    
    EDANull *nullObject = [EDANull null];
    
    XCTAssertTrue([nullObject isKindOfClass:[EDANull class]], @"nullObject must be EDANull");
}

@end
