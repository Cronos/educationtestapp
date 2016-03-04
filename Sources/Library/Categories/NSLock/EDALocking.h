//
//  EDALocking.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EDALockingBlock)(void);

@protocol EDALocking <NSObject, NSLocking>

- (void)performBlock:(EDALockingBlock)block;

@end
