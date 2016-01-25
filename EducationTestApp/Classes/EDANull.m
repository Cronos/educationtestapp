//
//  EDANull.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 14.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDANull.h"
#import <objc/runtime.h>

@interface EDANull()<NSCoding>

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector;
- (void)forwardInvocation:(NSInvocation *)invocation;

@end

@implementation EDANull

+ (id)allocWithZone:(struct _NSZone *)zone {
    id result = [super allocWithZone:zone];
    Class class = [EDANull class];
    if (object_getClass(result) != class) {
        object_setClass(result, class);
    }
    
    return result;
}

//+ (instancetype)null {
//    static id null = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        null = [self new];
//    });
//    
//    return null;
//}

- (BOOL)isEqual:(id)object {
    BOOL result = (!object);                            // compare with nil
    result |= [object isKindOfClass:[NSNull class]];    // compare with NSNull
    result |= (self==object);                           // compare with self
    
    return result;
}

- (NSUInteger)hash {
    return [[NSNull null] hash];
}

#pragma mark -
#pragma mart Forwarding methods

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature = [self methodSignatureForSelector:@selector(fakeMethod)];
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    invocation.target = nil;
    [invocation invoke];
}

- (void)fakeMethod {
}

@end
