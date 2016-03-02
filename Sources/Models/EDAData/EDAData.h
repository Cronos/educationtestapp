//
//  EDAData.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDADataModel.h"

@class EDAData;

typedef void(^EDADataBlock)(EDAData *data);

@interface EDAData : EDADataModel
@property (nonatomic, assign) NSUInteger            index;
@property (nonatomic, assign) NSInteger             ID;
@property (nonatomic, copy) NSString                *content;
@property (nonatomic, copy) NSString                *message;
@property (nonatomic, copy) NSString                *image;
@property (nonatomic, strong) NSArray <NSString*>   *images;
@property (nonatomic, copy) EDADataBlock            didUpdatedBlock;

+ (NSArray<EDAData*> *)arrayFromArray:(NSArray *)array;
+ (instancetype)dataWithIndex:(NSUInteger)index;

- (instancetype)initWithIndex:(NSUInteger)index;

- (void)setPropertyValueWithData:(EDAData *)data;

- (void)fetchData;
- (void)cancelFetchData;

@end
