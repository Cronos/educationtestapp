//
//  EDAImp.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDAImp : NSObject
@property (nonatomic, readonly) IMP implementation;

+ (instancetype)instanceWithImplementation:(IMP)implementation;

- (instancetype)initWithImplementation:(IMP)implementation;

@end