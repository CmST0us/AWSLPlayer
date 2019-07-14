//
//  APURLSession.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSError+APURLSession.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^APURLSessionGETCompletionBlock)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface APURLSession : NSObject
@property (nonatomic, readonly) NSURLSession *session;
- (NSURLSessionDataTask *)get:(NSURL *)url completion:(APURLSessionGETCompletionBlock)block;
- (NSURLSessionDataTask *)getRequest:(NSURLRequest *)request completion:(APURLSessionGETCompletionBlock)block;

@end

NS_ASSUME_NONNULL_END
