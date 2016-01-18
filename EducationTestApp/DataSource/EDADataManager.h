//
//  EDADataManager.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 05.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDADataManager : NSObject

+ (instancetype)manager;

- (NSUInteger)count;

@end
