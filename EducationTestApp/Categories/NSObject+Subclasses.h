//
//  NSObject+Subclasses.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Subclasses)

+ (Class)metaclass;
+ (NSArray *)subclasses;

@end
