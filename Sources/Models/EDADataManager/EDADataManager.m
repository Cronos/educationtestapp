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
#import "EDADispatch.h"

@interface EDADataManager ()
@property (nonatomic, assign) NSInteger totalRecordsCount;
@property (nonatomic, strong) NSMutableSet <EDAData *> *data;
@property (nonatomic, assign) NSInteger count;

- (void)updateDataWithObjects:(NSArray *)objects fromIndex:(NSUInteger)index;

@end

@implementation EDADataManager

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
        self.count = 0;
        self.totalRecordsCount = -1;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (EDAData *)dataWithIndex:(NSUInteger)index {
    @synchronized(self.data) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(EDAData *evaluatedObject, NSDictionary<NSString *,id> *bindings) {
            return evaluatedObject.index == index;
        }];
        
        return [self.data filteredSetUsingPredicate:predicate].allObjects.firstObject;
    }
}

#pragma mark -
#pragma mark IndexedSubscript

- (EDAData *)objectAtIndexedSubscript:(NSUInteger)index {
    @synchronized(self.data) {
        EDAData *data = [self dataWithIndex:index];
        if (!data) {
            data = [EDAData dataWithIndex:index];
            [self.data addObject:data];
        }

        return data;
    }
}

- (void)setObject:(EDAData *)object atIndexedSubscript:(NSUInteger)index {
    @synchronized(self.data) {
        EDAData *data = [self dataWithIndex:index];
        if (data) {
            [self.data removeObject:data];
        }
        
        [self.data addObject:object];
    }
}

- (void)fetchDataCount:(NSUInteger)recordsCount completion:(void (^)(NSUInteger index, NSUInteger count))completion error:(EDAErrorBlock)error {
    NSInteger index = self.count;
    NSUInteger count = self.totalRecordsCount < 0 ? recordsCount : MIN(recordsCount, self.totalRecordsCount - index);
    self.count += count;
    
    EDADispatchAsyncInMainQueue(^{
        completion ? completion(index, count) : nil;
    });
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
    
        EDARecordsListRequest *request = [EDARecordsListRequest requestFromIndex:index count:count];
        typeof(self) __weak weakSelf = self;
        NSURLSessionDataTask *task = [NSURLSession dataTaskWithRequest:request completion:^(NSData *data, NSError *requestError) {
            if (requestError) {
                EDADispatchAsyncInMainQueue(^{
                    error ? error(requestError) : nil;
                });
            } else {
                NSError *error = nil;
                EDAResponse *response = nil;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                typeof(weakSelf) __strong strongSelf = weakSelf;
                if (!error) {
                    response = [EDAResponse instanceWithDictionary:dictionary[@"response"]];
                    strongSelf.totalRecordsCount = response.meta.layout.totalCount;
                    [strongSelf updateDataWithObjects:response.data fromIndex:response.meta.layout.index];
                }
            }
        }];
        
        [task startWithPriority:0.5];
    });
}

#pragma mark -
#pragma mark Private

- (void)updateDataWithObjects:(NSArray *)objects fromIndex:(NSUInteger)index {
    [objects enumerateObjectsUsingBlock:^(EDAData *data, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger objIdx = index + idx;
        self[objIdx].Id = data.Id;
        [self[objIdx] fetchData];
    }];
}

@end
