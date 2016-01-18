//
//  EDANSJSONSerializationTest.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 14.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>

@interface EDANSJSONSerializationTest : XCTestCase

@end

@implementation EDANSJSONSerializationTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSerializationToArrayWithNullObject {
    
    NSArray *array = @[[NSNull null]];
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    
    XCTAssertNil(error, @"serialization from array error");
    XCTAssertNotNil(data, @"data init error");
    
    error = nil;
    id deserializedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    XCTAssertNil(error, @"deserialization error");
    XCTAssertTrue([deserializedObject isKindOfClass:[NSArray class]], @"deserializedObject must be kind of NSArray");
    
}


- (void)test_NullInstanceMethods {
    
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

- (void)test_NullClassMethods {
    
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

@end
