//
//  EDAURLRequestTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 09.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EDAURLRequest.h"
#import "EDARecordInfoRequest.h"
#import "EDARecordsListRequest.h"
#import "NSMutableURLRequest+EDAExtensions.h"
#import "EDACDefines.h"

EDA_EXTERNAL_CONST(NSString *, EDAAPIBaseURL);
EDA_EXTERNAL_CONST(NSString *, EDARecordInfoRequestTemplate);
EDA_EXTERNAL_CONST(NSString *, EDARecordsListRequestTemplate);

@interface EDAURLRequestTests : XCTestCase

@end

@implementation EDAURLRequestTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEDAURLRequest:(EDAURLRequest *)request path:(NSString *)path {
    XCTAssertNotNil(request, @"request not initialized");
    XCTAssertEqual(request.cachePolicy, EDAURLRequestReturnCacheDataElseLoad, @"cachePolicy must be equal to default value EDAURLRequestReturnCacheDataElseLoad");
    XCTAssertEqualObjects(request.HTTPMethod, @"GET", @"request method must be equal to 'GET'");
    
    NSURL *url = [NSURL URLWithString:path relativeToURL:[NSURL URLWithString:EDAAPIBaseURL]];
    XCTAssertTrue([request.URL.absoluteString isEqualToString:url.absoluteString], @"request URL\n %@ must be equal to\n %@",request.URL.absoluteString, url.absoluteString);
}

- (void)testCreateRequestWithPath {
    NSString *path = @"";
    EDAURLRequest *request = [EDAURLRequest requestWithPath:path];
    [self testEDAURLRequest:request path:path];
}

- (void)testContentType {
    EDAURLRequest *request = [EDAURLRequest new];
    
    NSString *contentType1 = @"content type 1";
    NSString *contentType2 = @"content type 2";
    [request setContentType:contentType1];
    [request setContentType:contentType2];

    NSString *contentType = request.contentType;
    XCTAssertNotNil(contentType);
    NSString *contentTypeValue = [NSString stringWithFormat:@"%@,%@", contentType1, contentType2];
    XCTAssertTrue([contentType isEqualToString:contentTypeValue], @"Content type must be equal to %@", contentTypeValue);

    NSArray *array = [request contentTypes];
    XCTAssertTrue([array containsObject:contentType1], @"Contents must be contains %@", contentType1);
    XCTAssertTrue([array containsObject:contentType2], @"Contents must be contains %@", contentType2);
    
    [request setContentType:contentType1];
    XCTAssertEqual([request contentTypes].count, 2, @"Contents must be contains 2 types");
}

- (void)testAuthorizationHeader {
    EDAURLRequest *request = [EDAURLRequest new];
    
    NSString *authorizationHeader1 = @"authorization header value 1";
    NSString *authorizationHeader2 = @"authorization header value 2";
    [request setAuthorizationHeader:authorizationHeader1];
    [request setAuthorizationHeader:authorizationHeader2];
    
    NSString *contentType = request.authorizationHeader;
    XCTAssertNotNil(contentType);
    NSString *contentTypeValue = [NSString stringWithFormat:@"%@,%@", authorizationHeader1, authorizationHeader2];
    XCTAssertTrue([contentType isEqualToString:contentTypeValue], @"Authorization header must be equal to %@", contentTypeValue);
}


- (void)testEDARecordInfoRequest {
    NSInteger ID = 55;
    EDARecordInfoRequest *request = [EDARecordInfoRequest requestWithId:ID];
    
    NSString *path = [NSString stringWithFormat:EDARecordInfoRequestTemplate, ID];
    [self testEDAURLRequest:request path:path];
    
    XCTAssertTrue([[request valueForHTTPHeaderField:@"Content-Type"] isEqualToString:@"application/json; charset=utf-8"], @"Content type must be application/json");
}

- (void)testEDARecordsListRequest {
    NSInteger start = 55;
    NSInteger count = 23;
    EDARecordsListRequest *request = [EDARecordsListRequest requestFromIndex:start count:count];
    
    NSString *path = [NSString stringWithFormat:EDARecordsListRequestTemplate, start, count];
    [self testEDAURLRequest:request path:path];
    
    XCTAssertTrue([[request valueForHTTPHeaderField:@"Content-Type"] isEqualToString:@"application/json; charset=utf-8"], @"Content type must be application/json");
}

@end
