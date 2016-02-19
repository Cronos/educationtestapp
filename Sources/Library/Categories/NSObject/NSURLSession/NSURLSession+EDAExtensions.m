//
//  NSURLSession+EDAExtensions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSURLSession+EDAExtensions.h"
#import "NSError+EDAExtensions.h"
#import "EDADispatch.h"

@implementation NSURLSession (EDAExtensions)

#define EDAURLSessionDispatchInMainQueue(data, error) \
    EDADispatchAsyncInMainQueue(^{ \
        completion ? completion(data, error) : nil; \
    }); \
\
    return

+ (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request priority:(float)priority completion:(EDAURLSessionDataTaskCompletion)completion {
    if (!request) {
        return nil;
    }
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSString *errorDescription = [NSString stringWithFormat:@"%@\n%@", error.localizedDescription, response.URL.absoluteString];
            EDAURLSessionDispatchInMainQueue(nil, [NSError errorWithCode:error.code description:errorDescription]);
        }

        NSInteger statusCode = [[response valueForKey:@"statusCode"] integerValue];
        if (statusCode != 200) {
            NSString *errorDescription = [NSString stringWithFormat:@"%@\n%@\n%@", [@(statusCode) stringValue], [NSHTTPURLResponse localizedStringForStatusCode:statusCode], response.URL];
            EDAURLSessionDispatchInMainQueue(nil, [NSError errorWithCode:statusCode description:errorDescription]);
        }
        
        EDAURLSessionDispatchInMainQueue(data, nil);
    }];
    
    task.priority = priority;
    
    return task;
}

+ (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completion:(EDAURLSessionDataTaskCompletion)completion {
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
