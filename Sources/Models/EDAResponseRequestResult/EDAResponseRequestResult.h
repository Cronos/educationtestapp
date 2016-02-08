//
//  EDAResponseRequestResult.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDAResponseRequestResult : NSObject

@property (nonatomic, assign) BOOL  success;
@property (nonatomic, copy) NSString *info;

+ (instancetype)resultFromDictionary:(NSDictionary *)dictionary;

@end
