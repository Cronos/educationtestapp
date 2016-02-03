//
//  EDAMock.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAMock.h"
#import "NSobject+EDARuntime.h"

@implementation EDAMock

#pragma mark -
#pragma mark Create list of custom class names

+ (NSArray <NSString *> *)customClassNames:(NSString *)name withCapacity:(NSInteger)count {
    NSMutableArray <NSString *> *array = [NSMutableArray array];
    for (NSInteger index = 0; index < count; index++) {
        [array addObject:[NSString stringWithFormat:@"%@%ld", name, index+1]];
    }
    
    return [array copy];
}

#pragma mark -
#pragma mark Register custom classes

+ (void)registerCustomClassesWithNames:(NSArray <NSString *> *)names withRootClass:(Class)class {
    Class parentClass = class;
    for (NSString *name in names) {
        parentClass = [parentClass registerClassWithName:name];
    }
}

@end
