//
//  NSNull+Runtime.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 20.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSNull+Runtime.h"
#import <objc/runtime.h>
#import "EDANull.h"
#import "NSObject+Runtime.h"

typedef id(*EDAClassIMP)(id, SEL);

@implementation NSNull (Runtime)

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        
//        Method originNullMethod = class_getClassMethod(class, @selector(null));
//        Method customNullMethod = class_getClassMethod(class, @selector(fakeNull));
//        method_exchangeImplementations(originNullMethod, customNullMethod);
//    });
    [self replaceNew];
    [self replaceAlloc];
    [self replaceAllocWithZone];
//    [self replaceNull];
}

+ (void)replaceNew {
    SEL selector = @selector(new);
    
    id object = [self class];
    Class class = object_getClass(object);
    if (class_isMetaClass(class)) {
        NSLog(@"Class %@ is metaclass", class);
    }
    
    IMP implementation = [class instanceMethodForSelector:selector];
    
    id block = ^(id object) {
        NSLog(@"Call [NSNull new]");
        
        return ((id(*)(id, SEL))implementation)(object, selector);
    };
    
    IMP blockIMP = imp_implementationWithBlock(block);
    
    Method method = class_getInstanceMethod(class, selector);
    class_replaceMethod(class, selector, blockIMP, method_getTypeEncoding(method));
}

+ (void)replaceAlloc {
    SEL selector = @selector(alloc);
    
    id object = [self class];
    Class class = object_getClass(object);
    if (class_isMetaClass(class)) {
        NSLog(@"Class %@ is metaclass", class);
    }
    
    IMP implementation = [class instanceMethodForSelector:selector];
    
    id block = ^(id object) {
        NSLog(@"Call [NSNull alloc]");
        
        return ((id(*)(id, SEL))implementation)(object, selector);
    };
    
    IMP blockIMP = imp_implementationWithBlock(block);
    
    Method method = class_getInstanceMethod(class, selector);
    class_replaceMethod(class, selector, blockIMP, method_getTypeEncoding(method));
}

+ (void)replaceAllocWithZone {
    SEL selector = @selector(allocWithZone:);
    
    id object = [self class];
    Class class = object_getClass(object);
    if (class_isMetaClass(class)) {
        NSLog(@"Class %@ is metaclass", class);
    }
    
    IMP implementation = [class instanceMethodForSelector:selector];
    
    id block = ^(id object, NSZone *zone) {
        NSLog(@"Call [NSNull allocWithZone]");
        
        return ((id(*)(id, SEL, NSZone *))implementation)(object, selector, zone);
    };
    
    IMP blockIMP = imp_implementationWithBlock(block);
    
    Method method = class_getInstanceMethod(class, selector);
    class_replaceMethod(class, selector, blockIMP, method_getTypeEncoding(method));

}

+ (void)replaceNull {
    SEL selector = @selector(null);
    
    id object = [self class];
    Class class = object_getClass(object);
    if (class_isMetaClass(class)) {
        NSLog(@"Class %@ is metaclass", class);
    }
    
    IMP implementation = [class instanceMethodForSelector:@selector(edaNull)];
    
    id block = ^(id object) {
        NSLog(@"Call [NSNull null]");
        
        return ((id(*)(id, SEL))implementation)(object, selector);
    };
    
    IMP blockIMP = imp_implementationWithBlock(block);
    
    Method method = class_getInstanceMethod(class, selector);
    class_replaceMethod(class, selector, blockIMP, method_getTypeEncoding(method));
    
}

+ (id)edaNull {
    return [EDANull null];
}

//+ (NSNull *)fakeNull {
//    
//    NSLog(@"[NSNull null] called");
//    NSLog(@"%@",[NSThread callStackSymbols]);
//
//    return [self fakeNull];
//}


@end
