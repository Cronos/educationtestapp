//
//  EDAresponseLayout.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDAResponseLayout : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger totalCount;

+ (instancetype)layoutFromDictionary:(NSDictionary *)dictionary;

@end
