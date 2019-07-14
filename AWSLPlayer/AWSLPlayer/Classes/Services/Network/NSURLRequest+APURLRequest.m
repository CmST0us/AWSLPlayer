//
//  NSURLRequest+APURLRequest.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "NSURLRequest+APURLRequest.h"

@implementation NSURLRequest (APURLRequest)

+ (NSURLRequest *)URLRequestWithURL:(NSURL *)url Method:(NSString *)method {
    return [NSURLRequest URLRequestWithURL:url Method:method customHTTPFields:NULL];
}

+ (NSURLRequest *)URLRequestWithURL:(NSURL *)url
                             Method:(NSString *)method
                   customHTTPFields:(NSDictionary *)httpFields {
    return [NSURLRequest URLRequestWithURL:url Method:method customHTTPFields:httpFields bodyData:NULL];
}

+ (NSURLRequest *)URLRequestWithURL:(NSURL *)url
                             Method:(NSString *)method
                   customHTTPFields:(NSDictionary *)httpFields
                           bodyData:(NSData *)data {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = method;
    if (httpFields != NULL) {
        NSMutableDictionary *currentHTTPFields = [[NSMutableDictionary alloc] initWithDictionary:[request allHTTPHeaderFields]];
        [currentHTTPFields addEntriesFromDictionary:httpFields];
        [request setAllHTTPHeaderFields:currentHTTPFields];
    }
    [request setHTTPBody:data];
    return request;
}

- (NSMutableURLRequest *)mutableURLRequest {
    return [self mutableCopy];
}

@end
