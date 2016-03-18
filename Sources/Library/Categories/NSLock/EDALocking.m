//
//  EDALocking.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 07.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDALocking.h"

#import "EDAReturnMacros.h"

static
void EDAPerformBlockWithLock(id<NSLocking> lock, EDALockedBlock block) {
    EDAReturnIfNil(block);
    
    [lock lock];
    block();
    [lock unlock];
}

#define EDASynthesizeLockingImplementation(class) \
@implementation class (__EDALockingExtensions__##class) \
\
- (void)performBlock:(EDALockedBlock)block { \
    EDAPerformBlockWithLock(self, block); \
} \
\
@end

EDASynthesizeLockingImplementation(NSLock)
EDASynthesizeLockingImplementation(NSRecursiveLock)
EDASynthesizeLockingImplementation(NSCondition)
EDASynthesizeLockingImplementation(NSConditionLock)

#undef EDASynthesizeLockingImplementation
