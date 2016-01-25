//
//  NSNull+EDARuntime.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 20.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSNull+EDARuntime.h"
#import <objc/runtime.h>
#import "EDANull.h"
#import "NSObject+EDARuntime.h"

typedef id(*EDAMethodNewIMP)(id, SEL);
typedef id(*EDAMethodAllocIMP)(id, SEL);
typedef id(*EDAMethodAllocWithZoneIMP)(id, SEL, NSZone *);
typedef id(*EDAMethodNullIMP)(id, SEL);

@implementation NSNull (EDARuntime)

+ (void)load {
//    [self replaceNew];
//    [self replaceAlloc];
//    [self replaceAllocWithZone];
    [self replaceNull];
}

#pragma mark -
#pragma mark Methods for replace implementations

#define EDAPrepareForReplaceSelector(sel) \
    SEL selector = NSSelectorFromString(sel);  \
    id object = [self class]; \
    Class class = object_getClass(object)

+ (void)replaceNew {
    EDAPrepareForReplaceSelector(@"new");
    EDABlockWithIMP block = ^(IMP implementation) {
        EDAMethodNewIMP methodIMP = (EDAMethodNewIMP)implementation;

        return (id)^(id object) {
            NSLog(@"Call [NSNull new]");
            
            return methodIMP(object, selector);
        };
    };
    [class setBlock:block forSelector:selector];
}

+ (void)replaceAlloc {
    EDAPrepareForReplaceSelector(@"alloc");
    EDABlockWithIMP block = ^(IMP implementation) {
        EDAMethodAllocIMP methodIMP = (EDAMethodAllocIMP)implementation;
        
        return (id)^(id object) {
            NSLog(@"Call [NSNull alloc]");
            
            return methodIMP(object, selector);
        };
    };
    [class setBlock:block forSelector:selector];
}

+ (void)replaceAllocWithZone {
    EDAPrepareForReplaceSelector(@"allocWithZone:");
    EDABlockWithIMP block = ^(IMP implementation) {
        EDAMethodAllocWithZoneIMP methodIMP = (EDAMethodAllocWithZoneIMP)implementation;

        return (id)^(id object, NSZone *zone) {
            NSLog(@"Call [NSNull allocWithZone]");

            return methodIMP(object, selector, zone);
        };
    };
    [class setBlock:block forSelector:selector];
}

+ (void)replaceNull {
    EDAPrepareForReplaceSelector(@"null");
    EDABlockWithIMP block = ^(IMP implementation) {
        EDAMethodNullIMP methodIMP = (EDAMethodNullIMP)[class instanceMethodForSelector:@selector(edaNull)];
        
        return (id)^(id object) {
            NSLog(@"Call [NSNull null]");
            
            return methodIMP(object, selector);
        };
    };
    [class setBlock:block forSelector:selector];
}

+ (id)edaNull {
    return [EDANull null];
}

@end
