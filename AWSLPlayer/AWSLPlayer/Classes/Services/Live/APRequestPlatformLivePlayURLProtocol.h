//
//  APRequestPlatformLivePlayURLProtocol.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/15.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObjectSignals/NSObject+SignalsSlots.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^APRequestPlatformLivePlayURLBlock)(NSDictionary * _Nullable playURLs, NSError * _Nullable error);

@protocol APRequestPlatformLivePlayURLProtocol <NSObject>
@required
// 返回播放列表
// K: 清晰度
// V: 播放地址
- (NSDictionary<NSString *, NSURL *> * _Nullable )playURLs;
NS_SIGNAL(playURLsDidChange);
@end

NS_ASSUME_NONNULL_END
