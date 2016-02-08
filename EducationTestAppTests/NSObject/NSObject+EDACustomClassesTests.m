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

- (void)testRegisterCustomClasses {
    NSArray *customClassNames = [EDAMock customClassNames:@"EDACustomClass" withCapacity:3];
    
    Class rootClass = [NSObject class];
    [EDAMock registerCustomClassesWithNames:customClassNames withRootClass:rootClass];
    
    NSArray *reverseNames = [customClassNames reverseArray];
    [reverseNames enumerateObjectsUsingBlock:^(NSString  * _Nonnull className, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = NSClassFromString(className);
        XCTAssertNotNil(class, @"Class %@ not registered", className);

        //Test for create instance
        id object = [class new];
        XCTAssertNotNil(object, @"Instance of %@ class not initialized", className);
        XCTAssertTrue([object isMemberOfClass:class], @"Object must be member of %@ class", className);
        
        //Test for superclass
        Class superclass = (idx+1)<reverseNames.count ? NSClassFromString(reverseNames[idx+1]) : rootClass;
        XCTAssertTrue([class isSubclassOfClass:superclass], @"Class %@ must be subclass of %@ class", NSStringFromClass(class), NSStringFromClass(superclass));
        XCTAssertTrue([object isKindOfClass:superclass], @"Object must be kind of %@ class", NSStringFromClass(superclass));
        
        //Test for subclasses
        NSSet *subclasses = [class subclasses];
        XCTAssertEqual(subclasses.count, idx, @"Count subclasses of %@ must be equals to %ld", className, idx);
    }];
    
    for (NSString *name in reverseNames) {
        Class class = NSClassFromString(name);
        [class unregister];
        XCTAssertNil(NSClassFromString(name), @"Class %@ not unregistered", name);
    }
}

@end
