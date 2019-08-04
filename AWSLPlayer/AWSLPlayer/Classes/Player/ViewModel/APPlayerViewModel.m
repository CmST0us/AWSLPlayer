//
//  APPlayerViewModel.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APPlayerViewModel.h"

@interface APPlayerViewModel ()
@property (nonatomic, assign) BOOL isPlaying;
@end

@implementation APPlayerViewModel

NS_CLOSE_SIGNAL_WARN(playerStatusChange);
NS_PROPERTY_SLOT(playerStatus) {
    [self emitSignal:NS_SIGNAL_SELECTOR(playerStatusChange) withParams:@[newValue, oldValue, self]];
}

NS_CLOSE_SIGNAL_WARN(rateChange);
NS_PROPERTY_SLOT(rate) {
    if ([newValue floatValue] > 0.001) {
        self.isPlaying = YES;
    } else {
        self.isPlaying = NO;
    }
    [self emitSignal:NS_SIGNAL_SELECTOR(rateChange) withParams:@[newValue, oldValue, self]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isPlayerInit = NO;
        _enableBackground = YES;
    }
    return self;
}

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
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:defaultURL];
    self.player = [AVPlayer playerWithPlayerItem:item];
    _isPlayerInit = YES;
    
    [self bindData];
}

- (void)bindData {
    // 绑定播放器状态变更
    [self.player listenKeypath:@"status" pairWithSignal:NS_SIGNAL_SELECTOR(playerStatusChange) forObserver:self slot:NS_PROPERTY_SLOT_SELECTOR(playerStatus)];
    [self.player listenKeypath:@"rate" pairWithSignal:NS_SIGNAL_SELECTOR(rateChange) forObserver:self slot:NS_PROPERTY_SLOT_SELECTOR(rate)];
}

- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

- (void)stop {
    [self.player pause];
}

@end
