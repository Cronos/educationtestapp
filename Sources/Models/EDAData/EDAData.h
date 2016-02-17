//
//  EDAData.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDADataModel.h"

@interface EDAData : EDADataModel
@property (nonatomic, assign) NSUInteger            index;
@property (nonatomic, assign) NSInteger             Id;
@property (nonatomic, copy) NSString                *content;
@property (nonatomic, copy) NSString                *message;
@property (nonatomic, copy) NSString                *image;
@property (nonatomic, strong) NSArray <NSString*>   *images;

+ (NSArray<EDAData*> *)arrayFromArray:(NSArray *)array;

@end
