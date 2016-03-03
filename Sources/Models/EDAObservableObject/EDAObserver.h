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
typedef void(^EDAObserverCallBlock)(id observableObject, id info);

@interface EDAObserver : NSObject
@property (nonatomic, readonly) EDAObservableObject *observableObject;
@property (nonatomic, assign, getter=isPaused) BOOL paused;
@property (nonatomic, assign, getter=isValid)  BOOL valid;

- (void)setBlock:(EDAObserverCallBlock)block forState:(EDAObjectState)state;
- (EDAObserverCallBlock)blockForState:(EDAObjectState)state;

- (id)objectAtIndexedSubscript:(NSUInteger)state;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)state;

@end
