//
//  EDABlockMacros.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 07.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#ifndef EDABlockMacros_h
#define EDABlockMacros_h

#import "EDAUtilityMacros.h"

#define __EDABlockCall(result, operation, block, ...) \
    do { \
        typeof(block) expression = block; \
        if (expression) { \
            result operation expression(__VA_ARGS__); \
        } \
    } while(0)

#define EDABlockCall(...) __EDABlockCall(EDAEmpty, EDAEmpty, __VA_ARGS__)

#define EDAResultBlockCall(result, ...) __EDABlockCall(result, =, __VA_ARGS__)

#define EDAReturnBlockCall(...) __EDABlockCall(EDAEmpty, return, __VA_ARGS__)

#endif /* EDABlockMacros_h */
