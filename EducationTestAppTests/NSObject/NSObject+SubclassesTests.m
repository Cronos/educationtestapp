//
//  NSObject+SubclassesTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+EDARuntime.h"

@interface NSObject_SubclassesTests : XCTestCase

@end

@implementation NSObject_SubclassesTests

- (void)testMetaclass {
    NSArray *customClassNames = @[@"EDACustomClass1", @"EDACustomClass2", @"EDACustomClass3"];
    Class parentClass = [NSObject class];
    for (NSString *name in customClassNames) {
        parentClass = [self registerClassWithName:name kindOf:parentClass];
    }
    NSArray *reverseNames = [[customClassNames reverseObjectEnumerator] allObjects];

    [reverseNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = NSClassFromString((NSString *)obj);
        Class metaclass = [class metaclass];
        XCTAssertEqualObjects(NSStringFromClass(metaclass), NSStringFromClass(class), @"Metaclass for %@ class must be %@", class, [class class]);
        metaclass = [metaclass metaclass];
        XCTAssertEqualObjects(NSStringFromClass(metaclass), NSStringFromClass([NSObject class]), @"Metaclass for metaclass must be %@ class", NSStringFromClass([NSObject class]));
    }];
    for (NSString *name in reverseNames) {
        [self unregisterClassWithName:name];
    }
}

- (void)testSubclasses {
    NSArray *customClassNames = @[@"EDACustomClass1", @"EDACustomClass2", @"EDACustomClass3", @"EDACustomClass4"];

    Class parentClass = [NSObject class];
    for (NSString *name in customClassNames) {
        parentClass = [self registerClassWithName:name kindOf:parentClass];
    }
    NSArray *reverseNames = [[customClassNames reverseObjectEnumerator] allObjects];
    [reverseNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSSet *set = [NSClassFromString((NSString *)obj) subclasses];
        XCTAssertEqual(set.count, idx, @"Subclasses for %@ class must be equal to %ld", (NSString *)obj, idx);
    }];
    
    for (NSString *name in reverseNames) {
        [self unregisterClassWithName:name];
    }
}

- (void)testCreateEDACustomClass {
    NSString *customClassName = @"EDATestClass";
    Class class = [self registerClassWithName:customClassName kindOf:[NSObject class]];
    XCTAssertNotNil(class, @"Class %@ not registered", customClassName);
    
    id object = [class new];
    
    XCTAssertNotNil(object, @"Class %@ not initialized", customClassName);
    XCTAssertTrue([object isMemberOfClass:class], @"Object must be member of %@ class", customClassName);
    XCTAssertTrue([object isKindOfClass:[NSObject class]], @"Object must be kind of %@ class", [NSObject class]);
    
    object = nil;
    [self unregisterClassWithName:customClassName];
}

#pragma mark -
#pragma mark Register/Unregister class

- (Class)registerClassWithName:(NSString *)name kindOf:(Class)class {
    Class newClass = objc_allocateClassPair(class, [name UTF8String], 0);
    objc_registerClassPair(newClass);
    return newClass;
}

- (void)unregisterClassWithName:(NSString *)name {
    objc_disposeClassPair(NSClassFromString(name));
}

@end
