//
//  EDAObservableObject.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAObservableObject.h"

@interface EDAObservableObject ()
@property (nonatomic, weak)     id<NSObject>    target;
@property (nonatomic, strong)   NSHashTable     *mutableObservers;

@end

@implementation EDAObservableObject

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
    self.target = target;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (id)target {
    return _target ? _target : self;
}

- (NSSet *)observers {
    return [self.mutableObservers setRepresentation];
}

#pragma mark -
#pragma mark Public


- (void)setState:(EDAObjectState)state object:(id)object {
    
}

- (EDAObserver *)observerWithObject:(id)observer {
    return nil;
}

- (void)notifyObserversWithState:(NSUInteger)state {
    
}

- (void)notifyObserversWithState:(NSUInteger)state object:(id)object {
    
}

@end
