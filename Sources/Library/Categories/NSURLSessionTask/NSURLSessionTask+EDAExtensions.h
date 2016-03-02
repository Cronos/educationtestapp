//
//  NSURLSessionTask+EDAExtensions.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSessionTask (EDAExtensions)

- (void)startWithPriority:(float)priority;

@end
