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

@implementation EDAResponse

+ (instancetype)responseFromDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {

        EDAResponse *response = [EDAResponse new];
        response.meta = [EDAResponseMetadata metaFromDictionary:dictionary[@"meta"]];
        response.data = [EDAData arrayFromArray:dictionary[@"data"]];
        
        return response;
    }
    
    return nil;
}

@end
