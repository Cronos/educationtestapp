//
//  EDABlockMacros.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 07.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#ifndef EDABlockMacros_h
#define EDABlockMacros_h

#define __EDABlockCall(block, ...) \
    do { \
        typeof(block) expression = block; \
        if (expression) { \
            expression(__VA_ARGS__); \
        } \
    } while(0)

#define EDABlockCall(...) __EDABlockCall(__VA_ARGS__)

#endif /* EDABlockMacros_h */
