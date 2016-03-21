//
//  EDAMacrosTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 21.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EDAWeakifyStrongifyMacros.h"
#import "EDAClangDiagnosticMacros.h"
#import "EDABlockMacros.h"

typedef id(^EDAIDBlock)();
typedef void *(^EDAVoidPointerBlock)();

@interface EDAMacrosTests : NSObject

@end

@implementation EDAMacrosTests

- (void)testMacroses {
    EDAPRAGMA(test expression)
    
    EDAPRAGMA(clang diagnostic push)
    
    EDAClangDiagnosticPush
    
    EDAClangDiagnosticPop
    
    EDAClangDiagnosticPushExpression(clang diagnostic ignored "-Wshadow")
    
    EDAClangDiagnosticPushIgnoreExpression(-Wshadow)
    
    EDAClangDiagnosticPopExpression
    
    EDAWeakify(self);
    
    id block = ^{
        EDAStrongify(self);
    };
    
    block = ^{
        EDAStrongifyAndReturnIfNil(self);
    };
    
};

- (void)performBlock:(EDAIDBlock)block {
    block ? block() : nil;
}

- (id)performPointerVoidBlock:(EDAVoidPointerBlock)block {
    id object = (__bridge id)(block ? block() : nil);
    
    return object;
}

- (id)performIDBlock:(EDAIDBlock)block {
    id object = (block ? block() : nil);
    
    return object;
}

- (id)testReturnNilMacros {
    id object = [NSObject new];
    EDAWeakify(object);
    
#pragma mark -
#pragma mark Preprocessing EDAStrongifyAndReturnNilIfNil
    
    EDAVoidPointerBlock block = ^{
        
//        EDAStrongifyAndReturnNilIfNil(object);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wshadow"
        __attribute__((objc_ownership(strong))) __typeof(object) object = __EDAWeakified_object
#pragma clang diagnostic pop
        ;
        do {
            if (!(object)) {
                return ((void *)0);
            }
        } while(0);
        
        return (__bridge void *)object;
    };
    
    id value = [self performPointerVoidBlock:block];
    object = value;
    
    return object;
}

- (id)testReturnValueMacros {
    id object = [NSObject new];
    EDAWeakify(object);
    
#pragma mark -
#pragma mark Preprocessing EDAStrongifyAndReturnValueIfNil
    
    EDAIDBlock block = ^{
        
//        EDAStrongifyAndReturnValueIfNil(object, (id)[NSObject new]);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wshadow"
        __attribute__((objc_ownership(strong))) __typeof(object) object = __EDAWeakified_object
#pragma clang diagnostic pop
        ;
        do {
            if (!(object)) {
                return (id)[NSObject new];
            }
        } while(0);
        
        return object;
    };
    
    id value = (id)[self performIDBlock:block];
    object = value;
    
    return object;
}

@end
