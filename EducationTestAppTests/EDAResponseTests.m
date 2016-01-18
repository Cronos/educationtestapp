//
//  EDAResponseTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 05.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EDATestAPI.h"
#import "EDAResponse.h"
#import "EDAResponseMetadata.h"
#import "EDAResponseRequestResult.h"
#import "EDAResponseLayout.h"

@interface EDAResponseTests : XCTestCase

@end

@implementation EDAResponseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResponseFromDictionarySuccessful {
    
    EDAResponse *response = [EDAResponse responseFromDictionary:testDataSuccessfulResponse()[@"response"]];
    
    XCTAssertNotNil(response, @"response init error");
    
    EDAResponseMetadata *meta = response.meta;
    XCTAssertNotNil(meta, @"response.meta init error");
    
    EDAResponseRequestResult *result = meta.request;
    XCTAssertNotNil(result, @"response.meta init error");
    
    EDAResponseLayout *layout = meta.layout;
    XCTAssertNotNil(layout, @"response.layout init error");
    
    NSArray *array = response.data;
    XCTAssertEqual(array.count, 2, @"response.data init error");

}

- (void)testResponseFromDictionaryUnsuccessful {
    
    EDAResponse *response = [EDAResponse responseFromDictionary:testDataUnsuccessfulResponse()[@"response"]];
    
    XCTAssertNotNil(response, @"response init error");
    
    EDAResponseMetadata *meta = response.meta;
    XCTAssertNotNil(meta, @"response.meta init error");
    
    EDAResponseRequestResult *result = meta.request;
    XCTAssertNotNil(result, @"response.meta init error");
    
    EDAResponseLayout *layout = meta.layout;
    XCTAssertNil(layout, @"response.layout init error");
    
    NSArray *array = response.data;
    XCTAssertEqual(array.count, 0, @"response.data init error");

}

@end
