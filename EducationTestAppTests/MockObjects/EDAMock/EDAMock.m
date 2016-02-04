//
//  EDAMock.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAMock.h"
#import "NSobject+EDARuntime.h"
#import "EDANull.h"

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
        parentClass = [parentClass subclassWithName:name];
    }
}

+ (void)EDANullArchivedData:(void(^)(NSData *data))block {
    block ? block([NSKeyedArchiver archivedDataWithRootObject:[EDANull null]]) : nil;
}

+ (void)dataWithJSONEDANullObject:(void(^)(NSData *data))block {
    block ? block([NSJSONSerialization dataWithJSONObject:@[[EDANull null]] options:NSJSONWritingPrettyPrinted error:nil]) : nil;
}

@end
