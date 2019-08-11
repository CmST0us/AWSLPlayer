//
//  APPlayerViewModel.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <NSObjectSignals/NSObject+SignalsSlots.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, APPlayerViewModelStatus) {
    APPlayerViewModelStatusFailed = -2,
    APPlayerViewModelStatusUnknow = -1,
    APPlayerViewModelStatusReady,
    APPlayerViewModelStatusPlaying,
    APPlayerViewModelStatusPause,
    APPlayerViewModelStatusStop,
    APPlayerViewModelStatusLoading,
};

@class APLiveURLModel;
@interface APPlayerViewModel : NSObject

@property (nonatomic, strong) APLiveURLModel *liveURLModel;
@property (nonatomic, strong) NSDictionary *playURLs;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, readonly) APPlayerViewModelStatus status;
#pragma mark - Configuration
@property (nonatomic, assign) BOOL enableBackground;

#pragma mark - Subclass Override
- (void)setupPlayer;
- (void)setupPlayerWithPlayURLs:(NSDictionary *)playURLs;

- (void)play;
- (void)playImmediately:(BOOL)flag;
- (void)pause;
- (void)stop;

// 绑定数据，使用抛出信号
#pragma mark - Signals
// 播放器状态变化: NSNumber<APPlayerViewModelStatus>
// @param: newValue
// @param: oldValue
// @param: view model
NS_SIGNAL(statusChange);
@end

NS_ASSUME_NONNULL_END
