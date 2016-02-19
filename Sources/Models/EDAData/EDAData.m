//
//  EDAData.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAData.h"
#import "EDAResponse.h"
#import "EDARecordInfoRequest.h"
#import "NSURLSession+EDAExtensions.h"
#import "EDADispatch.h"

@interface EDAData ()
@property (nonatomic, strong) NSURLSessionDataTask  *loadTask;
@property (nonatomic, assign) BOOL                  isLoaded;

@end

@implementation EDAData

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    EDAData *data = [EDAData dataWithIndex:0];
    [data setPropertyValueWithDictionary:dictionary];
    return data;
}

+ (instancetype)dataWithIndex:(NSUInteger)index {
    return [[self alloc] initWithIndex:index];
}

+ (NSArray<EDAData*> *)arrayFromArray:(NSArray *)array {
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        EDAData *data = [EDAData instanceWithDictionary:dictionary];
        if (data) {
            [newArray addObject:data];
        }
    }
    
    return [newArray copy];
}

- (instancetype)init {
    return [self initWithIndex:0];
}

- (instancetype)initWithIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.loadTask = nil;
        self.isLoaded = NO;
        self.index = index;
        [self setPropertyValueWithDictionary:@{}];
        self.Id = -1;
    }
    
    return self;
}

- (void)setPropertyValueWithDictionary:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        self.Id = [[dictionary objectForKey:@"id"] integerValue];
        self.content =[dictionary objectForKey:@"content"];
        self.message = [dictionary objectForKey:@"message"];
        self.image = [dictionary objectForKey:@"image"];
        self.images = [dictionary objectForKey:@"images"];
    }
}

- (void)setPropertyValueWithData:(EDAData *)data {
    self.Id = data.Id;
    self.content =  data.content;
    self.message = data.message;
    self.image = data.image;
    self.images = data.images;
    
    EDADispatchAsyncInMainQueue(^{
        self.updateDataBlock ? self.updateDataBlock(self) : nil;
    });
}

- (void)fetchData {
    if (self.Id<0) {
        return;
    }
    
    if (self.isLoaded) {
        EDADispatchAsyncInMainQueue(^{
            self.updateDataBlock ? self.updateDataBlock(self) : nil;
        });
        return;
    }
    
    if (!self.loadTask) {
        typeof(self) __weak weakSelf = self;
        [self.loadTask = [NSURLSession dataTaskWithRequest:[EDARecordInfoRequest requestWithId:self.Id] completion:^(NSData *data, NSError *error) {
            if (data ){
                typeof(weakSelf) __strong strongSelf = weakSelf;
                [strongSelf parseLoadedData:data];
//            } else {
//                 NSLog(@"Index %lu fetchData error: %@", (unsigned long)self.index, error.localizedDescription);
            }
        }] resume];
    }
}

- (void)cancelFetchData {
    [self.loadTask cancel];
    self.loadTask = nil;
}

- (void)parseLoadedData:(NSData *)data {
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
        self.isLoaded = YES;
        EDAResponse *response = [EDAResponse instanceWithDictionary:dictionary[@"response"]];
        EDAData *data = response.data.firstObject;
        [self setPropertyValueWithData:data];
    } else {
        self.content = @"Error data loading...";
    }
}

@end
