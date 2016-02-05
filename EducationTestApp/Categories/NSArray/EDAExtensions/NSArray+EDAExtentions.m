//
//  NSArray+EDAExtensions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSArray+EDAExtensions.h"

@implementation NSArray (EDAExtensions)

-(NSArray *)reverse {
    return [[self reverseObjectEnumerator] allObjects];
}

+(NSArray *)reverseArray:(NSArray *)array {
    return [array reverse];
}

@end
