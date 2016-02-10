//
//  EDARecordsRequest.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 09.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDARecordsListRequest.h"

NSString * const EDARecordsListRequestTemplate = @"data?index=%ld&count=%ld";

@implementation EDARecordsListRequest

+ (instancetype)requestFromIndex:(NSInteger)index count:(NSInteger)count {
    NSString *path = [NSString stringWithFormat:EDARecordsListRequestTemplate, index, count];
    EDARecordsListRequest *request = [self requestWithPath:path];
    [request setContentType:@"application/json; charset=utf-8"];
    
    return request;
}

@end
