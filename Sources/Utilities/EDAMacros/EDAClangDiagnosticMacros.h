//
//  EDAClangDiagnosticMacros.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 18.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//
//  Clang Compiler User's Manual http://clang.llvm.org/docs/UsersManual.html
//  Clang Semantic Warnings http://fuckingclangwarnings.com/

#ifndef EDAClangDiagnosticMacros_h
#define EDAClangDiagnosticMacros_h

#define EDAPRAGMA(expression) \
    _Pragma(#expression)

#define EDAClangDiagnosticPush \
    EDAPRAGMA(clang diagnostic push)

#define EDAClangDiagnosticPop \
    EDAPRAGMA(clang diagnostic pop)

#define EDAClangDiagnosticPushExpression(...) \
    EDAClangDiagnosticPush \
    EDAPRAGMA(__VA_ARGS__)

#define EDAClangDiagnosticPushIgnoreExpression(key) \
    EDAClangDiagnosticPushExpression(clang diagnostic ignored #key)

#define EDAClangDiagnosticPopExpression \
    EDAClangDiagnosticPop

#endif /* EDAClangDiagnosticMacros_h */
