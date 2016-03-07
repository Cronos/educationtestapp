//
//  EDANetwork.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDANetwork.h"
#import "EDAReturnMacros.h"

NSString *EDAHTTPMethod(EDARequestMethod method) {
    switch (method) {
        EDAReturnValueInCase(@"GET", EDARequestMethodGET);
        EDAReturnValueInCase(@"POST", EDARequestMethodPOST);
        EDAReturnValueInCaseDefault(@"");
    }
}
