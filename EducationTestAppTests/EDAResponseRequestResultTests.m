//
//  EDAResponseRequestResultTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EDAResponseRequestResult.h"
#import "EDAAPIKeys.h"

@interface EDAResponseRequestResultTests : XCTestCase

@end

@implementation EDAResponseRequestResultTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResultFromDictionarySuccessful {
    
    NSDictionary *dictionary = @{ // description of request
                                 EDAKeySuccess  : @"true", // if the request was succesful
                                 EDAKeyInfo     : @"Logged in successfully" // text accompanying the response
                                 };
    
    EDAResponseRequestResult *result = [EDAResponseRequestResult instanceWithDictionary:dictionary];
    
    XCTAssertTrue(result.success, @"Success initialize error");
    XCTAssertEqual(result.info, @"Logged in successfully", @"Info initialize error");
}

- (void)testResultFromDictionaryUnsuccessful {
    
    NSDictionary *dictionary = @{ // description of request
                                 EDAKeySuccess  : @"false",
                                 EDAKeyInfo     : @"Failed to login"
                                 };
    
    EDAResponseRequestResult *result = [EDAResponseRequestResult instanceWithDictionary:dictionary];
    
    XCTAssertFalse(result.success, @"Success initialize error");
    XCTAssertEqual(result.info, @"Failed to login", @"Info initialize error");
}

@end
