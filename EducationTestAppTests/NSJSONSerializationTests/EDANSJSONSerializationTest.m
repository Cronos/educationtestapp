//
//  EDANSJSONSerializationTest.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 14.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "EDANull.h"
#import "NSObject+EDARuntime.h"

typedef id(*EDAMethodClassIMP)(id, SEL);
typedef BOOL(*EDAMethodIsKindOfClassIMP)(id, SEL, Class);
typedef BOOL(*EDAMethodIsMemberOfClassIMP)(id, SEL, Class);
typedef BOOL(*EDAMethodIsSubclassOfClassIMP)(id, SEL, Class);

@interface EDANSJSONSerializationTest : XCTestCase
@property (nonatomic, strong) NSMutableSet<NSString *> *calledMethods;

@end

NSData *dataWithJSONEDANullObject() {
    return [NSJSONSerialization dataWithJSONObject:@[[EDANull null]] options:NSJSONWritingPrettyPrinted error:nil];
}

@implementation EDANSJSONSerializationTest

- (void)setUp {
    [super setUp];
    self.calledMethods = [NSMutableSet set];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSerializationArrayWithEDANullObject {
    NSArray *array = @[[EDANull null]];
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    
    XCTAssertNil(error, @"serialization from array error");
    XCTAssertNotNil(data, @"data init error");
    
    error = nil;
    id deserializedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    XCTAssertNil(error, @"deserialization error");
    XCTAssertTrue([deserializedObject isKindOfClass:[NSArray class]], @"deserializedObject must be kind of NSArray");
}

#pragma mark -
#pragma mark replace EDANull methods

- (void)testMethodsForDataWithJSONObject {
    [self.calledMethods removeAllObjects];
    
    [self replaceMethodClass];
    [self replaceMethodIsKindOfClass];
    [self replaceMethodIsMemberOfClass];
    [self replaceMethodIsSubclassOfClass];
    
    NSData *data = JSONWithEDANullObject;
    
    NSData *data = dataWithJSONEDANullObject();
    XCTAssertNotNil(data, @"dataWithJSONObject not initialized");
    XCTAssertTrue(self.calledMethods.count == 2, @"JSONWithEDANullObject must to call 2 methods");
    XCTAssertTrue([self.calledMethods containsObject:@"isKindOfClass:"], @"[NSJSONSerialization dataWithJSONObject] must be call 'isKindOfClass' method");
    XCTAssertTrue([self.calledMethods containsObject:@"class"], @"[NSJSONSerialization dataWithJSONObject] must be call 'class' method");
}

- (void)testMethodsForJSONObjectWithData {
    NSData *data = dataWithJSONEDANullObject();
    
    [self.calledMethods removeAllObjects];
    [self replaceMethodClass];
    [self replaceMethodIsKindOfClass];
    [self replaceMethodIsMemberOfClass];
    [self replaceMethodIsSubclassOfClass];

    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    XCTAssertTrue(self.calledMethods.count == 0, @"JSONWithEDANullObject must not call no methods");
}

#define EDAPrepareForReplaceSelector(sel) \
SEL selector = NSSelectorFromString(sel);  \
id object = [EDANull class]; \
Class class = object_getClass(object)

- (void)replaceMethodClass {
    EDAPrepareForReplaceSelector(@"class");
    EDABlockWithIMP block = ^(IMP implementation) {
        EDAMethodClassIMP methodIMP = (EDAMethodClassIMP)implementation;
        //TODO:
        
        [self registerClassWithImplementationProperty];
//        [self.savedImplementations setValue:(id)methodIMP forPropertyKey:NSStringFromSelector(selector) associationPolicy:EDAPropertyNonatomicStrong];
        return (id)^(id object) {
            [self.calledMethods addObject:NSStringFromSelector(selector)];
            return methodIMP(object, selector);
        };
    };
    [object setBlock:block forSelector:selector];
}

- (void)replaceMethodIsKindOfClass {
    EDAPrepareForReplaceSelector(@"isKindOfClass:");
    EDABlockWithIMP block = ^(IMP implementation) {
        EDAMethodIsKindOfClassIMP methodIMP = (EDAMethodIsKindOfClassIMP)implementation;
        return (id)^(id object, Class class) {
            [self.calledMethods addObject:NSStringFromSelector(selector)];
            return methodIMP(object, selector, class);
        };
    };
    [object setBlock:block forSelector:selector];
}

- (void)replaceMethodIsMemberOfClass {
    EDAPrepareForReplaceSelector(@"isMemberOfClass:");
    EDABlockWithIMP block = ^(IMP implementation) {
        EDAMethodIsMemberOfClassIMP methodIMP = (EDAMethodIsMemberOfClassIMP)implementation;
        return (id)^(id object, Class class) {
            [self.calledMethods addObject:NSStringFromSelector(selector)];
            return methodIMP(object, selector, class);
        };
    };
    [object setBlock:block forSelector:selector];
}

- (void)replaceMethodIsSubclassOfClass {
    EDAPrepareForReplaceSelector(@"isSubclassOfClass:");
    EDABlockWithIMP block = ^(IMP implementation) {
        EDAMethodIsSubclassOfClassIMP methodIMP = (EDAMethodIsSubclassOfClassIMP)implementation;
        return (id)^(id object, Class class) {
            [self.calledMethods addObject:NSStringFromSelector(selector)];
            return methodIMP(object, selector, class);
        };
    };
    [class setBlock:block forSelector:selector];
}

- (void)registerClassWithImplementationProperty {
    NSString *className = @"EDAImplementation";
    id object = [NSObject class]; \
    Class class = object_getClass(object);

    
    Class newClass = objc_allocateClassPair(class, [className UTF8String], 0);
    
    objc_registerClassPair(newClass);
//    BOOL result = class_addProperty(newClass, "value", nil, 0);
//    
//    id obj = [newClass new];
}

- (void)unregisterClassWithImplementationProperty {
    NSString *className = @"EDAImplementation";
    objc_disposeClassPair(NSClassFromString(@"EDAImplementation"));
}

- (id)objectWithImplementation:(IMP)implementation {
    return nil;
}

@end
