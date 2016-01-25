//
//  EDANullTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 14.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EDANull.h"
#import <objc/runtime.h>

@interface EDANullTests : XCTestCase

@end

@implementation EDANullTests

#define EDANullArchived \
[NSKeyedArchiver archivedDataWithRootObject:[EDANull null]]

#define JSONWithEDANullObject \
[NSJSONSerialization dataWithJSONObject:@[[EDANull null]] options:NSJSONWritingPrettyPrinted error:nil]

- (void)testInitialize {
    
    EDANull *nullValue = [EDANull new];
    
    XCTAssertTrue([nullValue isMemberOfClass:[EDANull class]], @"nullObject must be EDANull");
}

- (void)testIsKindOfClass {
    XCTAssertTrue([[EDANull null] isKindOfClass:[NSNull class]], @"EDANull must be kind of NSNull");
}

#pragma mark -
#pragma mark Behavior tests

- (void)testSendUnknownMessages {
    id nullObject = [EDANull null];
    XCTAssertNoThrow([nullObject loadView], @"EDANull throw when send unknown message");
    XCTAssertNoThrow([nullObject view], @"EDANull throw when send unknown message");
    XCTAssertNoThrow([nullObject count], @"EDANull throw when send unknown message");
    XCTAssertNoThrow([nullObject frame], @"EDANull throw when send unknown message");
}

- (void)testNSNullMethods {
    id nullObject = [EDANull null];
    XCTAssertNoThrow([nullObject description], @"EDANull throw when send description");
    XCTAssertNoThrow([nullObject class], @"EDANull throw when send class");
}

- (void)testReturnValues {
    id nullObject = [EDANull null];
    XCTAssertNil([nullObject view], @"[[EDANull null] view] must be return nil");
    XCTAssertTrue([nullObject count] == 0, @"[[EDANull null] count] must be return zero");
    XCTAssertTrue(CGRectIsEmpty([nullObject frame]), @"[[EDANull null] frame] must be return empty rect");
}

- (void)testComparing {
    id nullObject = [EDANull null];
    XCTAssertNoThrow([nullObject isEqual:[NSNull null]], @"EDANull throw when compare with [NSNull null]");
    XCTAssertTrue([nullObject isEqual:[NSNull null]], @"EDANull must be equals to [NSNull null]");
    XCTAssertTrue([nullObject hash] == [[NSNull null] hash], @"EDANull hash must be equals to NSNull hash");
    XCTAssertTrue([nullObject isEqual:nil], @"EDANull must be equals to nil");
    XCTAssertTrue([nullObject isEqual:nullObject], @"EDANull must be equals to self");
    XCTAssertFalse([nullObject isEqual:[NSObject new]], @"EDANull must be not equals to NSObject");
}

#pragma mark -
#pragma mark NSCoding protocol tests

- (void)testNSKeyedArchiver {
    NSData *data = EDANullArchived;
    XCTAssertNotNil(data, @"[EDANull null] archive error");
}

- (void)testNSKeyedUnarchiver {
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:EDANullArchived];
    XCTAssertNotNil(object, @"[EDANull null] unarchive error");
    XCTAssertTrue([object isMemberOfClass:[EDANull class]], @"object must be EDANull class");
}

#pragma mark -
#pragma mark JSONSerialization tests

- (void)testSerializationEDANullToJSON {
    NSData *data = JSONWithEDANullObject;
    XCTAssertNotNil(data, @"data init error");
}

- (void)testSerializationJSONToEDANull {
    NSError *error = nil;
    NSData *data = JSONWithEDANullObject;
    XCTAssertNotNil(data, @"data init error");

    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    XCTAssertNil(error, @"serialization to array error");
    XCTAssertEqual(array.count, 1, @"array.count must be is equals to 1");
    Class class = [array[0] class];
    XCTAssertTrue(class == [EDANull class], @"object must be EDANull class instead %@", class);
}

#pragma mark -
#pragma mark replace EDANull methods

- (void)replaceClassMethod {
    
    SEL selector = @selector(class);
    
    id object = [EDANull class];
    Class class = object_getClass(object);
    if (class_isMetaClass(class)) {
        NSLog(@"Class %@ is metaclass", class);
    }
    
    IMP implementation = [class instanceMethodForSelector:selector];
    
    id block = ^(id object) {
        NSLog(@"Call [EDANull %@]", NSStringFromSelector(selector));
        
        return ((id(*)(id, SEL))implementation)(object, selector);
    };
    
    IMP blockIMP = imp_implementationWithBlock(block);
    
    Method method = class_getInstanceMethod(class, selector);
    class_replaceMethod(class, selector, blockIMP, method_getTypeEncoding(method));
    
}

- (void)replaceIsKindOfClassMethod {
    SEL selector = @selector(isKindOfClass:);
    
    id object = [EDANull null];
    Class class = object_getClass(object);
    if (class_isMetaClass(class)) {
        NSLog(@"Class %@ is metaclass", class);
    }
    
    IMP implementation = [class instanceMethodForSelector:selector];
    
    id block = ^(id object, Class class) {
        NSLog(@"Call [EDANull %@]", NSStringFromSelector(selector));
        NSLog(@"\n\nStack\n\n\n%@\n\n\n",[NSThread callStackSymbols]);
        if ([object isEqual:[EDANull null]]) {
            return YES;
        }
        return ((BOOL(*)(id, SEL, Class))implementation)(object, selector, class);
    };
    
    IMP blockIMP = imp_implementationWithBlock(block);
    
    Method method = class_getInstanceMethod(class, selector);
    class_replaceMethod(class, selector, blockIMP, method_getTypeEncoding(method));
}

- (void)replaceIsMemberOfClassMethod {
    SEL selector = @selector(isMemberOfClass:);
    
    id object = [EDANull null];
    Class class = object_getClass(object);
    if (class_isMetaClass(class)) {
        NSLog(@"Class %@ is metaclass", class);
    }
    
    IMP implementation = [class instanceMethodForSelector:selector];
    
    id block = ^(id object, Class class) {
        NSLog(@"Call [EDANull isMemberOfClass %@]", NSStringFromSelector(selector));
        
        return ((BOOL(*)(id, SEL, Class))implementation)(object, selector, class);
    };
    
    IMP blockIMP = imp_implementationWithBlock(block);
    
    Method method = class_getInstanceMethod(class, selector);
    class_replaceMethod(class, selector, blockIMP, method_getTypeEncoding(method));
}

- (void)replaceIsSubclassOfClassMethod {
    SEL selector = @selector(isSubclassOfClass:);
    
    id object = [EDANull class];
    Class class = object_getClass(object);
    if (class_isMetaClass(class)) {
        NSLog(@"Class %@ is metaclass", class);
    }
    
    IMP implementation = [class instanceMethodForSelector:selector];
    
    id block = ^(id object, Class class) {
        NSLog(@"Call [EDANull isSubclassOfClass %@]", NSStringFromSelector(selector));
        
        return ((BOOL(*)(id, SEL, Class))implementation)(object, selector, class);
    };
    
    IMP blockIMP = imp_implementationWithBlock(block);
    
    Method method = class_getInstanceMethod(class, selector);
    class_replaceMethod(class, selector, blockIMP, method_getTypeEncoding(method));
}

@end
