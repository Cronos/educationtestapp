//
//  EDAObservableObjectSpec.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 03.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(EDAObservableObjectSpec)

describe(@"EDAObservableObjectSpec", ^{
    context(@"after being deallocated", ^{
        it(@"should remove all observers", ^{
            //
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
