//
//  EDAObserverSpec.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 07.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "Kiwi.h"

#import "EDAObserver.h"
#import "EDAObservableObject.h"

SPEC_BEGIN(EDAObserverSpec)

describe(@"EDAObserver", ^{
    __block EDAObserver *observer = nil;
    __block EDAObservableObject *observableObject = nil;
    
    beforeEach(^{
        observableObject = [EDAObservableObject new];
        observer = [EDAObserver observerWithObservableObject:observableObject];
    });
    
    afterEach(^{
        observableObject = nil;
        observer = nil;
    });
    
    context(@"when created with observing object", ^{
        it(@"shouldn't be nil", ^{
            [[observer shouldNot] beNil];
        });
        
        it(@"should contain observable object", ^{
            [[observer.observableObject should] equal:observableObject];
        });
        
        it(@"should contained in observers of observable object", ^{
            NSLog(@"Observers: \n%@", observableObject.observers);
            [[observableObject.observers should] containsObject:observer];
        });
    });
});

SPEC_END
