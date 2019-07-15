//
//  NSError+APURLSession.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "NSError+APURLSession.h"

const NSString *APURLSessionErrorDomain = @"APURLSessionErrorDomain";

@implementation NSError (APURLSession)
+ (NSError *)errorWithAPURLSessionError:(APURLSessionError)error userInfo:(NSDictionary *)userInfo {
    NSError *e = [NSError errorWithDomain:[APURLSessionErrorDomain copy] code:error userInfo:userInfo];
    return e;
}

@end
