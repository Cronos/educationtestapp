//
//  EDAResponseMetadata.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDAResponseRequestResult, EDAResponseLayout;

@interface EDAResponseMetadata : NSObject

@property (nonatomic, strong) EDAResponseRequestResult  *request;
@property (nonatomic, strong) EDAResponseLayout         *layout;

+ (instancetype)metaFromDictionary:(NSDictionary *)dictionary;

@end
