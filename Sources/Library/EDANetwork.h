//
//  EDANetwork.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#ifndef EDANetwork_h
#define EDANetwork_h

typedef NS_ENUM(NSUInteger, EDARequestMethod) {
    EDARequestMethodGET     = 0,
    EDARequestMethodPOST
};

NSString *EDAHTTPMethod(EDARequestMethod method);

#endif /* EDANetwork_h */
