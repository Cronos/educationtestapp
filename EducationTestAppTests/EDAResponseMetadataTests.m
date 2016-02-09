//
//  EDAResponseMetadataTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EDATestAPI.h"
#import "EDAResponseMetadata.h"
#import "EDAResponseRequestresult.h"
#import "EDAResponseLayout.h"

@interface EDAResponseMetadataTests : XCTestCase

@end

@implementation EDAResponseMetadataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMetadataFromDictionarySuccessful {
    
    EDAResponseMetadata *metadata = [EDAResponseMetadata instanceWithDictionary:testDataSuccessfulResponse()[@"response"][@"meta"]];
    
    XCTAssertNotNil(metadata, @"Metadata init error");
    XCTAssertNotNil(metadata.request, @"Metadata.request init error");
    XCTAssertTrue(metadata.request.success, @"Metadata.request.success must be equals to TRUE");
    XCTAssertEqual(metadata.request.info, @"Logged in successfully", @"Metadata.request.info must be equals to 'Logged in successfully'");
    
    XCTAssertNotNil(metadata.layout, @"Metadata.layout init error");
    XCTAssertEqual(metadata.layout.index, 0, @"Metadata.layout.index init error");
    XCTAssertEqual(metadata.layout.count, 1, @"Metadata.layout.count init error");
    XCTAssertEqual(metadata.layout.totalCount, 1, @"Metadata.layout.totalCount init error");
}

- (void)testMetadataFromDictionaryUnsuccessful {
    
    EDAResponseMetadata *metadata = [EDAResponseMetadata instanceWithDictionary:testDataUnsuccessfulResponse()[@"response"][@"meta"]];
    
    XCTAssertNotNil(metadata, @"Metadata init error");
    XCTAssertNotNil(metadata.request, @"Metadata.request init error");
    XCTAssertFalse(metadata.request.success, @"Metadata.request.success must be equals to FALSE");
    XCTAssertEqual(metadata.request.info, @"Failed to login", @"Metadata.request.info must be equals to 'Failed to login'");
    XCTAssertNil(metadata.layout, @"Metadata.layout init error");
}

@end
