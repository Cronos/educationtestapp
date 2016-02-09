//
//  EDAResponseMetadata.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDADataModel.h"

@class EDAResponseRequestResult, EDAResponseLayout;

@interface EDAResponseMetadata : EDADataModel

@property (nonatomic, strong) EDAResponseRequestResult  *request;
@property (nonatomic, strong) EDAResponseLayout         *layout;

@end
