//
//  EDAURLRequest.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 09.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAURLRequest.h"
#import "NSString+EDAExtensions.h"

NSString * const EDAAPIBaseURL = @"http://newdev.anahoret.com:8082";

NSString * const EDARequestHeaderFieldContentType         = @"Content-Type";
NSString * const EDARequestHeaderFieldValueSeparators     = @",";
NSString * const EDARequestHeaderFieldAuthorization       = @"Authorization";

static const NSTimeInterval EDARequestDefaultTimeout = 30.0;

@interface EDAURLRequest()


- (void)addUniqueStringValue:(NSString *)value forHTTPHeader:(NSArray *)header type:(NSString *)type;
- (void)setMethod:(EDARequestMethod)method;

@end

@implementation EDAURLRequest

@dynamic contentType;
@dynamic authorizationHeader;

+ (instancetype)requestWithPath:(NSString *)path {
    return [self requestWithPath:path httpMethod:EDARequestMethodGET cachePolicy:EDAURLRequestReturnCacheDataElseLoad timeout:EDARequestDefaultTimeout];
}

+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod {
    return [self requestWithPath:path httpMethod:httpMethod cachePolicy:EDAURLRequestReturnCacheDataElseLoad timeout:EDARequestDefaultTimeout];
}

+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod cachePolicy:(EDAURLRequestCachePolicy)policy {
    return [self requestWithPath:path httpMethod:httpMethod cachePolicy:policy timeout:EDARequestDefaultTimeout];
}

+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod cachePolicy:(EDAURLRequestCachePolicy)policy timeout:(NSTimeInterval)timeout {
    NSURL *url = [NSURL URLWithString:path relativeToURL:[NSURL URLWithString:EDAAPIBaseURL]];
    EDAURLRequest *request = [super requestWithURL:url cachePolicy:(NSURLRequestCachePolicy)policy timeoutInterval:timeout];
    request.allowsCellularAccess = YES;
    [request setMethod:httpMethod];
    
    return request;
}

#pragma mark -
#pragma mark Accessors

- (void)setContentType:(NSString *)value {
    [self addUniqueStringValue:value forHTTPHeader:[self contentTypes] type:EDARequestHeaderFieldContentType];
}

- (NSString *)contentType {
    return [self valueForHTTPHeaderField:EDARequestHeaderFieldContentType];
}

- (NSArray *)contentTypes {
     return [self.contentType separatedWithChars:EDARequestHeaderFieldValueSeparators];
}

- (void)setAuthorizationHeader:(NSString *)credentials {
    [self addUniqueStringValue:credentials forHTTPHeader:[self authorizationHeaders] type:EDARequestHeaderFieldAuthorization];
}

- (NSString *)authorizationHeader {
    return [self valueForHTTPHeaderField:EDARequestHeaderFieldAuthorization];
}

- (NSArray *)authorizationHeaders {
    return [self.authorizationHeader separatedWithChars:EDARequestHeaderFieldValueSeparators];
}

#pragma mark -
#pragma mark Private methods

- (void)addUniqueStringValue:(NSString *)value forHTTPHeader:(NSArray *)header type:(NSString *)type {
    if (![header containsObject:value]) {
        [self addValue:value forHTTPHeaderField:type];
    }
}

- (void)setMethod:(EDARequestMethod)method {
    NSString *string = nil;
    switch (method) {
        case EDARequestMethodPOST:
            string = @"POST";
            break;
            
        default:
            string = @"GET";
            break;
    }
    self.HTTPMethod = string;
}

@end
