//
//  EDAResponseRequestResult.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAResponseRequestResult.h"

@implementation EDAResponseRequestResult

+ (instancetype)resultFromDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        EDAResponseRequestResult *result = [EDAResponseRequestResult new];
        
        result.success = [[dictionary objectForKey:@"sucess"] boolValue];
        result.info = [dictionary objectForKey:@"info"];
        
        return result;
    }
    
    return nil;
}

@end