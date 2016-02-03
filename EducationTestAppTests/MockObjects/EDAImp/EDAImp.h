//
//  EDAImp.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDAImp : NSObject

- (void)setImplementation:(IMP)implementation;
- (IMP)implementation;

@end
