//
//  APLineLive.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/16.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APRequestPlatformLivePlayURLProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface APLineLive : NSObject<APRequestPlatformLivePlayURLProtocol>
@property (nonatomic, readonly) NSUInteger requestedChannelID;
@property (nonatomic, readonly) NSUInteger requestedBroadcastID;

// [TODO]: 标准化到播放地址接口
@property (nonatomic, readonly) NSDictionary<NSString *, NSURL *> *playURLs; // K: 清晰度, V: 播放地址

- (instancetype)initWithChannelID:(NSUInteger)channelID
                      broadcastID:(NSUInteger)broadcastID;
    
- (void)requestPlayURLsWithCompletions:(APRequestPlatformLivePlayURLBlock)block;
@end

NS_ASSUME_NONNULL_END
