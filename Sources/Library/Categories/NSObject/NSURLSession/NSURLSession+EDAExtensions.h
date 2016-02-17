//
//  NSURLSession+EDAExtensions.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^EDAURLSessionTaskCompletion)(NSData *data, NSURLResponse *response, NSError *error);
typedef void (^EDAURLSessionDownloadTaskCompletion)(NSURL *location, NSURLResponse *response, NSError *error);

@interface NSURLSession (EDAExtensions)

+ (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                                     priority:(float)priority
                                   completion:(EDAURLSessionTaskCompletion)completion;

+ (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                                   completion:(EDAURLSessionTaskCompletion)completion;

+ (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             priority:(float)priority
                                           completion:(EDAURLSessionDownloadTaskCompletion)completion;

+ (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                           completion:(EDAURLSessionDownloadTaskCompletion)completion;


@end
