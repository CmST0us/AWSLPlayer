//
//  APLineLive.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/16.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APPlatformLiveURLProcessor.h"
NS_ASSUME_NONNULL_BEGIN

@interface APLineLive : APPlatformLiveURLProcessor
@property (nonatomic, readonly) NSUInteger requestedChannelID;
@property (nonatomic, readonly) NSUInteger requestedBroadcastID;

@property (nonatomic, readonly) NSDictionary<NSString *, NSURL *> *playURLs;

- (instancetype)initWithChannelID:(NSUInteger)channelID
                      broadcastID:(NSUInteger)broadcastID;
    
- (void)requestPlayURLWithCompletion:(APRequestPlatformLivePlayURLBlock)block;
@end

NS_ASSUME_NONNULL_END
