//
//  EDAData.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAData.h"

@implementation EDAData

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        EDAData *data = [EDAData new];
        data.Id = [[dictionary objectForKey:@"id"] integerValue];
        data.content =[dictionary objectForKey:@"content"];
        data.message = [dictionary objectForKey:@"message"];
        data.image = [dictionary objectForKey:@"image"];
        data.images = [dictionary objectForKey:@"images"];
        
        return data;
    }
    
    return nil;
}

+ (NSArray<EDAData*> *)arrayFromArray:(NSArray *)array {
    NSMutableArray *newArray = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        EDAData *data = [EDAData instanceWithDictionary:dictionary];
        if (data) {
            [newArray addObject:data];
        }
    }
    
    return [newArray copy];
}

@end
