//
//  NSObject+EDARuntime.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSObject+EDARuntime.h"
#import <objc/runtime.h>

@implementation NSObject (EDARuntime)

+ (void)setBlock:(EDABlockWithIMP)block forSelector:(SEL)selector {
    IMP implementation = [self instanceMethodForSelector:selector];
    
    IMP blockIMP = imp_implementationWithBlock(block(implementation));
    
    Method method = class_getInstanceMethod(self, selector);
    class_replaceMethod(self,
                        selector,
                        blockIMP,
                        method_getTypeEncoding(method));
}

+ (Class)metaclass {
    return objc_getMetaClass(object_getClassName(self));
}

+ (NSSet *)subclasses {
    NSMutableSet *subclasses = [NSMutableSet set];

    unsigned int classCount = 0;
    Class *classes = objc_copyClassList(&classCount);
    
    for (unsigned int index = 0; index < classCount; index++) {
        Class superClass = classes[index];
        
        do {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != self);
        
        if (superClass) {
            [subclasses addObject:classes[index]];
        }
    }
    if (classes) {
        free(classes);
    }
    
    return [subclasses copy];
}

#pragma mark -
#pragma mark AssociatedObject methods

- (void)setValue:(id)value forPropertyKey:(const NSString *)key associationPolicy:(EDAPropertyPolicy)policy {
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, (objc_AssociationPolicy)policy);
}

- (id)valueForPropertyKey:(const NSString *)key {
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

#pragma mark -
#pragma mark Register/Unregister class

+ (Class)subclassWithName:(NSString *)name {
    Class newClass = objc_allocateClassPair(self, [name UTF8String], 0);
    objc_registerClassPair(newClass);
    
    return newClass;
}

+ (void)unregister {
    objc_disposeClassPair(self);
}

@end
