//
//  EDANetwork.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDANetwork.h"

#define __EDAReturnValueWithBreak(value) \
    return value; \
    break

#define EDAReturnValueInCase(value, expression) \
    case expression: \
    __EDAReturnValueWithBreak(value)

#define EDAReturnValueInCaseDefault(value) \
    default: \
    __EDAReturnValueWithBreak(value)

NSString *EDAHTTPMethod(EDARequestMethod method) {
    switch (method) {
        EDAReturnValueInCase(@"GET", EDARequestMethodGET);
        EDAReturnValueInCase(@"POST", EDARequestMethodPOST);
        EDAReturnValueInCaseDefault(@"");
    }
}
