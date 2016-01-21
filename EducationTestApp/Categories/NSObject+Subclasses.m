//
//  NSObject+Subclasses.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSObject+Subclasses.h"
#import <objc/runtime.h>

@implementation NSObject (Subclasses)

+ (Class)metaclass {
    
    return objc_getMetaClass(object_getClassName(self));
}

+ (NSArray *)subclasses {
    NSMutableArray *subclasses = [NSMutableArray array];

    unsigned int numClasses;
    Class *classes = objc_copyClassList(&numClasses);
    
    if (numClasses > 0) {
        for (unsigned int i = 0; i < numClasses; i++) {
            Class class = classes[i];
            Class superClass = class_getSuperclass(class);

            if ( superClass == self) {
                [subclasses addObject:class];
            }
        }
        free(classes);
    }
    
    return [subclasses copy];
}

@end
