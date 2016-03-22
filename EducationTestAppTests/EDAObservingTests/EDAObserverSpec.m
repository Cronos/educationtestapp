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
    const NSUInteger state = 99;
    __block EDAObserver *observer = nil;
    __block EDAObservableObject *observableObject = nil;
    
    beforeEach(^{
        observableObject = [EDAObservableObject new];
        observer = [observableObject observer];
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
            [[observableObject.observers should] contain:observer];
        });
        
        it(@"should be valid", ^{
            [[theValue(observer.isValid) should] beYes];
        });
    });
    
    context(@"after deallocated", ^{
        beforeEach(^{
            observer = nil;
        });
        
        it(@"shoulde be removed from observers of observable object", ^{
            [[observableObject.observers should] haveCountOf:0];
        });
    });
    
    context(@"when setting block for state", ^{
        id block = ^(id observableObject, id info){
            [NSObject description];
        };
        
        beforeEach(^{
            [observer setBlock:block forState:state];
        });
        
        it(@"should return that block for that state", ^{
            [[[observer blockForState:state] should] equal:block];
        });
        
        context(@"when setting block == nil for state", ^{
            beforeEach(^{
                [observer setBlock:nil forState:state];
            });
            
            it(@"should return nil for that state", ^{
                [[[observer blockForState:state] should] beNil];
            });
        });
    });
    
    context(@"when setting block for state using indexed subscript", ^{
        id block = ^(id observableObject, id info){
            [NSObject description];
        };
        
        beforeEach(^{
            observer[state] = block;
        });
        
        it(@"should return that block for that state", ^{
            [[observer[state] should] equal:block];
        });
        
        context(@"when setting block == nil for state", ^{
            beforeEach(^{
                observer[state] = nil;
            });
            
            it(@"should return nil for that state", ^{
                [[observer[state] should] beNil];
            });
        });
    });

    context(@"when executing block for state", ^{
        __block id sender = nil;
        __block id receivedNotification = nil;
        
        id object = [NSObject new];
        
        beforeEach(^{
            id block = ^(id observableObject, id info) {
                sender = observableObject;
                receivedNotification = info;
            };
            [observer setBlock:block forState:state];
            [observer performBlockForState:state object:object];
        });
        
        afterEach(^{
            sender = nil;
            receivedNotification = nil;
        });
        
        it(@"should notify observer by sending observable object", ^{
            [[sender should] equal:observableObject];
        });
        
        it(@"should notify observer by sending object as parameter", ^{
            [[receivedNotification should] equal:object];
        });
    });
});

SPEC_END
