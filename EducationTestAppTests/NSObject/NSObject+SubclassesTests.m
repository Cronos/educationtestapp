//
//  NSObject+SubclassesTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+EDARuntime.h"

@interface NSObject_SubclassesTests : XCTestCase

@end

@implementation NSObject_SubclassesTests

- (void)testNSObjectMetaclass {
    Class class = [NSMutableDictionary class];
    Class metaclass = [[NSMutableDictionary metaclass] metaclass];
    NSLog(@"Metaclass for %@ is %@", NSStringFromClass(class), NSStringFromClass(metaclass));
}

- (void)testNSObjectSubclasses {
    NSSet *set = [NSObject subclasses];
    NSLog(@"subclasses count for NSObject is %ld", set.count);
    
    set = [NSArray subclasses];
    NSLog(@"subclasses count for NSArray is %ld", set.count);
    
    set = [UIScrollView subclasses];
    NSLog(@"subclasses count for NSMutableArray is %ld", set.count);
}

@end
