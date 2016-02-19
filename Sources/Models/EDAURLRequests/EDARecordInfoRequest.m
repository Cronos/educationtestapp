//
//  EDARecordInfoRequest.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 09.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDARecordInfoRequest.h"

NSString * const EDARecordInfoRequestTemplate = @"data/%ld";

@implementation EDARecordInfoRequest

+ (instancetype)requestWithId:(NSInteger)ID {
    NSString *path = [NSString stringWithFormat:EDARecordInfoRequestTemplate, (long)ID];
    EDARecordInfoRequest *request = [self requestWithPath:path];
    [request setContentType:@"application/json; charset=utf-8"];
    
    return request;
}

@end
