//
//  EDAURLRequest.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 09.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EDAURLRequestCachePolicy) {
    // Default policy
    EDAURLRequestDefaultCachePolicy = NSURLRequestUseProtocolCachePolicy,
    // Ignore local cache data. Must using always if make byte-range request
    EDAURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData,
    //
    EDAURLRequestReloadIgnoringLocalAndRemoteCacheData UNAVAILABLE_ATTRIBUTE = NSURLRequestReloadIgnoringLocalAndRemoteCacheData, // Unimplemented
    // Use cached data if exist it, else load from source
    EDAURLRequestReturnCacheDataElseLoad = NSURLRequestReturnCacheDataElseLoad,
    // Use only cached data
    EDAURLRequestReturnCacheDataDontLoad = NSURLRequestReturnCacheDataDontLoad,
    //
    EDAURLRequestReloadRevalidatingCacheData UNAVAILABLE_ATTRIBUTE = NSURLRequestReloadRevalidatingCacheData // Unimplemented
};

typedef NS_ENUM(NSUInteger, EDARequestMethod) {
    EDARequestMethodGET     = 0,
    EDARequestMethodPOST
};

@interface EDAURLRequest : NSMutableURLRequest

+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod cachePolicy:(EDAURLRequestCachePolicy)policy timeout:(NSTimeInterval)timeout;
+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod cachePolicy:(EDAURLRequestCachePolicy)policy;
+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod;
+ (instancetype)requestWithPath:(NSString *)path;

- (void)setContentType:(NSString *)value;
- (void)setAuthorizationHeader:(NSString *)credentials;

@end
