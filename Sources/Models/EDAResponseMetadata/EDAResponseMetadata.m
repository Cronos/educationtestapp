//
//  EDAResponseMetadata.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAResponseMetadata.h"
#import "EDAResponseRequestResult.h"
#import "EDAResponseLayout.h"

@implementation EDAResponseMetadata

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        EDAResponseMetadata *metadata = [EDAResponseMetadata new];
        metadata.request = [EDAResponseRequestResult instanceWithDictionary:[dictionary objectForKey:@"request"]];
        metadata.layout = [EDAResponseLayout instanceWithDictionary:[dictionary objectForKey:@"layout"]];
        
        return metadata;
    }
    
    return nil;
}

@end
