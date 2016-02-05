//
//  NSObject+EDACustomClassesTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+EDARuntime.h"
#import "NSArray+EDAExtensions.h"
#import "EDAMock.h"

@interface NSObject_EDACustomClassesTests : XCTestCase

@end

@implementation NSObject_EDACustomClassesTests

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
    NSArray *customClassNames = [EDAMock customClassNames:@"EDACustomClass" withCapacity:3];
    
    [EDAMock registerCustomClassesWithNames:customClassNames withRootClass:[NSObject class]];
    
    NSArray *reverseNames = [customClassNames reverse];
    for (NSString *name in reverseNames) {
        [NSObject unregisterClassWithName:name];
        Class class = NSClassFromString(name);
        XCTAssertNil(class, @"Class %@ not unregistered", name);
    }
}

@end
