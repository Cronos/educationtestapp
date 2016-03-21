//
//  EDAObservableObject.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAObservableObject.h"
#import "EDALocking.h"

@interface EDAObservableObject ()
@property (nonatomic, weak)     id<NSObject>    target;
@property (nonatomic, strong)   NSHashTable     *mutableObservers;
@property (nonatomic, strong)   id<EDALocking>  lock;

@end

@implementation EDAObservableObject

@synthesize state = _state;

#pragma mark -
#pragma mark Class methods

+ (instancetype)objectWithTarget:(id<NSObject>)target {
    return [[self alloc] initWithTarget:target];
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)init {
    return [self initWithTarget:nil];
}

- (instancetype)initWithTarget:(id<NSObject>)target {
    self = [super init];
    self.mutableObservers = [NSHashTable weakObjectsHashTable];
    self.target = target ? target : self;
    self.lock = [NSRecursiveLock new];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observers {
    NSHashTable *mutableObservers = self.mutableObservers;
    __block NSSet *observers = nil;
    
    [self.lock performBlock:^{
        observers = [mutableObservers setRepresentation];
    }];
    
    return observers;
}

- (EDAObjectState)state {
    return _state;
}

- (void)setState:(EDAObjectState)state {
    [self setState:state object:nil];
}

- (void)setState:(EDAObjectState)state object:(id)object {
    [self.lock performBlock:^{
        if (_state != state) {
            _state = state;
            [self notifyObserversWithState:state object:object];
        }
    }];
}

#pragma mark -
#pragma mark Public

- (EDAObserver *)observer {
    EDAObserver *observer = [EDAObserver observerWithObservableObject:self];
    NSHashTable *mutableObservers = self.mutableObservers;
    [self.lock performBlock:^{
        [mutableObservers addObject:observer];
    }];

    return observer;
}

- (void)notifyObserversWithState:(EDAObjectState)state {
    [self notifyObserversWithState:state object:nil];
}

- (void)notifyObserversWithState:(EDAObjectState)state object:(id)object {
    NSHashTable *mutableObservers = self.mutableObservers;
    [self.lock performBlock:^{
        for (EDAObserver *observer in mutableObservers) {
            [observer performBlockForState:state object:object];
        }
    }];
}

@end
