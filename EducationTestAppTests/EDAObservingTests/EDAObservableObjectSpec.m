//
//  EDAObservableObjectSpec.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "Kiwi.h"

#import "EDAObservableObject.h"
#import "EDAObserver.h"

SPEC_BEGIN(EDAObservableObjectSpec)

describe(@"EDAObservableObjectSpec", ^{
    NSUInteger state = 99;
    
    __block EDAObservableObject *observableObject = nil;
    __block EDAObserver *observer = nil;
    
    beforeEach(^{
        observableObject = [EDAObservableObject objectWithTarget:nil];
        observer = [observableObject observer];
    });
    
    afterEach(^{
        observableObject = nil;
        observer = nil;
    });
    
    context(@"when initialized without target", ^{
        it(@"should have target == self", ^{
            [[observableObject should] equal:observableObject.target];
        });
    });

    context(@"when initialized with target", ^{
        __block id target = nil;
        
        beforeEach(^{
            target = [NSObject new];
            observableObject = [EDAObservableObject objectWithTarget:target];
        });
 
        it(@"should have target", ^{
            [[target should] equal:observableObject.target];
        });
    });

    context(@"after deallocate observable object", ^{
        it(@"observer should be not valid", ^{
            observableObject = nil;
            [[theValue(observer.isValid) should] beNo];
        });
    });
    
    context(@"after deallocate observer", ^{
        beforeEach(^{
            observer = nil;
        });
        
        it(@"should be removed from observers of observable object", ^{
            [[observableObject.observers should] haveCountOf:0];
        });
    });
    
    context(@"after fetching observer", ^{
        describe(@"EDAObserver", ^{
            it(@"should contain observable object in its obsevable object property", ^{
                [[observer.observableObject should] equal:observableObject];
            });
        });
    });

    context(@"when observer starts observing", ^{
        it(@"should add observer to observers", ^{
            [[observableObject.observers should] contain:observer];
        });
        
        it(@"should return object by kind of EDAObserver", ^{
            [[observer should] beKindOfClass:[EDAObserver class]];
        });
        
        context(@"multiple times", ^{
            it(@"should return multiple unique observer object", ^{
                id anotherObserver = [observableObject observer];
                [[anotherObserver shouldNot] equal:observer];
            });
        });
    });
    
    context(@"when object changes state", ^{
        __block id sender = nil;
        __block id receivedNotification = nil;
        
        beforeEach(^{
            id callback = ^(id observableObject, id info){
                sender = observableObject;
                receivedNotification = info;
            };
            
            [observer setBlock:callback forState:state];
        });
        
        afterEach(^{
            sender = nil;
            receivedNotification = nil;
        });
        
        context(@"and sends changes in notification", ^{
            __block id notification = nil;
            
            beforeEach(^{
                notification = [NSObject new];
                [observableObject setState:state object:notification];
            });
            
            afterEach(^{
                notification = nil;
            });
            
            it(@"should notify observers by sending self", ^{
                [[sender should] equal:observableObject];
            });
            
            it(@"should notify observers by sending changes", ^{
                [[receivedNotification should] equal:notification];
            });
        });
        
        context(@"and doesn't send changes in notification", ^{
            beforeEach(^{
                [observableObject notifyObserversWithState:state];
            });
            
            it(@"should notify observers sending self and changes == nil as parameters", ^{
                [[sender should] equal:observableObject];
                [[receivedNotification should] beNil];
            });
        });
    });
});


SPEC_END
