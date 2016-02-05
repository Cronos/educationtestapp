//
//  NSObject+EDARuntime.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef OBJC_ENUM(uintptr_t, EDAPropertyPolicy) {
    // Specifies a weak property.
    EDAPropertyAssign = OBJC_ASSOCIATION_ASSIGN,
    
    // Specifies a nonatomic strong property.
    EDAPropertyNonatomicStrong = OBJC_ASSOCIATION_RETAIN_NONATOMIC,
    
    // Specifies a nonatomic copy property.
    EDAPropertyNonatomicCopy = OBJC_ASSOCIATION_COPY_NONATOMIC,
    
    // Specifies an atomic strong property.
    EDAPropertyAtomicStrong = OBJC_ASSOCIATION_RETAIN,
    
    // Specifies an atomic copy property.
    EDAPropertyAtomicCopy = OBJC_ASSOCIATION_COPY
};
    
typedef id(^EDABlockWithIMP)(IMP implementation);
    
@interface NSObject (EDARuntime)

+ (void)setBlock:(EDABlockWithIMP)block forSelector:(SEL)selector;

+ (Class)metaclass;
+ (NSSet *)subclasses;

+ (Class)subclassWithName:(NSString *)name;
+ (void)unregister;

- (void)setValue:(id)value forPropertyKey:(const NSString *)key associationPolicy:(EDAPropertyPolicy)policy;
- (id)valueForPropertyKey:(const NSString *)key;

@end
