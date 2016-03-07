//
//  EDAObserver.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAObserver.h"
#import "EDALocking.h"
#import "EDAObservableObject.h"
#import "EDABlockMacros.h"

@interface EDAObserver ()
@property (nonatomic, weak)     EDAObservableObject *observableObject;
@property (nonatomic, strong)   NSMapTable          *executableBlocks;
@property (nonatomic, strong)   id<EDALocking>      lock;

@end

@implementation EDAObserver

@dynamic valid;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)observerWithObservableObject:(EDAObservableObject *)object {
    return [[self alloc] initWithObservableObject:object];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithObservableObject:(EDAObservableObject *)object {
    self = [super init];
    self.lock = [NSRecursiveLock new];
    self.executableBlocks = [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn valueOptions:NSMapTableCopyIn];
    self.observableObject = object;
   
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isValid {
    return nil != self.observableObject;
}

#pragma mark -
#pragma mark Indexed Subscript

- (id)objectAtIndexedSubscript:(NSUInteger)state {
    return [self blockForState:state];
}

- (void)setObject:(id)block atIndexedSubscript:(NSUInteger)state {
    [self setBlock:block forState:state];
}

#pragma mark -
#pragma mark Public

- (void)setBlock:(EDAObserverCallback)block forState:(EDAObjectState)state {
    NSMapTable *executableBlocks = self.executableBlocks;
    id stateObject = @(state);
    
    [self.lock performBlock:^{
        if (block) {
            [executableBlocks setObject:block forKey:stateObject];
        } else {
            [executableBlocks removeObjectForKey:stateObject];
        }
    }];
}

- (EDAObserverCallback)blockForState:(EDAObjectState)state {
    NSMapTable *executableBlocks = self.executableBlocks;
    
    __block id result = nil;
    [self.lock performBlock:^{
        result = [executableBlocks objectForKey:@(state)];
    }];
    
    return result;
}

- (void)performBlockForState:(EDAObjectState)state object:(id)object {
    EDAObserverCallback block = self[state];
    EDABlockCall(block, self.observableObject.target, object);
}

@end
