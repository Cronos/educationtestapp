//
//  NSObject+SubclassesTests.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 19.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+Subclasses.h"

@interface NSObject_SubclassesTests : XCTestCase

@end

@implementation NSObject_SubclassesTests

- (void)testNSObjectMetaclass {
    Class class = [NSMutableDictionary class];
    Class metaclass = [[NSMutableDictionary metaclass] metaclass];
    NSLog(@"Metaclass for %@ is %@", NSStringFromClass(class), NSStringFromClass(metaclass));
}

- (void)testNSObjectSubclasses {
    NSArray *array = [NSObject subclasses];
    NSLog(@"subclasses count for NSObject is %ld", array.count);
    
    array = [NSMutableArray subclasses];
    NSLog(@"subclasses count for NSMutableArray is %ld", array.count);
    
    array = [UIScrollView subclasses];
    NSLog(@"subclasses count for NSMutableArray is %ld", array.count);
}

@end
