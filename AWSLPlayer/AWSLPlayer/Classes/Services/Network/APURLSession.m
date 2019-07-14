//
//  APURLSession.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APURLSession.h"

@interface APURLSession ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation APURLSession
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSURLSession *)session {
    if (_session == nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

- (NSURLSessionDataTask *)get:(NSURL *)url completion:(APURLSessionGETCompletionBlock)block {
    return [self.session dataTaskWithURL:url completionHandler:block];
}

- (NSURLSessionDataTask *)getRequest:(NSURLRequest *)request completion:(APURLSessionGETCompletionBlock)block {
    return [self.session dataTaskWithRequest:request completionHandler:block];
}


@end
