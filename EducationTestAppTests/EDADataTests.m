//
//  EDADataTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EDATestAPI.h"
#import "EDAData.h"

@interface EDADataTests : XCTestCase

@end

@implementation EDADataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDataFromDictionary {
    
    EDAData *data = [EDAData dataFromDictionary:testDataWithIdResponse()[@"data"][0]];
    
    XCTAssertEqual(data.Id, 1, @"Id initialize error");
    XCTAssertEqual(data.content, @"MAMAPAPADEDABABA", @"Content string initialize error");
    XCTAssertEqual(data.message, @"ABABABAAAAAAABBBBAAAA!!!", @"Message string initialize error");
    XCTAssertEqual(data.image, @"http://www.de", @"Image URL initialize error");
    XCTAssertEqual(data.images.count, 2, @"Images array initialize error");
}

- (void)testArrayFromArray {
    
    NSArray<EDAData*> *array = [EDAData arrayFromArray:testDataSuccessfulResponse()[@"response"][@"data"]];
    
    XCTAssertEqual(array.count, 2, @"dataArray size must be equals to 2");

    XCTAssertEqual(array[0].Id, 1, @"dataArray size must be equals to 2");
    XCTAssertEqual(array[0].content, @"MAMAPAPADEDABABA", @"dataArray[0].content init error");
    XCTAssertEqual(array[0].image, @"http://www.1.de", @"dataArray[0].image init error");
    
    
    XCTAssertEqual(array[1].Id, 2, @"dataArray size must be equals to 2");
    XCTAssertEqual(array[1].content, @"PAPAMAMABABADEDA", @"dataArray[0].content init error");
    XCTAssertEqual(array[1].image, @"http://www.2.de", @"dataArray[0].image init error");
}
@end
