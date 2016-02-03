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
    [self replaceNull];
}

#pragma mark -
#pragma mark Methods for replace implementations


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
