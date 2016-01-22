//
//  NSNull+Swizzling.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 20.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSNull+Swizzling.h"
#import <objc/runtime.h>

@implementation NSNull (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        Method originNullMethod = class_getClassMethod(class, @selector(null));
        Method customNullMethod = class_getClassMethod(class, @selector(customNull));
        method_exchangeImplementations(originNullMethod, customNullMethod);
    });
}

+ (NSNull *)customNull {
    
    NSLog(@"[NSNull null] called");
    NSLog(@"%@",[NSThread callStackSymbols]);

    return [self customNull];
}
@end
