//
//  NSError+EDAExtensions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 16.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSError+EDAExtensions.h"

@implementation NSError (EDAExtensions)

+ (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description {
    NSString *domain = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *dictionary = @{ NSLocalizedDescriptionKey : description };
    
    return [NSError errorWithDomain:domain code:code userInfo:dictionary];
}

@end
