//
//  NSMutableURLRequest+EDAExtensions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSMutableURLRequest+EDAExtensions.h"
#import "NSString+EDAExtensions.h"

EDA_EXTERNAL(NSString *, EDAAPIBaseURL);

static NSString * const EDARequestHeaderFieldContentType         = @"Content-Type";
static NSString * const EDARequestHeaderFieldValueSeparators     = @",";
static NSString * const EDARequestHeaderFieldAuthorization       = @"Authorization";

static const NSTimeInterval EDARequestDefaultTimeout = 30.0;

@interface NSMutableURLRequest(EDAExtensionsPrivate)

- (void)addUniqueStringValue:(NSString *)value forHTTPHeader:(NSArray *)header type:(NSString *)type;

@end

@implementation NSMutableURLRequest (EDAExtensions)

@dynamic contentType;
@dynamic authorizationHeader;

#pragma mark -
#pragma mark Initializers

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
    NSMutableURLRequest *request = [super requestWithURL:url cachePolicy:(NSURLRequestCachePolicy)policy timeoutInterval:timeout];
    request.allowsCellularAccess = YES;
    request.HTTPMethod = EDAHTTPMethod(httpMethod);
    
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

@end
