//
//  EDARecordsRequest.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 09.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDARecordsListRequest.h"

NSString * const EDARecordsListRequestTemplate = @"?index=%lud&count=%lud";

@implementation EDARecordsListRequest

+ (instancetype)requestFromIndex:(NSUInteger)index count:(NSUInteger)count {
    NSString *path = [NSString stringWithFormat:EDARecordsListRequestTemplate, index, count];
    EDARecordsListRequest *request = [self requestWithPath:path];
    [request setContentType:@"application/json; charset=utf-8"];
    
    return request;
}

@end
