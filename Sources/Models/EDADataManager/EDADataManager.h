//
//  EDADataManager.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDAResponse, EDAData;

typedef void(^EDAErrorBlock)(NSError *error);

@interface EDADataManager : NSObject
@property (nonatomic, readonly) NSInteger totalRecordsCount;
@property (nonatomic, readonly) NSInteger count;

+ (instancetype)sharedManager;

- (EDAData *)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)fetchDataCount:(NSUInteger)recordsCount completion:(void (^)(NSUInteger index, NSUInteger count))completion error:(EDAErrorBlock)error;


@end
