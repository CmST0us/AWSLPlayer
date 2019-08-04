//
//  APPlayerDisplayView.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "APPlayerViewModel.h"
#import "APPlayerDisplayView.h"

@interface APPlayerDisplayView ()
@property (nonatomic, readonly) AVPlayerLayer *playerLayer;
@property (nonatomic, weak) APPlayerViewModel *viewModel;
@end

@implementation APPlayerDisplayView

- (void)didInitialize {
    [super didInitialize];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)bindData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)onAppEnterBackground {
    self.playerLayer.player = nil;
}

- (void)onAppBecomeActive {
    self.playerLayer.player = self.viewModel.player;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

- (void)setupWithViewModel:(APPlayerViewModel *)model {
    self.viewModel = model;
    self.playerLayer.player = model.player;
}

@end
