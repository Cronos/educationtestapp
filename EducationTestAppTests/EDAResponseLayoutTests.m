//
//  EDAResponseLayoutTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EDATestAPI.h"
#import "EDAResponseLayout.h"
#import "EDAAPIKeys.h"

@interface EDAResponseLayoutTests : XCTestCase

@end

@implementation EDAResponseLayoutTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLayoutFromDictionary {
    
    EDAResponseLayout *layout = [EDAResponseLayout instanceWithDictionary:EDATestDataSuccessfulResponse()[EDAKeyResponse][EDAKeyMeta][EDAKeyLayout]];
    
    XCTAssertEqual(layout.index, 0, @"Index initialization error.");
    XCTAssertEqual(layout.count, 1, @"Count initialization error.");
    XCTAssertEqual(layout.totalCount, 1, @"Total count initialization error.");
}
@end
