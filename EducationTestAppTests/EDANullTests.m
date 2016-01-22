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

- (void)testInitialize {
    EDANull *nullObject = [EDANull null];

    XCTAssertTrue([nullObject isKindOfClass:[EDANull class]], @"nullObject must be EDANull");
}

#define EDANullArchived [NSKeyedArchiver archivedDataWithRootObject:[EDANull null]]

- (void)testNSKeyedArchiver {
    NSData *data = EDANullArchived;
    
    XCTAssertNotNil(data, @"[EDANull null] archive error");
}

- (void)testNSKeyedUnarchiver {
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:EDANullArchived];
    XCTAssertNotNil(object, @"[EDANull null] unarchive error");
    XCTAssertTrue([object isKindOfClass:[EDANull class]], @"object must be EDANull class");
}

- (void)testSerializationEDANullToJSON {
    
//    [self replaceClassMethod];
//    [self replaceIsKindOfClassMethod];
//    [self replaceIsMemberOfClassMethod];
//    [self replaceIsSubclassOfClassMethod];
    

    NSArray *array = @[[EDANull null]];
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    
    XCTAssertNil(error, @"serialization from array error");
    XCTAssertNotNil(data, @"data init error");
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
        //        NSLog(@"Call [%@ %@%@]", NSStringFromClass([object class]), NSStringFromSelector(selector), NSStringFromClass(class));
        NSLog(@"Call [EDANull %@]", NSStringFromSelector(selector));
        
        return ((id(*)(id, SEL))implementation)(object, selector);
    };
    
    IMP blockIMP = imp_implementationWithBlock(block);
    
    Method method = class_getInstanceMethod(class, selector);
    class_replaceMethod(class, selector, blockIMP, method_getTypeEncoding(method));
    
}

- (void)replaceIsKindOfClassMethod {
    SEL selector = @selector(isKindOfClass:);
    
    //    id object = [EDANull class];
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
    
    //    id object = [EDANull class];
    id object = [EDANull null];
    Class class = object_getClass(object);
    if (class_isMetaClass(class)) {
        NSLog(@"Class %@ is metaclass", class);
    }
    
    // new IMP
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
    
    // new IMP
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
