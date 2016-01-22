//
//  EDANSNullTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 20.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "EDANull.h"


@interface EDANSNullTests : XCTestCase

@end

@implementation EDANSNullTests

#pragma mark -
#pragma methods of NSNull

- (void)testNullInstanceMethodList {
    
    Class objectClass = [NSNull superclass];
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(objectClass, &methodCount);
    
    NSLog(@"Found %d methods on %s\n", methodCount, class_getName(objectClass));
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        
        NSLog(@"\t'%s' has instance-method named '%s' of encoding '%s'\n",
              class_getName(objectClass),
              sel_getName(method_getName(method)),
              method_getTypeEncoding(method));
    }
    
    free(methods);
}

- (void)testNullClassMethodList {
    
    Class objectClass = [NSNull class];
    unsigned int methodCount = 0;
    
    Method *methods = class_copyMethodList(object_getClass(objectClass), &methodCount);
    
    NSLog(@"Found %d methods on %s\n", methodCount, class_getName(objectClass));
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        
        NSLog(@"\t'%s' has class-method named '%s' of encoding '%s'\n",
              class_getName(objectClass),
              sel_getName(method_getName(method)),
              method_getTypeEncoding(method));
    }
    
    free(methods);
}

#pragma mark -
#pragma Swizzling

- (void)testSwizzling {
    id null = [NSNull null];
    
    XCTAssertEqualObjects(null, [NSNull null], @"null must be NSNull");
    XCTAssertTrue([null isKindOfClass:[NSNull class]], @"null must be kind of NSNull class");
}

@end
