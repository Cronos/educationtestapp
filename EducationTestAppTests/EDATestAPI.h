//
//  EDATestAPI.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 05.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#ifndef EDATestAPI_h
#define EDATestAPI_h

//
// request: /data?index=0&count=100
//
#import "EDADefines.h"
#import "EDAAPIKeys.h"

static inline
NSDictionary * EDATestDataSuccessfulResponse() {
    return @{
             EDAKeyResponse : @{ // dictionary to contain all the response data
                     EDAKeyMeta : @{ // metadata dictionary
                             EDAKeyRequest : @{ // description of request
                                     EDAKeySuccess  : @true, // if the request was succesful
                                     EDAKeyInfo     : @"Logged in successfully" // text accompanying the response
                                     },
                             EDAKeyLayout : @{ // pagination dictionary
                                     EDAKeyIndex        : @0, // index of the requested data, which is the starting idnex of the data to be returned
                                     EDAKeyCount        : @1, // amount of data items requested from the current index
                                     EDAKeyTotalCount   : @1 // total amount of data present in the database for the current request
                                     },
                             },
                     EDAKeyData : @[
                             @{
                                 EDAKeyID       : @1, // id
                                 EDAKeyContent  : @"MAMAPAPADEDABABA", // length should be random between 10 and 200 symbols
                                 EDAKeyImage    : @"http://www.1.de" // image URL pointing to real image (should differ for different ids)
                                 },
                             @{
                                 EDAKeyID       : @2, // id
                                 EDAKeyContent  : @"PAPAMAMABABADEDA", // length should be random between 10 and 200 symbols
                                 EDAKeyImage    : @"http://www.2.de" // image URL pointing to real image (should differ for different ids)
                                 }
                             ]
                     }
             };
}


static inline
NSDictionary * EDATestDataUnsuccessfulResponse() {
    return @{
             EDAKeyResponse : @{ // dictionary to contain all the response data
                     EDAKeyMeta : @{ // metadata dictionary
                             EDAKeyRequest : @{ // description of request
                                     EDAKeySuccess  : @false, // if the request was succesful
                                     EDAKeyInfo     : @"Failed to login" // text accompanying the response
                                     },
                             },
                     }
             };
}

//
// request: /data/{id} - where id is the id of an individual record
//

static inline
NSDictionary * EDATestDataWithIdResponse() {
    return @{
             EDAKeyData : @[
                     @{
                         EDAKeyID : @1, // id
                         EDAKeyContent  : @"MAMAPAPADEDABABA", // length of each string should be random between 10 and 200 symbols
                         EDAKeyMessage  : @"ABABABAAAAAAABBBBAAAA!!!", // // length should be random between 100 and 2000 symbols
                         EDAKeyImage    : @"http://www.de", // image URL pointing to real image (should differ for different ids)
                         EDAKeyImages   : @[@"http://www.de/1.jpg", @"http://www.de/2.jpg"] // image URLs pointing to additional real image (can be duplicated for different ids)
                         }
                     ]
             };
}

#endif /* EDATestAPI_h */
