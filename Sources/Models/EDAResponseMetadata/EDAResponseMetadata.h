//
//  EDAResponseMetadata.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDAModel.h"

@class EDAResponseRequestResult, EDAResponseLayout;

@interface EDAResponseMetadata : EDAModel
@property (nonatomic, strong) EDAResponseRequestResult  *request;
@property (nonatomic, strong) EDAResponseLayout         *layout;

@end
