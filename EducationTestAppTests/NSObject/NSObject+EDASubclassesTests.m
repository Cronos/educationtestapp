//
//  NSObject+EDASubclassesTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+EDARuntime.h"
#import "NSArray+EDAExtensions.h"
#import "EDAMock.h"

@interface NSObject_EDASubclassesTests : XCTestCase

@end

@implementation NSObject_EDASubclassesTests

- (void)testMetaclass {
    NSArray *customClassNames = [EDAMock customClassNames:@"EDACustomClass" withCapacity:3];

    [EDAMock registerCustomClassesWithNames:customClassNames withRootClass:[NSObject class]];
    
    NSArray *reverseNames = [customClassNames reverse];
    [reverseNames enumerateObjectsUsingBlock:^(NSString  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = NSClassFromString((NSString *)obj);
        Class metaclass = [class metaclass];
        XCTAssertEqualObjects(NSStringFromClass(metaclass), NSStringFromClass(class), @"Metaclass for %@ class must be %@", class, [class class]);
        metaclass = [metaclass metaclass];
        XCTAssertEqualObjects(NSStringFromClass(metaclass), NSStringFromClass([NSObject class]), @"Metaclass for metaclass must be %@ class", NSStringFromClass([NSObject class]));
    }];
    
    for (NSString *name in reverseNames) {
        [NSObject unregisterClassWithName:name];
    }
}

- (void)testSubclasses {
    NSArray *customClassNames = [EDAMock customClassNames:@"EDACustomClass" withCapacity:4];

    [EDAMock registerCustomClassesWithNames:customClassNames withRootClass:[NSObject class]];
    
    NSArray *reverseNames = [customClassNames reverse];
    [reverseNames enumerateObjectsUsingBlock:^(NSString  *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSSet *set = [NSClassFromString(obj) subclasses];
        XCTAssertEqual(set.count, idx, @"Subclasses for %@ class must be equal to %ld", (NSString *)obj, idx);
    }];
    
    for (NSString *name in reverseNames) {
        [NSObject unregisterClassWithName:name];
    }
}

@end
