//
//  NSJSONSerialization+Swizzling.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 20.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "NSJSONSerialization+Swizzling.h"
#import <objc/runtime.h>


typedef void(*customFunc)(void);


@implementation NSJSONSerialization (Swizzling)

#warning test

//void emptyFunction() {
//    emptyFunction2();
//}
//void emptyFunction2() {
//    
//}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        emptyFunction();
        
        Class class = [self class];
        
        Method originJSONObjectWithDataMethod = class_getClassMethod(class, @selector(JSONObjectWithData:options:error:));
        Method customJSONObjectWithDataMethod = class_getClassMethod(class, @selector(customJSONObjectWithData:options:error:));
        method_exchangeImplementations(originJSONObjectWithDataMethod, customJSONObjectWithDataMethod);
        
        Class privateClass = objc_getClass("_NSJSONReader");
        NSLog(@"private class %@ present", privateClass);
        
//        void (*callback)(void) = NULL;
//        callback = &newJSONValue;
//        callback();
        
//        SEL selector = sel_getName(<#SEL sel#>)
//        Method test = class_getClassMethod(class, @selector(JSONObjectWithData:options:error:));

//        Method method = class_getInstanceMethod(privateClass, );
        
    });
}

#pragma mark -
#pragma mark swizzling [NSJSONSerialization JSONObjectWithData: options: error:];

+ (nullable id)customJSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error {
    
    NSLog(@"------------------------------------------------------------------------------------------");
    NSLog(@"customJSONObjectWithData called");
    NSLog(@"%@",[NSThread callStackSymbols]);

    return [self customJSONObjectWithData:data options:opt error:error];
}


@end
