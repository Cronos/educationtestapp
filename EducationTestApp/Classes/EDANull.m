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

@end

@implementation EDANull

+ (instancetype)null {
    static id null = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        null = [self new];
    });
    
    return null;
}

- (NSUInteger)hash {
    return [(NSNull *)kCFNull hash];
}

- (BOOL)isEqual:(id)object {
    BOOL result = !object;                              // compare with nil
    result |= (self==object);                           // compare with self
//    result |= [object isKindOfClass:[NSNull class]];    // compare with NSNull
    
    return result;
}

- (BOOL)isKindOfClass:(Class)class {
    return (class == [NSNull class]) || ([super isKindOfClass:class]);
}

//- (BOOL)isMemberOfClass:(Class)class {
//    return (class == [EDANull class]);
//}

+ (BOOL)conformsToProtocol:(Protocol *)protocol {
    return YES;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return YES;
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

#pragma mark -
#pragma mark - NSCoding methods

- (instancetype)initWithCoder:(NSCoder *)decoder {
    return [EDANull new];
}

- (void)encodeWithCoder:(NSCoder *)coder {
}

@end
