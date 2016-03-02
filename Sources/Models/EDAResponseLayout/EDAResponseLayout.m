//
//  EDAresponseLayout.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAResponseLayout.h"

@implementation EDAResponseLayout

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        EDAResponseLayout *layout = [EDAResponseLayout new];
        layout.index = [[dictionary objectForKey:@"index"] integerValue];
        layout.count = [[dictionary objectForKey:@"count"] integerValue];
        layout.totalCount = [[dictionary objectForKey:@"totalCount"] integerValue];
        
        return layout;
    }
    
    return nil;
}

@end