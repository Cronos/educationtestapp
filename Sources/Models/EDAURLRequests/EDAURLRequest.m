//
//  EDAURLRequest.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 09.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAURLRequest.h"

NSString *const EDAAPIHost = @"http://newdev.anahoret.com:8082/data";
static const NSTimeInterval defaultTimeout = 30.0;

@interface EDAURLRequest()

- (void)setMethod:(EDARequestMethod)method;

@end

@implementation EDAURLRequest

+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod cachePolicy:(EDAURLRequestCachePolicy)policy timeout:(NSTimeInterval)timeout {
    NSURL *url = [NSURL URLWithString:[EDAAPIHost stringByAppendingPathComponent:path]];
    EDAURLRequest *request = [super requestWithURL:url cachePolicy:(NSURLRequestCachePolicy)policy timeoutInterval:timeout];
    request.allowsCellularAccess = YES;
    [request setMethod:httpMethod];
    
    return request;
}

+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod cachePolicy:(EDAURLRequestCachePolicy)policy {
    return [self requestWithPath:path httpMethod:httpMethod cachePolicy:policy timeout:defaultTimeout];
}

+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod {
    return [self requestWithPath:path httpMethod:httpMethod cachePolicy:EDAURLRequestReturnCacheDataElseLoad timeout:defaultTimeout];
}

+ (instancetype)requestWithPath:(NSString *)path {
    return [self requestWithPath:path httpMethod:EDARequestMethodGET cachePolicy:EDAURLRequestReturnCacheDataElseLoad timeout:defaultTimeout];
}

#pragma mark -
#pragma mark Public methods

- (void)setContentType:(NSString *)value {
    [self addValue:value forHTTPHeaderField:@"Content-Type"];
}

- (void)setAuthorizationHeader:(NSString *)credentials {
    [self addValue:credentials forHTTPHeaderField:@"Authorization"];
}

#pragma mark -
#pragma mark Private methods

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
