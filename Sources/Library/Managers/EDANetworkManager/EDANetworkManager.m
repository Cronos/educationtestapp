//
//  EDANetworkManager.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 11.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDANetworkManager.h"
#import "EDAResponse.h"
#import "EDADefines.h"
#import "EDAAPIKeys.h"

//static NSString *const EDARequestPath = @"http://localhost";
static NSString *const EDAAPIHost = @"http://newdev.anahoret.com:8082";


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
                    EDAResponse *response = [EDAResponse instanceWithDictionary:[EDANetworkManager resultForData:parameters[EDAKeyID]]];
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
        NSString *dataId = parameters[EDAKeyID];
        NSString *dataIndex = parameters[EDAKeyIndex];
        NSString *dataCount = parameters[EDAKeyCount];
        
        if (dataId) {
            requestParameters = [NSString stringWithFormat:@"/%@", dataId];
        }
    }
}

+ (void)getDataWithId:(NSNumber *)Id completionHandler:(EDAResponse *)completion{
    [EDANetworkManager sendRequest:EDANetworkRequestOnceData withParameters:@{EDAKeyID : Id} completionHandler:completion];
}

+ (void)getDataListFrom:(NSInteger)index count:(NSInteger)count completionHandler:(EDAResponse *)completion{
    [EDANetworkManager sendRequest:EDANetworkRequestDataList withParameters:@{EDAKeyIndex : @(index), EDAKeyCount : @(count)} completionHandler:completion];
}

#pragma mark - Test data

+ (NSDictionary *)resultForData:(NSNumber *)Id {
    return @{
             EDAKeyResponse : @{ // dictionary to contain all the response data
                     EDAKeyMeta : @{ // metadata dictionary
                             EDAKeyRequest : @{ // description of request
                                     EDAKeySuccess  : @true, // if the request was succesful
                                     EDAKeyInfo     : @"Fetch data successfully" // text accompanying the response
                                     },
                             EDAKeyLayout : @{ // pagination dictionary
                                     EDAKeyIndex        : Id, // index of the requested data, which is the starting idnex of the data to be returned
                                     EDAKeyCount        : @1, // amount of data items requested from the current index
                                     EDAKeyTotalCount   : @1 // total amount of data present in the database for the current request
                                     },
                             },
                     EDAKeyData : @[
                             @{
                                 EDAKeyID      : Id,
                                 EDAKeyContent : [EDANetworkManager randomStringWithLength:NSMakeRange(10, 200)], // length of each string should be random between 10 and 200 symbols
                                 EDAKeyMessage : [EDANetworkManager randomStringWithLength:NSMakeRange(100, 2000)], // // length should be random between 100 and 2000 symbols
                                 EDAKeyImage   : [EDANetworkManager imagePathForId:Id], // image URL pointing to real image (should differ for different ids)
                                 EDAKeyImages  : @[@"http://www.de/1.jpg", @"http://www.de/2.jpg"] // image URLs pointing to additional real image (can be duplicated for different ids)
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
    
    return [EDAAPIHost stringByAppendingPathComponent:imageName];
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
