//
//  NSNullTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 20.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "EDANull.h"

@interface NSNullTests : XCTestCase

@end

@implementation NSNullTests

#pragma mark -
#pragma mark

- (void)testReturnEDANull {
    id null = [NSNull null];
    
    XCTAssertEqualObjects(null, [NSNull null], @"null must be NSNull");
    XCTAssertTrue([null isKindOfClass:[NSNull class]], @"null must be kind of NSNull class");
    XCTAssertTrue([null isMemberOfClass:[EDANull class]], @"null must be member of EDANull class");
}

@end
