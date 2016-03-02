//
//  NSURLSessionTask+EDAExtensions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSURLSessionTask+EDAExtensions.h"

@implementation NSURLSessionTask (EDAExtensions)

- (void)startWithPriority:(float)priority {
    if (NSURLSessionTaskStateRunning == self.state) {
        [self suspend];
    }
    
    self.priority = priority;
    [self resume];
}

@end
