//
//  NSString+EDAExtensions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 29.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSString+EDAExtensions.h"

@implementation NSString (EDAExtensions)

- (NSArray *)separatedWithChars:(NSString *)chars {
    return [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:chars]];
}

@end
