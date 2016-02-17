//
//  EDADataManager.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDAResponse, EDAData;

typedef void(^EDAResponseAndErrorBlock)(EDAResponse *response, NSError *error);
typedef void(^EDAErrorBlock)(NSError *error);

@interface EDADataManager : NSObject
@property (nonatomic, readonly) NSInteger totalRecordsCount;
@property (nonatomic, readonly) NSInteger count;

+ (instancetype)sharedManager;

- (EDAData *)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)fetchDataForRecordsFromIndex:(NSUInteger)index count:(NSUInteger)count completion:(EDAErrorBlock)completion;

@end
