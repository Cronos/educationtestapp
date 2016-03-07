//
//  EDALocking.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EDALockedBlock)(void);

@protocol EDALocking <NSObject, NSLocking>

- (void)performBlock:(EDALockedBlock)block;

@end

#define EDASynthesizeLockingInterface(class) \
@interface class (__EDALockingExtensions__##class) <EDALocking> \
@end

EDASynthesizeLockingInterface(NSLock)
EDASynthesizeLockingInterface(NSRecursiveLock)
EDASynthesizeLockingInterface(NSCondition)
EDASynthesizeLockingInterface(NSConditionLock)

#undef EDASynthesizeLockingInterface
