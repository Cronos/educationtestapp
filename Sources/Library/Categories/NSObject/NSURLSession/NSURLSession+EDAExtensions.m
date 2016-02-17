//
//  NSURLSession+EDAExtensions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSURLSession+EDAExtensions.h"

@implementation NSURLSession (EDAExtensions)

+ (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request priority:(float)priority completion:(EDAURLSessionTaskCompletion)completion {
    if (!request) {
        return nil;
    }
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completion];
    task.priority = priority;
    
    return task;
}

+ (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completion:(EDAURLSessionTaskCompletion)completion {
    return [self dataTaskWithRequest:request priority:NSURLSessionTaskPriorityDefault completion:completion];
}

+ (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request priority:(float)priority completion:(EDAURLSessionDownloadTaskCompletion)completion {
    if (!request) {
        return nil;
    }
    
    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:completion];
    task.priority = priority;
    
    return task;
}

+ (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request completion:(EDAURLSessionDownloadTaskCompletion)completion {
    return [self downloadTaskWithRequest:request priority:NSURLSessionTaskPriorityDefault completion:completion];
}

@end
