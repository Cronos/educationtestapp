//
//  EDAResponseRequestResult.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDADataModel.h"

@interface EDAResponseRequestResult : EDADataModel

@property (nonatomic, assign) BOOL  success;
@property (nonatomic, copy) NSString *info;

@end
