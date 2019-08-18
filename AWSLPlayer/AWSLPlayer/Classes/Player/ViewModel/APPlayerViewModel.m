//
//  APPlayerViewModel.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APPlayerViewModel.h"

@interface APPlayerViewModel ()
@property (nonatomic, assign) APPlayerViewModelStatus status;
@end

@implementation APPlayerViewModel

#pragma mark - Signals & Slots

NS_CLOSE_SIGNAL_WARN(itemStatusChange);
NS_PROPERTY_SLOT(itemStatus) {
    APPlayerViewModelStatus lastStatus = self.status;
    if ([newValue isEqualToNumber:@(AVPlayerItemStatusFailed)]) {
        self.status = APPlayerViewModelStatusItemFailed;
    } else if ([newValue isEqualToNumber:@(AVPlayerItemStatusUnknown)]) {
        self.status = APPlayerViewModelStatusItemUnknow;
    } else if ([newValue isEqualToNumber:@(AVPlayerItemStatusReadyToPlay)]) {
        self.status = APPlayerViewModelStatusItemReady;
    }
    [self emitSignal:NS_SIGNAL_SELECTOR(statusChange) withParams:@[@(self.status), @(lastStatus), self]];
}

NS_CLOSE_SIGNAL_WARN(playerStatusChange);
NS_PROPERTY_SLOT(playerStatus) {
    APPlayerViewModelStatus lastStatus = self.status;
    if ([newValue isEqualToNumber:@(AVPlayerStatusReadyToPlay)]) {
        self.status = APPlayerViewModelStatusPlayerReady;
    } else if ([newValue isEqualToNumber:@(AVPlayerStatusUnknown)]) {
        self.status = APPlayerViewModelStatusPlayerUnknow;
    } else if ([newValue isEqualToNumber:@(AVPlayerStatusFailed)]) {
        self.status = APPlayerViewModelStatusPlayerFailed;
    }
    [self emitSignal:NS_SIGNAL_SELECTOR(statusChange) withParams:@[@(self.status), @(lastStatus), self]];
}

NS_CLOSE_SIGNAL_WARN(timeControlStatusChange);
NS_CLOSE_SIGNAL_WARN(statusChange)
NS_PROPERTY_SLOT(status) {
    APPlayerViewModelStatus lastStatus = self.status;
    if ([newValue isKindOfClass:[NSNumber class]]) {
        if ([newValue isEqualToNumber:@(AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate)]) {
            self.status = APPlayerViewModelStatusLoading;
        } else if ([newValue isEqualToNumber:@(AVPlayerTimeControlStatusPlaying)]) {
            self.status = APPlayerViewModelStatusPlaying;
        } else if ([newValue isEqualToNumber:@(AVPlayerTimeControlStatusPaused)]) {
            self.status = APPlayerViewModelStatusPause;
        }
    }
    
    [self emitSignal:NS_SIGNAL_SELECTOR(statusChange) withParams:@[@(self.status), @(lastStatus), self]];
}

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _enableBackground = YES;
        _player = [[AVPlayer alloc] init];
    }
    return self;
}


- (void)bindData {
    // 绑定播放器状态变更
    [self.player listenKeypath:@"status" pairWithSignal:NS_SIGNAL_SELECTOR(playerStatusChange) forObserver:self slot:NS_PROPERTY_SLOT_SELECTOR(playerStatus)];
    [self.player listenKeypath:@"timeControlStatus" pairWithSignal:NS_SIGNAL_SELECTOR(timeControlStatusChange) forObserver:self slot:NS_PROPERTY_SLOT_SELECTOR(status)];
    [self.player.currentItem listenKeypath:@"status" pairWithSignal:NS_SIGNAL_SELECTOR(itemStatusChange) forObserver:self slot:NS_PROPERTY_SLOT_SELECTOR(itemStatus)];
}

#pragma mark - Method

- (void)setupPlayer {
    [self setupPlayerWithPlayURLs:self.playURLs];
}

- (void)setupPlayerWithPlayURLs:(NSDictionary *)playURLs {
    if (self.playURLs == playURLs) {
        return;
    }
    if (playURLs.count == 0) {
        return;
    }
    
    self.playURLs = playURLs;
    NSURL *defaultURL = [self.playURLs allValues][0];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:defaultURL options:nil];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:asset];
    item.preferredForwardBufferDuration = 3;
    [self.player replaceCurrentItemWithPlayerItem:item];

    [self bindData];
}

- (void)play {
    [self playImmediately:NO];
}

- (void)playImmediately:(BOOL)flag {
    if (flag) {
        [self.player playImmediatelyAtRate:1];
    } else {
        [self.player play];
    }
}

- (void)pause {
    [self.player pause];
}

- (void)stop {
    [self.player pause];
}


@end
