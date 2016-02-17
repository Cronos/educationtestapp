//
//  EDADataManager.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDADataManager.h"
#import "EDARecordsListRequest.h"
#import "NSURLSession+EDAExtensions.h"
#import "NSURLSessionTask+EDAExtensions.h"
#import "EDAData.h"
#import "EDAResponse.h"
#import "EDAResponseMetadata.h"
#import "EDAResponseLayout.h"
#import "NSArray+EDAExtensions.h"
#import "NSError+EDAExtensions.h"

@interface EDADataManager ()
@property (nonatomic, assign) NSInteger totalRecordsCount;
@property (nonatomic, strong) NSMutableSet <EDAData *> *data;
@property (nonatomic, strong) NSURLSessionDataTask *fetchDataTask;

- (void)addMockDataFromIndex:(NSUInteger)index count:(NSUInteger)count;
- (void)updateDataWithObjects:(NSArray *)objects fromIndex:(NSUInteger)index;

@end

@implementation EDADataManager

@dynamic count;

+ (instancetype)sharedManager {
    static id __sharedInstance = nil;
    static dispatch_once_t __onceToken;
    dispatch_once(&__onceToken, ^{
        __sharedInstance = [[self alloc] init];
    });
    
    return __sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.data = [NSMutableSet set];
        self.totalRecordsCount = 0;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (EDAData *)objectAtIndexedSubscript:(NSUInteger)idx {
    NSSet *set = [self.data objectsPassingTest:^BOOL(EDAData *obj, BOOL *stop) {
        return obj.index == idx;
    }];

    return set.allObjects.firstObject;
}

- (void)setObject:(EDAData *)object atIndexedSubscript:(NSUInteger)idx {
    NSSet *set = [self.data objectsPassingTest:^BOOL(EDAData *obj, BOOL *stop) {
        *stop = (obj.index == idx);
        return *stop;
    }];
    
    EDAData *data = set.allObjects.firstObject;
    [self.data removeObject:data];
    [self.data addObject:object];
}

- (void)fetchDataForRecordsFromIndex:(NSUInteger)index count:(NSUInteger)count completion:(EDAErrorBlock)completion {
    EDARecordsListRequest *request = [EDARecordsListRequest requestFromIndex:index count:count];
    [self addMockDataFromIndex:index count:count];
    NSURLSessionDataTask *task = [NSURLSession dataTaskWithRequest:request completion:^(NSData *data, NSURLResponse *taskResponse, NSError *taskError) {
        
        NSInteger statusCode = [[taskResponse valueForKey:@"statusCode"] integerValue];
        if (statusCode != 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion ? completion([NSError errorWithCode:statusCode description:[@(statusCode) stringValue]]) : nil;
            });
            
            return;
        }

        NSError *error = taskError;
        NSDictionary *dictionary = nil;
        EDAResponse *response = nil;
        if (!taskError) {
            dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        }
        
        if (!error) {
            response = [EDAResponse instanceWithDictionary:dictionary[@"response"]];
            self.totalRecordsCount = response.meta.layout.totalCount;
            [self updateDataWithObjects:response.data fromIndex:response.meta.layout.index];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion ? completion(error) : nil;
            });
        }
    }];
    
    //TODO: add task to array ?
    [task startWithPriority:0.5];
}

#pragma mark -
#pragma mark Forwarding methods

-(BOOL)respondsToSelector:(SEL)aSelector {
    return ([self.data respondsToSelector:aSelector] || [super respondsToSelector:aSelector]);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    if ([self.data respondsToSelector:selector]) {
        return [self.data methodSignatureForSelector:selector];
    } else {
        return [super methodSignatureForSelector:selector];
    }}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([self.data respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.data];
    } else {
        [super forwardInvocation:invocation];
    }
}

#pragma mark -
#pragma mark Private

- (void)addMockDataFromIndex:(NSUInteger)index count:(NSUInteger)count {
    for (NSUInteger idx = 0; idx < count; idx++) {
        EDAData *data = [EDAData new];
        data.index = index+idx;
        [self.data addObject:data];
    }
}

- (void)updateDataWithObjects:(NSArray *)objects fromIndex:(NSUInteger)index {
    [objects enumerateObjectsUsingBlock:^(EDAData *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger objIdx = index + idx;
        obj.index = objIdx;
        self[objIdx] = obj;
    }];
}

@end
