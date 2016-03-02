//
//  NSMutableURLRequest+EDAExtensions.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDANetwork.h"

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

@interface NSMutableURLRequest (EDAExtensions)
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *authorizationHeader;

+ (instancetype)requestWithPath:(NSString *)path;
+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod;
+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod cachePolicy:(EDAURLRequestCachePolicy)policy;
+ (instancetype)requestWithPath:(NSString *)path httpMethod:(EDARequestMethod)httpMethod cachePolicy:(EDAURLRequestCachePolicy)policy timeout:(NSTimeInterval)timeout;

- (NSArray *)contentTypes;
- (NSArray *)authorizationHeaders;

@end
