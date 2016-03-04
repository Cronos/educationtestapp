//
//  EDAResponse.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAResponse.h"
#import "EDAResponseMetadata.h"
#import "EDAData.h"
#import "EDAAPIKeys.h"

@implementation EDAResponse

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        EDAResponse *response = [EDAResponse new];
        response.meta = [EDAResponseMetadata instanceWithDictionary:dictionary[EDAKeyMeta]];
        response.data = [EDAData arrayFromArray:dictionary[EDAKeyData]];
        
        return response;
    }
    
    return nil;
}

@end
