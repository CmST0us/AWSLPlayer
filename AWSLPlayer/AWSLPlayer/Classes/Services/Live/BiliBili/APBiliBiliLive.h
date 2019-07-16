//
//  APBiliBiliLive.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APRequestPlatformLivePlayURLProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface APBiliBiliLive : NSObject<APRequestPlatformLivePlayURLProtocol>
@property (nonatomic, assign) NSTimeInterval timeout; // Default is 10 sec;
@property (nonatomic, readonly) NSInteger requestedRoomID;
@property (nonatomic, readonly) NSInteger realRoomID;

@property (nonatomic, readonly, nullable) NSDictionary<NSString *, NSURL *> *playURLs;

- (instancetype)initWithRoomID:(NSInteger)roomID;
- (void)requestPlayURLWithCompletion:(APRequestPlatformLivePlayURLBlock)block;
    
@end

NS_ASSUME_NONNULL_END
