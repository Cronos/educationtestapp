//
//  EDANetworkManager.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDANetworkManager.h"
#import "EDAResponse.h"

static NSString *const EDARequestPath = @"http://localhost";

static NSString *const EDANetworkParameterId = @"id";
static NSString *const EDANetworkParameterIndex = @"index";
static NSString *const EDANetworkParameterCount = @"count";

typedef NS_ENUM(NSInteger, EDANetworkRequestType) {
    EDANetworkRequestOnceData,
    EDANetworkRequestDataList
};

@implementation EDANetworkManager

+ (void)sendRequest:(EDANetworkRequestType)requestType withParameters:(NSDictionary *)parameters completionHandler:(EDAResponse *)completion {
    switch (requestType) {
        case EDANetworkRequestOnceData:
        {
            if (completion) {
                float delay = 0.5 + ((float)arc4random()/RAND_MAX)*2.0;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    EDAResponse *response = [EDAResponse responseFromDictionary:[EDANetworkManager resultForData:parameters[EDANetworkParameterId]]];
                    // call completion(response);
                });
            }
        }
            break;
            
        default:
            break;
    }
    
    NSString *requestParameters;
    if (parameters) {
        NSString *dataId = parameters[EDANetworkParameterId];
        NSString *dataIndex = parameters[EDANetworkParameterIndex];
        NSString *dataCount = parameters[EDANetworkParameterCount];
        
        if (dataId) {
            requestParameters = [NSString stringWithFormat:@"/%@", dataId];
        }
    }
}

+ (void)getDataWithId:(NSNumber *)Id completionHandler:(EDAResponse *)completion{
    [EDANetworkManager sendRequest:EDANetworkRequestOnceData withParameters:@{EDANetworkParameterId : Id} completionHandler:completion];
}

+ (void)getDataListFrom:(NSInteger)index count:(NSInteger)count completionHandler:(EDAResponse *)completion{
    [EDANetworkManager sendRequest:EDANetworkRequestDataList withParameters:@{EDANetworkParameterIndex : @(index), EDANetworkParameterCount : @(count)} completionHandler:completion];
}

#pragma mark - Test data

+ (NSDictionary *)resultForData:(NSNumber *)Id {
    return @{
             @"response" : @{ // dictionary to contain all the response data
                     @"meta" : @{ // metadata dictionary
                             @"request" : @{ // description of request
                                     @"sucess" : @true, // if the request was succesful
                                     @"info" : @"Fetch data successfully" // text accompanying the response
                                     },
                             @"layout" : @{ // pagination dictionary
                                     @"index" : Id, // index of the requested data, which is the starting idnex of the data to be returned
                                     @"count" : @1, // amount of data items requested from the current index
                                     @"totalCount" : @1 // total amount of data present in the database for the current request
                                     },
                             },
                     @"data" : @[
                             @{
                                 @"id"      : Id,
                                 @"content" : [EDANetworkManager randomStringWithLength:NSMakeRange(10, 200)], // length of each string should be random between 10 and 200 symbols
                                 @"message" : [EDANetworkManager randomStringWithLength:NSMakeRange(100, 2000)], // // length should be random between 100 and 2000 symbols
                                 @"image"   : [EDANetworkManager imagePathForId:Id], // image URL pointing to real image (should differ for different ids)
                                 @"images"  : @[@"http://www.de/1.jpg", @"http://www.de/2.jpg"] // image URLs pointing to additional real image (can be duplicated for different ids)
                                 },
                             ]
                     }
             };
}

+ (NSDictionary *)resultForDataListFrom:(NSNumber *)index count:(NSNumber *)count {
    return @{};
}

+ (NSString *)imagePathForId:(NSNumber *)Id {
    NSString *imageName = [NSString stringWithFormat:@"01%@.jpg", [EDANetworkManager filledStringForNumber:Id]];
    
    return [EDARequestPath stringByAppendingPathComponent:imageName];
}

+ (NSString *)randomStringWithLength:(NSRange)range {
    NSUInteger length = range.location + arc4random_uniform((u_int32_t)(range.length - range.location));
    NSString *chars = @"ABCDEFG HIJKLMNOPQ- RSTUVWXYZ abcdefghij klmnopqr stuvwxyz -";
    
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSInteger i = 0; i<length; i++) {
        NSInteger index = arc4random() % length;
        [string appendFormat:@"%C", [chars characterAtIndex:index]];
    }
    
    return [string copy];
}

+ (NSString *)filledStringForNumber:(NSNumber *)number {
    NSMutableString *string = [NSMutableString stringWithString:number.stringValue];
    while (string.length<3) {
        [string insertString:@"0" atIndex:0];
    }
    
    return [string copy];
}

@end
