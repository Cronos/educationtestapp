//
//  EDAData.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDAData : NSObject

@property (nonatomic, assign) NSInteger             Id;
@property (nonatomic, copy) NSString                *content;
@property (nonatomic, copy) NSString                *message;
@property (nonatomic, copy) NSString                *image;
@property (nonatomic, strong) NSArray <NSString*>   *images;

+ (instancetype)dataFromDictionary:(NSDictionary *)dictionary;
+ (NSArray<EDAData*> *)arrayFromArray:(NSArray *)array;

@end
