//
//  EDAObserver.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDAObservableObject;

typedef NSUInteger EDAObjectState;

typedef void(^EDAObserverCallback)(id observableObject, id info);

@interface EDAObserver : NSObject
@property (nonatomic, readonly, weak) EDAObservableObject *observableObject;
@property (nonatomic, assign, getter=isValid)  BOOL valid;

+ (instancetype)observerWithObservableObject:(EDAObservableObject *)object;

- (instancetype)initWithObservableObject:(EDAObservableObject *)object;

- (void)setBlock:(EDAObserverCallback)block forState:(EDAObjectState)state;
- (EDAObserverCallback)blockForState:(EDAObjectState)state;

- (id)objectAtIndexedSubscript:(NSUInteger)state;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)state;

- (void)performBlockForState:(EDAObjectState)state object:(id)object;

@end
