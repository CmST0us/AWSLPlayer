//
//  APAVPlayerView.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>
#import <KVOController/KVOController.h>
#import "APAVPlayerView.h"

@interface APAVPlayerView ()
// M
@property (nonatomic, strong) AVURLAsset *remoteAsset;
@property (nonatomic, strong) AVPlayerItem *assetItem;

// V
@property (nonatomic, strong) QMUIFillButton *playButton;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

// C
@property (nonatomic, strong) AVPlayer *player;

@end

@implementation APAVPlayerView

- (void)didInitialize {
    [super didInitialize];
    self.playButton = [[QMUIFillButton alloc] initWithFrame:CGRectZero];
    [self.playButton setTitle:@"Press" forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(startPlay) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(8);
    }];
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (void)printSupportMedia {
    [[AVURLAsset audiovisualTypes] enumerateObjectsUsingBlock:^(AVFileType  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Support Type: %@", obj);
    }];
    [[AVURLAsset audiovisualMIMETypes] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Support MIMETypes: %@", obj);
    }];
}

- (void)startPlay {
    self.playerLayer.player = self.player;
    [self.player play];
}

- (AVPlayerItem *)assetItem {
    if (_assetItem == nil) {
        _assetItem = [[AVPlayerItem alloc] initWithAsset:self.remoteAsset];
    }
    return _assetItem;
}

- (AVPlayer *)player {
    __weak typeof(self) weakSelf = self;
    if (_player == nil) {
        _player = [[AVPlayer alloc] initWithPlayerItem:self.assetItem];
        [_player addKVOObserver:self
                     forKeyPath:FBKVOKeyPath(_player.status)
                          block:^(id  _Nullable oldValue, id  _Nullable newValue) {
            NSLog(@"new status %@", newValue);
            [weakSelf emitSignal:@signalSelector(playerStatusChange) withParams:@[newValue, oldValue]];
        }];
    }
    return _player;
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

- (AVURLAsset *)remoteAsset {
    if (_remoteAsset == nil) {
        NSAssert(self.playURL != nil, @"Please set playURL");
        _remoteAsset = [[AVURLAsset alloc] initWithURL:self.playURL options:nil];
    }
    return _remoteAsset;
}


@end
