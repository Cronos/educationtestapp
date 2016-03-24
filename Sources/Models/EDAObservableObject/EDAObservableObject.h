//
//  EDAObservableObject.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDAObserver.h"

@interface EDAObservableObject : NSObject
@property (nonatomic, readonly)         NSSet           *observers;
@property (nonatomic, weak, readonly)   id<NSObject>    target;
@property (atomic, assign)              EDAObjectState  state;

+ (instancetype)objectWithTarget:(id<NSObject>)target;

- (instancetype)initWithTarget:(id<NSObject>)target NS_DESIGNATED_INITIALIZER;

- (void)setState:(EDAObjectState)state object:(id)object;

- (EDAObserver *)observer;
- (void)removeObserver:(EDAObserver *)observer;

- (void)notifyObserversWithState:(NSUInteger)state;
- (void)notifyObserversWithState:(NSUInteger)state object:(id)object;

@end
