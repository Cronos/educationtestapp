//
//  NSDictionaryTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 18.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+NSNull.h"
#import "EDANull.h"

@interface NSDictionaryTests : XCTestCase

@end

@implementation NSDictionaryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExchangeValueForKeyMethod {
    
    NSArray *keys = @[@"keyNull", @"keyObject", @"keyArray", @"keyString"];
    NSDictionary *dictionary = @{ keys[0] : [NSNull null],
                                  keys[1] : [NSObject new],
                                  keys[2] : [NSArray new],
                                  keys[3] : [NSString new]
                                  };
    
    id value = [dictionary valueForKey:keys[0]];
    XCTAssertTrue([value isKindOfClass:[EDANull class]], @"value must be EDANull class");
    
    value = [dictionary valueForKey:keys[1]];
    XCTAssertTrue([value isKindOfClass:[NSObject class]], @"value must be NSObject class");
    
    value = [dictionary valueForKey:keys[2]];
    XCTAssertTrue([value isKindOfClass:[NSArray class]], @"value must be NSArray class");
    
    value = [dictionary valueForKey:keys[3]];
    XCTAssertTrue([value isKindOfClass:[NSString class]], @"value must be NSString class");
}

- (void)testExchangeObjectForKeyedSubscriptMethod {
    
    NSArray *keys = @[@"keyNull", @"keyObject", @"keyArray", @"keyString"];
    NSDictionary *dictionary = @{ keys[0] : [NSNull null],
                                  keys[1] : [NSObject new],
                                  keys[2] : [NSArray new],
                                  keys[3] : [NSString new]
                                  };
    
    id value = dictionary[keys[0]];
    XCTAssertTrue([value isKindOfClass:[EDANull class]], @"value must be EDANull class");
    
    value = dictionary[keys[1]];
    XCTAssertTrue([value isKindOfClass:[NSObject class]], @"value must be NSObject class");
    
    value = dictionary[keys[2]];
    XCTAssertTrue([value isKindOfClass:[NSArray class]], @"value must be NSArray class");
    
    value = dictionary[keys[3]];
    XCTAssertTrue([value isKindOfClass:[NSString class]], @"value must be NSString class");
}

@end
