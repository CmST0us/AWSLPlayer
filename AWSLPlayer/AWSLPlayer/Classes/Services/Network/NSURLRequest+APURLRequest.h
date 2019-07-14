//
//  NSURLRequest+APURLRequest.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLRequest (APURLRequest)

- (NSMutableURLRequest *)mutableURLRequest;

+ (NSURLRequest *)URLRequestWithURL:(NSURL *)url
                             Method:(NSString *)method;

+ (NSURLRequest *)URLRequestWithURL:(NSURL *)url
                             Method:(NSString *)method
                   customHTTPFields:(nullable NSDictionary *)httpFields;

+ (NSURLRequest *)URLRequestWithURL:(NSURL *)url
                             Method:(NSString *)method
                   customHTTPFields:(nullable NSDictionary *)httpFields
                           bodyData:(nullable NSData *)data;
@end

NS_ASSUME_NONNULL_END
