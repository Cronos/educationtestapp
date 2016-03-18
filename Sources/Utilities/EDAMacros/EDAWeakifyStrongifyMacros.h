//
//  EDAWeakifyStrongifyMacros.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 18.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#ifndef EDAWeakifyStrongifyMacros_h
#define EDAWeakifyStrongifyMacros_h

#import "EDAUtilityMacros.h"
#import "EDAReturnMacros.h"

#pragma mark -
#pragma mark Weakify/Strongify Macroses

#define EDAWeakify(variable) \
    __weak __typeof(variable) __EDAWeakified_##variable = variable

#define EDAStrongify(variable) \
    EDAClangDiagnosticPushIgnoreExpression(-Wshadow) \
    __strong __typeof(variable) variable = __EDAWeakified_##variable \
    EDAClangDiagnosticPopExpression

#define EDAStrongifyAndReturnValueIfNil(variable, value) \
    EDAStrongify(variable); \
    EDAReturnValueIfNil(variable, value)

#define EDAStrongifyAndReturnIfNil(variable) \
    EDAStrongifyAndReturnValueIfNil(variable, EDAEmpty)

#define EDAStrongifyAndReturnNilIfNil(variable) \
    EDAStrongifyAndReturnValueIfNil(variable, nil)

#endif /* EDAWeakifyStrongifyMacros_h */
