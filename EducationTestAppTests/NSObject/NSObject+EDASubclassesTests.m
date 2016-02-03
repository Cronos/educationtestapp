//
//  NSObject+SubclassesTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+EDARuntime.h"

@interface NSObject_EDASubclassesTests : XCTestCase

@end

@implementation NSObject_EDASubclassesTests

- (void)testMetaclass {
    NSArray *customClassNames = [self customClassNames:@"EDACustomClass" withCapacity:3];
    Class parentClass = [NSObject class];
    for (NSString *name in customClassNames) {
        parentClass = [parentClass registerClassWithName:name];
    }
    NSArray *reverseNames = [[customClassNames reverseObjectEnumerator] allObjects];

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
    NSArray *customClassNames = [self customClassNames:@"EDACustomClass" withCapacity:4];

    Class parentClass = [NSObject class];
    for (NSString *name in customClassNames) {
        parentClass = [parentClass registerClassWithName:name];
    }
    NSArray *reverseNames = [[customClassNames reverseObjectEnumerator] allObjects];
    [reverseNames enumerateObjectsUsingBlock:^(NSString  *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSSet *set = [NSClassFromString(obj) subclasses];
        XCTAssertEqual(set.count, idx, @"Subclasses for %@ class must be equal to %ld", (NSString *)obj, idx);
    }];
    
    for (NSString *name in reverseNames) {
        [NSObject unregisterClassWithName:name];
    }
}

- (void)testCreateEDACustomClass {
    NSString *customClassName = @"EDATestClass";
    Class class = [NSObject registerClassWithName:customClassName];
    XCTAssertNotNil(class, @"Class %@ not registered", customClassName);
    
    id object = [class new];
    
    XCTAssertNotNil(object, @"Class %@ not initialized", customClassName);
    XCTAssertTrue([object isMemberOfClass:class], @"Object must be member of %@ class", customClassName);
    XCTAssertTrue([object isKindOfClass:[NSObject class]], @"Object must be kind of %@ class", [NSObject class]);
    
    object = nil;
    [NSObject unregisterClassWithName:customClassName];
}

- (void)testUnregisterCustomClasses {
    NSArray *customClassNames = [self customClassNames:@"EDACustomClass" withCapacity:4];
    
    Class parentClass = [NSObject class];
    for (NSString *name in customClassNames) {
        parentClass = [parentClass registerClassWithName:name];
    }
    NSArray *reverseNames = [[customClassNames reverseObjectEnumerator] allObjects];
    
    for (NSString *name in reverseNames) {
        [NSObject unregisterClassWithName:name];
    }

}

- (NSArray <NSString *> *)customClassNames:(NSString *)name withCapacity:(NSInteger)count {
    NSMutableArray <NSString *> *array = [NSMutableArray array];
    for (NSInteger index = 0; index < count; index++) {
        [array addObject:[NSString stringWithFormat:@"%@%ld", name, index]];
    }
    return [array copy];
}

@end
