//
//  EDAObservableObject.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDAObserver.h"
//EDAObservableObjectSpec
//    after being deallocated it should remove all observers
//    when observer starts observing
//        it should add observer to observers
//        it should return observer object
//        multiple times it should return multiple unique observer object
//    when observer stops observing it should remove observer from observers
//    when object changes state
//        and sends changes in notification it should notify observers sending self and changes as parameters
//        and doesn't send changes in notification it should notify observers sending self and changes == nil as parameters
//        when observer pauses observation
//            it shouldn't send notification to this observer
//            it shouldn't send notification to other observers
//            when observer resumes observation it should send notification to all unpaused observers

@interface EDAObservableObject : NSObject
@property (nonatomic, readonly) NSSet           *observers;
@property (nonatomic, readonly) id<NSObject>    target;
@property (nonatomic, assign)   EDAObjectState  state;

+ (instancetype)objectWithTarget:(id<NSObject>)target;

- (instancetype)initWithTarget:(id<NSObject>)target NS_DESIGNATED_INITIALIZER;

- (void)setState:(EDAObjectState)state object:(id)object;

- (EDAObserver *)observerWithObject:(id)observer;

- (void)notifyObserversWithState:(NSUInteger)state;
- (void)notifyObserversWithState:(NSUInteger)state object:(id)object;

@end
