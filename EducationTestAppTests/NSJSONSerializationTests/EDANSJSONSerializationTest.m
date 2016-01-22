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

@interface EDANSJSONSerializationTest : XCTestCase

@end

@implementation EDANSJSONSerializationTest


#define EDAMethodList(class) \
/*    Class class = [aClass class]; \ */ \
    unsigned int methodCount = 0; \
    Method *methods = class_copyMethodList(class, &methodCount); \
    NSLog(@"\n\nFound %d methods on %s\n\n", methodCount, class_getName(class)); \
    for (unsigned int i = 0; i < methodCount; i++) { \
        Method method = methods[i]; \
        NSLog(@"\t'%s' has method named \n\t\t '%s' of encoding '%s'\n", \
              class_getName(class), \
              sel_getName(method_getName(method)), \
              method_getTypeEncoding(method)); \
    }\
    free(methods)

- (void)testNSJSONSerializationClassMethods {
    EDAMethodList(object_getClass([NSJSONSerialization class]));
}

- (void)testNSJSONSerializationInstanceMethods {
    EDAMethodList([NSJSONSerialization class]);
}

- (void)testNSJSONReaderClassMethods {
    Class privateClass = objc_getClass("_NSJSONReader");
    EDAMethodList(object_getClass(privateClass));
}

- (void)testNSJSONReaderInstanceMethods {
    EDAMethodList(objc_getClass("_NSJSONReader"));
}

- (void)testNSJSONReaderIvars {
    Class class = objc_getClass("_NSJSONReader");
    unsigned int ivarCount = 0;
    
    Ivar *ivars = class_copyIvarList(class, &ivarCount);
    
    NSLog(@"Found %d ivars on %s\n", ivarCount, class_getName(class));
    
    for (unsigned int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivars[i];
        
        NSLog(@"\t'%s' has ivar named \n>>> '%s' of encoding '%s'\n",
              class_getName(class),
              ivar_getName(ivar),
              ivar_getTypeEncoding(ivar));
    }
    
    free(ivars);
}

- (void)testNSJSONSerializationProperties {
    Class class = [NSJSONSerialization class];

    unsigned int propertiesCount = 0;
    
    objc_property_t *properties = class_copyPropertyList(class, &propertiesCount);
    
    NSLog(@"Found %d properties on %s\n", propertiesCount, class_getName(class));
    
    for (unsigned int i = 0; i < propertiesCount; i++) {
        objc_property_t property = properties[i];
        
        NSLog(@"\t'%s' has properties named \n>>> '%s'\n",
              class_getName(class),
              property_getName(property));
    }
    
    free(properties);
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


@end
