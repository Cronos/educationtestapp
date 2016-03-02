//
//  EDADataManagerTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 15.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EDADataManager.h"
#import "EDAData.h"

@interface EDADataManagerTests : XCTestCase

@end

@implementation EDADataManagerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//- (void)testForwardingSelectors {
//    EDADataManager *controller = [EDADataManager sharedManager];
//    XCTAssertNoThrow(controller.count, @"controller must be response to message 'count'");
//    NSArray *array = @[[EDAData new], [EDAData new], [EDAData new]];
//    [(id)controller addObjectsFromArray:array];
//    NSUInteger count = controller.count;
//    XCTAssertEqual(count, array.count, @"controller must be contains %ld items", array.count);
//    
//    EDAData *data = [(id)controller objectAtIndex:1];
//    XCTAssertEqualObjects(data, array[1], @"Item 1 of controller must be equals to item of array[1]");
//}

@end
