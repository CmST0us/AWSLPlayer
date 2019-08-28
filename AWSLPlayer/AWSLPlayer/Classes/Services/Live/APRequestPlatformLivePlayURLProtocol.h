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
/// 初始化
/// @param url 直播间URL
- (nullable instancetype)initWithLiveRoomURL:(NSURL *)url;
// 返回播放列表
// K: 清晰度
// V: 播放地址
- (NSDictionary<NSString *, NSURL *> * _Nullable )playURLs;


/// 请求播放地址
/// @param block 回调
- (void)requestPlayURLWithCompletion:(APRequestPlatformLivePlayURLBlock)block;
@end

NS_ASSUME_NONNULL_END
