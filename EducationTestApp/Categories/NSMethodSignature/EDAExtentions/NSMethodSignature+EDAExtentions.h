//
//  NSMethodSignature+EDAExtentions.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMethodSignature (EDAExtentions)
@property (nonatomic, assign, getter=isNilForwarded)    BOOL nilForwarded;

@end
