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

static inline NSDictionary * testDataSuccessfulResponse() {
    return @{
             @"response" : @{ // dictionary to contain all the response data
                     @"meta" : @{ // metadata dictionary
                             @"request" : @{ // description of request
                                     @"sucess" : @true, // if the request was succesful
                                     @"info" : @"Logged in successfully" // text accompanying the response
                                     },
                             @"layout" : @{ // pagination dictionary
                                     @"index" : @0, // index of the requested data, which is the starting idnex of the data to be returned
                                     @"count" : @1, // amount of data items requested from the current index
                                     @"totalCount" : @1 // total amount of data present in the database for the current request
                                     },
                             },
                     @"data" : @[
                             @{
                                 @"id" : @1, // id
                                 @"content" : @"MAMAPAPADEDABABA", // length should be random between 10 and 200 symbols
                                 @"image" : @"http://www.1.de" // image URL pointing to real image (should differ for different ids)
                                 },
                             @{
                                 @"id" : @2, // id
                                 @"content" : @"PAPAMAMABABADEDA", // length should be random between 10 and 200 symbols
                                 @"image" : @"http://www.2.de" // image URL pointing to real image (should differ for different ids)
                                 }
                             ]
                     }
             };
}


static inline NSDictionary * testDataUnsuccessfulResponse() {
    return @{
             @"response" : @{ // dictionary to contain all the response data
                     @"meta" : @{ // metadata dictionary
                             @"request" : @{ // description of request
                                     @"sucess" : @false, // if the request was succesful
                                     @"info" : @"Failed to login" // text accompanying the response
                                     },
                             },
                     }
             };
}

//
// request: /data/{id} - where id is the id of an individual record
//

static inline NSDictionary * testDataWithIdResponse() {
    return @{
             @"data" : @[
                     @{
                         @"id" : @1, // id
                         @"content" : @"MAMAPAPADEDABABA", // length of each string should be random between 10 and 200 symbols
                         @"message" : @"ABABABAAAAAAABBBBAAAA!!!", // // length should be random between 100 and 2000 symbols
                         @"image" : @"http://www.de", // image URL pointing to real image (should differ for different ids)
                         @"images" : @[@"http://www.de/1.jpg", @"http://www.de/2.jpg"] // image URLs pointing to additional real image (can be duplicated for different ids)
                         }
                     ]
             };
}

#endif /* EDATestAPI_h */
