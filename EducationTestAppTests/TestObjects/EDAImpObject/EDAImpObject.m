//
//  EDAImpObject.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAImpObject.h"

@implementation EDAImpObject

static IMP __implementation = nil;

- (void)setImplementation:(IMP)implementation {
    @synchronized(self) {
        if (__implementation != implementation) {
            __implementation = implementation;
        }
    }
}

- (IMP)implementation {
    @synchronized(self) {
        return __implementation;
    }
}

@end
