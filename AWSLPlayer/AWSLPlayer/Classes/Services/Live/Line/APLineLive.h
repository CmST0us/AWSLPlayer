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

@property (nonatomic, readonly) NSDictionary<NSString *, NSURL *> *playURLs;

- (instancetype)initWithChannelID:(NSUInteger)channelID
                      broadcastID:(NSUInteger)broadcastID;
    
- (void)requestPlayURLsWithCompletions:(APRequestPlatformLivePlayURLBlock)block;
@end

NS_ASSUME_NONNULL_END
