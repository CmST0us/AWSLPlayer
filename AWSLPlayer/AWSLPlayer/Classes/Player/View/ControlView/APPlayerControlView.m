//
//  APPlayerControlView.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>
#import <KVOController/KVOController.h>
#import "APButton.h"

#import "APPlayerViewModel.h"
#import "APPlayerControlView.h"

@interface APPlayerControlView ()
@property (nonatomic, weak) APPlayerViewModel *viewModel;

@property (nonatomic, strong) APButton *playPauseButton;
@property (nonatomic, strong) APButton *exitPlayerButton;
@end

@implementation APPlayerControlView

#pragma mark -
- (void)didInitialize {
    [super didInitialize];
    [self addSubview:self.playPauseButton];
    [self addSubview:self.exitPlayerButton];
    
    self.controlViewType = APPlayerControlViewTypeMini;
    [self miniState];
}

- (void)bindData {
    __weak typeof(self) weakSelf = self;
    [self.viewModel addKVOObserver:self
                        forKeyPath:FBKVOKeyPath([weakSelf viewModel].status)
                             block:^(id  _Nullable oldValue, id  _Nullable newValue) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.playPauseButton.enabled = YES;
            if ([newValue isEqualToNumber:@(APPlayerViewModelStatusPlaying)]) {
                weakSelf.playPauseButton.backgroundColor = UIColorGreen;
            } else if ([newValue isEqualToNumber:@(APPlayerViewModelStatusPause)]) {
                weakSelf.playPauseButton.backgroundColor = UIColorRed;
            } else if ([newValue isEqualToNumber:@(APPlayerViewModelStatusLoading)] ||
                       [newValue isEqualToNumber:@(APPlayerViewModelStatusPlayerReady)]) {
                weakSelf.playPauseButton.backgroundColor = UIColorYellow;
            } else if ([newValue isEqualToNumber:@(APPlayerViewModelStatusItemFailed)]) {
                weakSelf.playPauseButton.backgroundColor = UIColorGray;
                weakSelf.playPauseButton.enabled = NO;
            }
        });
    }];
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
    [self emitSignal:@signalSelector(didPressPlayPauseButton) withParams:@[self, self.viewModel, sender]];
}

- (void)didPressExitPlayerButton:(id)sender {
    [self emitSignal:@signalSelector(didPressExitPlayerButton) withParams:@[self, self.viewModel ? : [NSNull null], sender]];
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
