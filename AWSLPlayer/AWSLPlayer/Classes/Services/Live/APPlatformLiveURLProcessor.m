//
//  APPlatformLiveURLProcessor.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/11.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APPlatformLiveURLProcessor.h"

@implementation APPlatformLiveURLProcessor
- (instancetype)initWithLiveRoomURL:(NSURL *)url {
    NSAssert(false, @"Use subclass");
    return nil;
}

- (NSDictionary<NSString *,NSURL *> *)playURLs {
    NSAssert(false, @"Use subclass");
    return nil;
}

- (void)requestPlayURLWithCompletion:(APRequestPlatformLivePlayURLBlock)block {
    NSAssert(false, @"Use subclass");
}

@end
