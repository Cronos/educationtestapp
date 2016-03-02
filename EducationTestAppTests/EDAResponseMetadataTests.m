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
#import "EDAAPIKeys.h"

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
    
    EDAResponseMetadata *metadata = [EDAResponseMetadata instanceWithDictionary:EDATestDataSuccessfulResponse()[EDAKeyResponse][EDAKeyMeta]];
    
    XCTAssertNotNil(metadata, @"Metadata init error");
    XCTAssertNotNil(metadata.request, @"Metadata.request init error");
    XCTAssertTrue(metadata.request.success, @"Metadata.request.success must be equals to TRUE");
    XCTAssertEqual(metadata.request.info, @"Logged in successfully", @"Metadata.request.info must be equals to 'Logged in successfully'");
    
    EDAResponseLayout *layout = metadata.layout;
    XCTAssertNotNil(layout, @"Metadata.layout init error");
    XCTAssertEqual(layout.index, 0, @"Metadata.layout.index init error");
    XCTAssertEqual(layout.count, 1, @"Metadata.layout.count init error");
    XCTAssertEqual(layout.totalCount, 1, @"Metadata.layout.totalCount init error");
}

- (void)testMetadataFromDictionaryUnsuccessful {
    
    EDAResponseMetadata *metadata = [EDAResponseMetadata instanceWithDictionary:EDATestDataUnsuccessfulResponse()[EDAKeyResponse][EDAKeyMeta]];
    
    XCTAssertNotNil(metadata, @"Metadata init error");
    XCTAssertNil(metadata.layout, @"Metadata.layout init error");

    EDAResponseRequestResult *request = metadata.request;
    XCTAssertNotNil(request, @"Metadata.request init error");
    XCTAssertFalse(request.success, @"Metadata.request.success must be equals to FALSE");
    XCTAssertEqual(request.info, @"Failed to login", @"Metadata.request.info must be equals to 'Failed to login'");
}

@end
