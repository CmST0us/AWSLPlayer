//
//  APPlayerViewModel.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <NSObjectSignals/NSObjectSignals.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, APPlayerViewModelStatus) {
    APPlayerViewModelStatusItemUnknow = -4,
    APPlayerViewModelStatusItemFailed = -3,
    APPlayerViewModelStatusPlayerFailed = -2,
    APPlayerViewModelStatusPlayerUnknow = -1,
    APPlayerViewModelStatusPlayerReady = 0,
    APPlayerViewModelStatusItemReady,   // 1
    APPlayerViewModelStatusPlaying,     // 2
    APPlayerViewModelStatusPause,       // 3
    APPlayerViewModelStatusStop,        // 4
    APPlayerViewModelStatusLoading,     // 5
};

@class APLiveURLModel;

@signals APPlayerViewModelSignals
@optional
// 绑定数据，使用抛出信号
// 播放器状态变化: NSNumber<APPlayerViewModelStatus>
// @param: newValue
// @param: oldValue
// @param: view model
- (void)statusChange;
@end

@interface APPlayerViewModel : NSObject<APPlayerViewModelSignals>

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
@end

NS_ASSUME_NONNULL_END
