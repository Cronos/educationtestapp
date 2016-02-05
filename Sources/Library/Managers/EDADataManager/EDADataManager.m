//
//  EDADataManager.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 05.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDADataManager.h"

@interface EDADataManager() {
    NSMutableArray *data;
}

@end

@implementation EDADataManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        data = [NSMutableArray array];
    }
    
    return self;
}

+ (instancetype)manager {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

- (NSUInteger)count {
    return data.count;
}

@end
