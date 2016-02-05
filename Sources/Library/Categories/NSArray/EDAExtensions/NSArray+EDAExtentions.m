//
//  NSArray+EDAExtensions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSArray+EDAExtensions.h"

@implementation NSArray (EDAExtensions)

+ (NSArray *)reverseArray:(NSArray *)array {
    return [array reverseArray];
}

- (NSArray *)reverseArray {
    return [[self reverseObjectEnumerator] allObjects];
}

@end
