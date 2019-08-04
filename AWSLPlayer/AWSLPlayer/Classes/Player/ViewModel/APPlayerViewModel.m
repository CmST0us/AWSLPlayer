//
//  APPlayerViewModel.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APPlayerViewModel.h"

@implementation APPlayerViewModel
NS_CLOSE_SIGNAL_WARN(playerStatusChange);

NS_PROPERTY_SLOT(playerStatus) {
    [self emitSignal:NS_SIGNAL_SELECTOR(playerStatusChange) withParams:@[newValue, oldValue, self]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isPlayerInit = NO;
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
    
}

- (void)play {
    [self.player play];
    self.isPlaying = YES;
}

- (void)pause {
    [self.player pause];
    self.isPlaying = NO;
}

- (void)stop {
    [self.player pause];
}

@end
