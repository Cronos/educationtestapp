//
//  NSArray+EDAExtentions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSArray+EDAExtentions.h"

@implementation NSArray (EDAExtentions)

-(NSArray *)reverse {
    return [[self reverseObjectEnumerator] allObjects];
}

+(NSArray *)reverseArray:(NSArray *)array {
    return [array reverse];
}

@end
