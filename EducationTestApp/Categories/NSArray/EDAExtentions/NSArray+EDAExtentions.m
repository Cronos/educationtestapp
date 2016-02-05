//
//  NSArray+EDAExtentions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSArray+EDAExtentions.h"

@implementation NSArray (EDAExtentions)

+ (NSArray *)reverseArray:(NSArray *)array {
    return [array reverseArray];
}

- (NSArray *)reverseArray {
    return [[self reverseObjectEnumerator] allObjects];
}

@end
