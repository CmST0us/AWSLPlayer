//
//  APPlayerControlView.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>
#import "APButton.h"

#import "APPlayerViewModel.h"
#import "APPlayerControlView.h"

@interface APPlayerControlView ()
@property (nonatomic, weak) APPlayerViewModel *viewModel;

@property (nonatomic, strong) APButton *playPauseButton;
@property (nonatomic, strong) APButton *exitPlayerButton;
@end

@implementation APPlayerControlView
NS_CLOSE_SIGNAL_WARN(didPressPlayPauseButton);
NS_CLOSE_SIGNAL_WARN(didPressExitPlayerButton);

#pragma mark - Property Slot
NS_CLOSE_SIGNAL_WARN(statusChange);
NS_PROPERTY_SLOT(status) {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.playPauseButton.enabled = YES;
        if ([newValue isEqualToNumber:@(APPlayerViewModelStatusPlaying)]) {
            self.playPauseButton.backgroundColor = UIColorGreen;
        } else if ([newValue isEqualToNumber:@(APPlayerViewModelStatusPause)]) {
            self.playPauseButton.backgroundColor = UIColorRed;
        } else if ([newValue isEqualToNumber:@(APPlayerViewModelStatusLoading)] ||
                   [newValue isEqualToNumber:@(APPlayerViewModelStatusPlayerReady)]) {
            self.playPauseButton.backgroundColor = UIColorYellow;
        } else if ([newValue isEqualToNumber:@(APPlayerViewModelStatusItemFailed)]) {
            self.playPauseButton.backgroundColor = UIColorGray;
            self.playPauseButton.enabled = NO;
        }
    });
}

#pragma mark -
- (void)didInitialize {
    [super didInitialize];
    [self addSubview:self.playPauseButton];
    [self addSubview:self.exitPlayerButton];
    
    self.controlViewType = APPlayerControlViewTypeMini;
    [self miniState];
}

- (void)bindData {
    [self.viewModel listenKeypath:@"status" pairWithSignal:NS_SIGNAL_SELECTOR(statusChange) forObserver:self slot:NS_PROPERTY_SLOT_SELECTOR(status)];
}

- (APButton *)playPauseButton {
    if (_playPauseButton == nil) {
        _playPauseButton = [[APButton alloc] init];
        _playPauseButton.extraTouchInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
        [_playPauseButton setBackgroundColor:UIColorRed];
        [_playPauseButton addTarget:self action:@selector(didPressPlayPauseButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _playPauseButton;
}

- (APButton *)exitPlayerButton {
    if (_exitPlayerButton == nil) {
        _exitPlayerButton = [[APButton alloc] init];
        _exitPlayerButton.extraTouchInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
        [_exitPlayerButton setBackgroundColor:UIColorBlue];
        [_exitPlayerButton addTarget:self action:@selector(didPressExitPlayerButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitPlayerButton;
}

- (void)setControlViewType:(APPlayerControlViewType)controlViewType {
    if (_controlViewType == controlViewType) {
        return;
    }
    _controlViewType = controlViewType;
    if (controlViewType == APPlayerControlViewTypeFull) {
        [self fullState];
    } else if (controlViewType == APPlayerControlViewTypeMini) {
        [self miniState];
    }
}

- (void)setupWithViewModel:(APPlayerViewModel *)model {
    self.viewModel = model;
    [self bindData];
}

- (void)didPressPlayPauseButton:(id)sender {
    if (self.viewModel == nil) return;
    [self emitSignal:NS_SIGNAL_SELECTOR(didPressPlayPauseButton) withParams:@[self, self.viewModel, sender]];
}

- (void)didPressExitPlayerButton:(id)sender {
    [self emitSignal:NS_SIGNAL_SELECTOR(didPressExitPlayerButton) withParams:@[self, self.viewModel ? : [NSNull null], sender]];
}

@end


@implementation APPlayerControlView (MiniState)

- (void)miniState {
    if (self.controlViewType != APPlayerControlViewTypeMini) {
        return;
    }
    [self miniStateSetupConstraints];
}

- (void)miniStateSetupConstraints {
    [self.playPauseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.exitPlayerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(44);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

@end

@implementation APPlayerControlView (FullState)

- (void)fullState {
    if (self.controlViewType != APPlayerControlViewTypeFull) {
        return;
    }
    [self fullStateSetupConstraints];
}

- (void)fullStateSetupConstraints {
    [self.playPauseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.exitPlayerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(44);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}
@end
