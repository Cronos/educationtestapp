//
//  NSDictionary+NSNull.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 18.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <objc/runtime.h>
#import "NSDictionary+NSNull.h"
#import "EDANull.h"

@interface NSDictionary (NSNullPrivate)

- (id)customValueForKey:(NSString *)key;
- (id)customObjectForKeyedSubscript:(id)key;

@end

@implementation NSDictionary (NSNull)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
//        Method originSetValueForKeyMethod = class_getInstanceMethod(selfClass, @selector(setValue:forKey:));
//        Method customSetValueForKeyMethod = class_getInstanceMethod(selfClass, @selector(customSetValue:forKey:));
//        method_exchangeImplementations(originSetValueForKeyMethod, customSetValueForKeyMethod);

        Method originSetObjectForKeyMethod = class_getInstanceMethod(selfClass, @selector(setObject:forKey:));
        Method customSetObjectForKeyMethod = class_getInstanceMethod(selfClass, @selector(customSetObject:forKey:));
        method_exchangeImplementations(originSetObjectForKeyMethod, customSetObjectForKeyMethod);

        
        Method originValueForKeyMethod = class_getInstanceMethod(selfClass, @selector(valueForKey:));
        Method customValueForKeyMethod = class_getInstanceMethod(selfClass, @selector(customValueForKey:));
        method_exchangeImplementations(originValueForKeyMethod, customValueForKeyMethod);
        
        Method originObjectForKeyedSubscriptMethod = class_getInstanceMethod(selfClass, @selector(objectForKeyedSubscript:));
        Method customObjectForKeyedSubscriptMethod = class_getInstanceMethod(selfClass, @selector(customObjectForKeyedSubscript:));
        method_exchangeImplementations(originObjectForKeyedSubscriptMethod, customObjectForKeyedSubscriptMethod);
    });
}

#pragma mark -
#pragma mark Setters

//TODO:
//- (void)customSetValue:(id)value forKey:(NSString *)key {
//    NSLog(@"self class is %@", NSStringFromClass([self class]));
//
//    id object = value;
//    if ([value isEqual:[NSNull null]]) {
//        object = [EDANull null];
//    }
//    [self customSetValue:object forKey:key];
//}

- (void)customSetObject:(id)object forKey:(NSString *)key {
    
    id value = object;
    if ([object isEqual:[NSNull null]]) {
        value = [EDANull null];
    }
    [self customSetObject:value forKey:key];
}

#pragma mark -
#pragma mark Getters

#define EDAReturnEDANullInsteadNSNull(object) \
    if ([object isEqual:[NSNull null]]) { \
        return [EDANull null]; \
    } \
    return object


- (id)customValueForKey:(NSString *)key {
    id object = [self customValueForKey:key];
    EDAReturnEDANullInsteadNSNull(object);
}

- (id)customObjectForKeyedSubscript:(id)key {
    id object = [self customObjectForKeyedSubscript:key];
    EDAReturnEDANullInsteadNSNull(object);
}


@end
