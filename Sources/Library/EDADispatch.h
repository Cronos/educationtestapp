//
//  EDADispatch.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#ifndef EDADispatch_h
#define EDADispatch_h

typedef void(^EDADispatchBlock)();

static inline void EDADispatchAsyncInMainQueue(EDADispatchBlock block) {
    dispatch_async(dispatch_get_main_queue(), ^{
        block ? block() : nil;
    });
}

#endif /* EDADispatch_h */
