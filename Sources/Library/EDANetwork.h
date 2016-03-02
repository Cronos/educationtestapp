//
//  EDANetwork.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#ifndef EDANetwork_h
#define EDANetwork_h

#import "EDADefines.h"

typedef NS_ENUM(NSUInteger, EDARequestMethod) {
    EDARequestMethodGET     = 0,
    EDARequestMethodPOST
};

EDA_STATIC_INLINE
NSString *EDAHTTPMethod(EDARequestMethod method) {
    switch (method) {
        case EDARequestMethodGET:
            return @"GET";
            break;
            
        case EDARequestMethodPOST:
            return @"POST";
            break;
            
        default:
            return @"";
            break;
    }
}

#endif /* EDANetwork_h */
