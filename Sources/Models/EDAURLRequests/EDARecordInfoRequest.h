//
//  EDARecordInfoRequest.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 09.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAURLRequest.h"

@interface EDARecordInfoRequest : EDAURLRequest

+ (instancetype)requestWithId:(NSInteger)ID;

@end
