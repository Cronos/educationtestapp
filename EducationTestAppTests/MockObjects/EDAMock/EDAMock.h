//
//  EDAMock.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDAMock : NSObject

+ (NSArray <NSString *> *)customClassNames:(NSString *)name withCapacity:(NSInteger)count;
+ (void)registerCustomClassesWithNames:(NSArray <NSString *> *)names withRootClass:(Class)class;

@end
