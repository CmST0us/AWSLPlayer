//
//  APYoutubeLive.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/15.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APYoutubeURLSession.h"
#import "APRequestPlatformLivePlayURLProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface APYoutubeLive : NSObject<APRequestPlatformLivePlayURLProtocol>
@property (nonatomic, readonly) NSURL *liveRoomURL;

@property (nonatomic, readonly, nullable) NSDictionary<NSString *, NSURL *> *playURLs;

- (instancetype)initWithLiveRoomURL:(NSURL *)liveRoomURL;

- (void)requestPlayURLWithCompletion:(APRequestPlatformLivePlayURLBlock)block;

@end

NS_ASSUME_NONNULL_END
