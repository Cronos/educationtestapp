//
//  EDAObservableObjectSpec.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "Kiwi.h"
#import "EDAObservableObject.h"

SPEC_BEGIN(EDAObservableObjectSpec)

describe(@"EDAObservableObjectSpec", ^{
    __block EDAObservableObject *observableObject = nil;
    beforeEach(^{
        observableObject = [EDAObservableObject objectWithTarget:nil];
    });
    
    afterEach(^{
        observableObject = nil;
    });
    
    context(@"when initialized without target", ^{
        it(@"should have target == self", ^{
            [[observableObject should] equal:observableObject.target];
        });
    });

    context(@"when initialized with target", ^{
        __block id target = nil;
        
        beforeEach(^{
            observableObject = nil;
            target = [NSObject new];
            observableObject = [EDAObservableObject objectWithTarget:target];
        });
 
        it(@"should have target", ^{
            [[target should] equal:observableObject.target];

        });
    });

    context(@"after being deallocated", ^{
        beforeEach(^{
            observableObject = nil;
        });
        
        it(@"should remove all observers", ^{
            [[observableObject.observers should] haveCountOf:0];
        });
        
    });
    
    context(@"when observer starts observing", ^{
        it(@"should add observer to observers", ^{
            //
        });
        
        it(@"should return observer object", ^{
            //
        });
        
        context(@"multiple times", ^{
            it(@"should return multiple unique observer object", ^{
                //
            });
        });
    });
    
    context(@"when observer stops observing", ^{
        it(@"should remove observer from observers", ^{
            //
        });
    });
    
    context(@"when object changes state", ^{
        context(@"and sends changes in notification", ^{
            it(@"should notify observers sending self and changes as parameters", ^{
                //
            });
        });
        
        context(@"and doesn't send changes in notification", ^{
            it(@"should notify observers sending self and changes == nil as parameters", ^{
                //
            });
        });
        
        context(@"when observer pauses observation", ^{
            it(@"shouldn't send notification to this observer", ^{
                //
            });
            
            it(@"shouldn't send notification to other observers", ^{
                //
            });
            
            context(@"when observer resumes observation", ^{
                it(@"should send notification to all unpaused observers", ^{
                    //
                });
            });
        });
    });
});


SPEC_END
