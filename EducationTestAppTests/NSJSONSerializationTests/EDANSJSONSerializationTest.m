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
#import "EDAImp.h"
#import "EDAMock.h"

typedef id(*EDAMethodClassIMP)(id, SEL);
typedef BOOL(*EDAMethodIsKindOfClassIMP)(id, SEL, Class);
typedef BOOL(*EDAMethodIsMemberOfClassIMP)(id, SEL, Class);
typedef BOOL(*EDAMethodIsSubclassOfClassIMP)(id, SEL, Class);

@interface EDANSJSONSerializationTest : XCTestCase
@property (nonatomic, strong) NSMutableSet <NSString *> *calledMethods;
@property (nonatomic, strong) NSMutableDictionary <NSString *, EDAImp *> *savedImplementations;

@end

@implementation EDANSJSONSerializationTest

- (void)setUp {
    [super setUp];
    self.calledMethods = [NSMutableSet set];
    self.savedImplementations = [NSMutableDictionary dictionary];
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
#pragma mark Replace EDANull methods tests

- (void)testMethodsForDataWithJSONObject {
    [self.calledMethods removeAllObjects];
    
    [self replaceEDANullMethods];
    
    [EDAMock dataWithJSONEDANullObject:^(NSData *data) {
        XCTAssertNotNil(data, @"dataWithJSONObject not initialized");
        XCTAssertTrue(self.calledMethods.count == 2, @"JSONWithEDANullObject must to call 2 methods");
        XCTAssertTrue([self.calledMethods containsObject:@"isKindOfClass:"], @"[NSJSONSerialization dataWithJSONObject] must be call 'isKindOfClass' method");
        XCTAssertTrue([self.calledMethods containsObject:@"class"], @"[NSJSONSerialization dataWithJSONObject] must be call 'class' method");
    }];
    
    [self restoreEDANullMethods];
}

- (void)testMethodsForJSONObjectWithData {
    [EDAMock dataWithJSONEDANullObject:^(NSData *data) {
        [self.calledMethods removeAllObjects];
        
        [self replaceEDANullMethods];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        XCTAssertNotNil(array, @"JSONObjectWithData not initialized");
        XCTAssertTrue(self.calledMethods.count == 0, @"JSONWithEDANullObject must not call no methods");
    }];
    
    [self restoreEDANullMethods];
}

#pragma mark -
#pragma mark Store/restore implementation tests

- (void)testSaveImplementation {
    SEL selector = @selector(class);
    id object = [EDANull class];
    
    [self.calledMethods removeAllObjects];
    [self replaceEDANullMethodClass];

    Class class = [[EDANull null] class];       // call new method
    XCTAssertNotNil(class, @"edanullClass is nil");
    XCTAssertTrue(self.calledMethods.count == 1, @"New implementation of [[EDANull null] class] must save 1 methods");
    XCTAssertTrue([self.calledMethods containsObject:@"class"], @"New implementation of [[EDANull null] class] must be call 'class' method");
    
    [self.calledMethods removeAllObjects];
    [self restoreImplementationForSelector:selector forObject:object];
    
    class = [[EDANull null] class];             // call original method
    XCTAssertNotNil(class, @"edanullClass is nil");
    XCTAssertTrue(self.calledMethods.count == 0, @"Original implementation of [[EDANull null] class] must no save any methods");
    XCTAssertEqualObjects(NSStringFromClass(class), @"EDANull", @"class must be EDANull");

    selector = @selector(isSubclassOfClass:);
    
    [self.calledMethods removeAllObjects];
    [self replaceEDANullMethodIsSubclassOfClass];
    
    BOOL result = [EDANull isSubclassOfClass:[NSObject class]];
    XCTAssertTrue(result, @"edanullClass must be subclass of NSObject");
    XCTAssertTrue(self.calledMethods.count == 1, @"New implementation of [EDANull isSubclassOfClass] must save 1 methods");
    XCTAssertTrue([self.calledMethods containsObject:@"isSubclassOfClass:"], @"New implementation of [EDANull isSubclassOfClass] must be call 'isSubclassOfClass' method");
    
    [self.calledMethods removeAllObjects];
    [self restoreImplementationForSelector:selector forObject:object_getClass(object)];
    result = [EDANull isSubclassOfClass:[NSObject class]];
    XCTAssertTrue(result, @"edanullClass must be subclass of NSObject");
    XCTAssertTrue(self.calledMethods.count == 0, @"Original implementation of [EDANull isSubclassOfClass] must no save any methods");
}

#pragma mark -
#pragma mark Replace methods

- (void)prepareForReplaceSelector:(SEL)selector completion:(void (^)(id object, Class class, SEL selector))completion{
    id object = [EDANull class];
    Class class = object_getClass(object);
    
    completion ? completion(object, class, selector) : nil;
}

- (void)replaceEDANullMethodClass {
    [self prepareForReplaceSelector:@selector(class) completion:^(id object, __unsafe_unretained Class class, SEL selector) {
        EDABlockWithIMP block = ^(IMP implementation) {
            [self saveImplementationForSelector:selector forObject:object];
            EDAMethodClassIMP methodIMP = (EDAMethodClassIMP)implementation;

            return (id)^(id object) {
                [self.calledMethods addObject:NSStringFromSelector(selector)];
                
                return methodIMP(object, selector);
            };
        };
        
        [object setBlock:block forSelector:selector];
    }];
}

- (void)replaceEDANullMethodIsKindOfClass {
    [self prepareForReplaceSelector:@selector(isKindOfClass:) completion:^(id object, __unsafe_unretained Class class, SEL selector) {
        EDABlockWithIMP block = ^(IMP implementation) {
            [self saveImplementationForSelector:selector forObject:object];
            EDAMethodIsKindOfClassIMP methodIMP = (EDAMethodIsKindOfClassIMP)implementation;
            
            return (id)^(id object, Class class) {
                [self.calledMethods addObject:NSStringFromSelector(selector)];
                
                return methodIMP(object, selector, class);
            };
        };
        
        [object setBlock:block forSelector:selector];
    }];
}

- (void)replaceEDANullMethodIsMemberOfClass {
    [self prepareForReplaceSelector:@selector(isMemberOfClass:) completion:^(id object, __unsafe_unretained Class class, SEL selector) {
        EDABlockWithIMP block = ^(IMP implementation) {
            [self saveImplementationForSelector:selector forObject:object];
            EDAMethodIsMemberOfClassIMP methodIMP = (EDAMethodIsMemberOfClassIMP)implementation;
            
            return (id)^(id object, Class class) {
                [self.calledMethods addObject:NSStringFromSelector(selector)];
                
                return methodIMP(object, selector, class);
            };
        };
        
        [object setBlock:block forSelector:selector];
    }];
}

- (void)replaceEDANullMethodIsSubclassOfClass {
    [self prepareForReplaceSelector:@selector(isSubclassOfClass:) completion:^(id object, __unsafe_unretained Class class, SEL selector) {
        EDABlockWithIMP block = ^(IMP implementation) {
            [self saveImplementationForSelector:selector forObject:class];
            EDAMethodIsSubclassOfClassIMP methodIMP = (EDAMethodIsSubclassOfClassIMP)implementation;

            return (id)^(id object, Class class) {
                [self.calledMethods addObject:NSStringFromSelector(selector)];
                
                return methodIMP(object, selector, class);
            };
        };
        
        [class setBlock:block forSelector:selector];
    }];
}

#pragma mark -
#pragma mark Set/Get implementation methods

- (void)saveImplementationForSelector:(SEL)selector forObject:(id)object {
    IMP implementation = [object instanceMethodForSelector:selector];
    EDAImp *impObject = [EDAImp instanceWithImplementation:implementation];
    [self.savedImplementations setObject:impObject forKey:NSStringFromSelector(selector)];
}

- (void)restoreImplementationForMethod:(NSString *)methodName forObject:(id)object {
    SEL selector = NSSelectorFromString(methodName);
    [self restoreImplementationForSelector:selector forObject:object];
}

- (void)restoreImplementationForSelector:(SEL)selector forObject:(id)object {
    IMP implementation = [self storedImplementationForSelector:selector];
    if (implementation) {
        Method method = class_getInstanceMethod(object, selector);
        class_replaceMethod(object,
                            selector,
                            implementation,
                            method_getTypeEncoding(method));
    }
}

- (IMP)storedImplementationForSelector:(SEL)selector {
    NSString *method = NSStringFromSelector(selector);
    EDAImp *object = [self.savedImplementations objectForKey:method];
    [self.savedImplementations removeObjectForKey:method];
    return object.implementation;
}

- (void)replaceEDANullMethods {
    [self replaceEDANullMethodClass];
    [self replaceEDANullMethodIsKindOfClass];
    [self replaceEDANullMethodIsMemberOfClass];
    [self replaceEDANullMethodIsSubclassOfClass];
}

- (void)restoreEDANullMethods {
    id object = [EDANull class];
    for (NSString *methodName in @[@"class", @"isKindOfClass:", @"isMemberOfClass:"]) {
        [self restoreImplementationForMethod:methodName forObject:object];
    }
    [self restoreImplementationForSelector:@selector(isSubclassOfClass:) forObject:object_getClass(object)];
}
@end
