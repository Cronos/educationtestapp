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

typedef NS_ENUM(NSInteger, EDAQueuePriority){
    EDAQueuePriorityDefault = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    EDAQueuePriorityHigh = DISPATCH_QUEUE_PRIORITY_HIGH,
    EDAQueuePriorityLow = DISPATCH_QUEUE_PRIORITY_LOW,
    EDAQueuePriorityBackground = DISPATCH_QUEUE_PRIORITY_BACKGROUND
};

static inline
void EDADispatchAsyncBlockInQueue(EDADispatchBlock block, dispatch_queue_t queue) {
    dispatch_async(queue, ^{
        block ? block() : nil;
    });
}

static inline
void EDADispatchAsyncInMainQueue(EDADispatchBlock block) {
    EDADispatchAsyncBlockInQueue(block, dispatch_get_main_queue());
}

static inline
void EDADispatchAsyncWithDefaultPriority(EDADispatchBlock block) {
    EDADispatchAsyncBlockInQueue(block, dispatch_get_global_queue(EDAQueuePriorityDefault, 0));
}

static inline
void EDADispatchAsyncWithHighPriority(EDADispatchBlock block) {
    EDADispatchAsyncBlockInQueue(block, dispatch_get_global_queue(EDAQueuePriorityHigh, 0));
}

static inline
void EDADispatchAsyncWithLowPriority(EDADispatchBlock block) {
    EDADispatchAsyncBlockInQueue(block, dispatch_get_global_queue(EDAQueuePriorityLow, 0));
}

static inline
void EDADispatchAsyncWithBackgroundPriority(EDADispatchBlock block) {
    EDADispatchAsyncBlockInQueue(block, dispatch_get_global_queue(EDAQueuePriorityBackground, 0));
}

#endif /* EDADispatch_h */
