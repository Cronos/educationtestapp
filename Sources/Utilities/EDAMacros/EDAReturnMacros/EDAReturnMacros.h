//
//  EDAReturnMacros.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 07.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#ifndef EDAReturnMacros_h
#define EDAReturnMacros_h

#define EDAReturnValueIfNil(condition, value) \
    do { \
        if (!(condition)) { \
            return value; \
        } \
    } while(0)

#define EDAEmpty

#define EDAReturnNilIfNil(condition) EDAReturnValueIfNil((condition), nil)
#define EDAReturnIfNil(condition) EDAReturnValueIfNil((condition), EDAEmpty)

// for SWITCH

#define __EDAReturnValueWithBreak(value) \
    return value; \
    break

#define EDAReturnValueInCase(value, expression) \
    case expression: \
    __EDAReturnValueWithBreak(value)

#define EDAReturnValueInCaseDefault(value) \
    default: \
    __EDAReturnValueWithBreak(value)

#endif /* EDAReturnMacros_h */
