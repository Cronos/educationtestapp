//
//  NSError+EDAExtensions.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 16.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (EDAExtensions)

+ (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description;

@end
