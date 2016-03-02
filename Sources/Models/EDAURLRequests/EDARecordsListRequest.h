//
//  EDARecordsRequest.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 09.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAURLRequest.h"

@interface EDARecordsListRequest : EDAURLRequest

+ (instancetype)requestFromIndex:(NSUInteger)index count:(NSUInteger)count;

@end
