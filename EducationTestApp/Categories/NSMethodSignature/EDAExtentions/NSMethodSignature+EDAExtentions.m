//
//  NSMethodSignature+EDAExtentions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSMethodSignature+EDAExtentions.h"
#import "NSObject+EDARuntime.h"

static const NSString * kEDAMethodSignatureNilForwarded    = @"kEDAMethodSignatureNilForwarded";

@implementation NSMethodSignature (EDAExtentions)

@dynamic nilForwarded;

#pragma mark -
#pragma mark Accessors

- (void)setNilForwarded:(BOOL)nilForwarded {
    [self setValue:@(nilForwarded) forPropertyKey:kEDAMethodSignatureNilForwarded associationPolicy:EDAPropertyNonatomicStrong];
}

- (BOOL)isNilForwarded {
    return [[self valueForPropertyKey:kEDAMethodSignatureNilForwarded] boolValue];
}

@end
