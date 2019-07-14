//
//  ViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "ViewController.h"
#import "APAVPlayerView.h"
#import "APBiliBiliLive.h"
#import "APMacroHelper.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) APAVPlayerView *player;
@property (nonatomic, strong) APBiliBiliLive *bilibiliLive;

@property (nonatomic, strong) APAVPlayerView *player2;
@property (nonatomic, strong) APBiliBiliLive *bilibiliLive2;

@property (nonatomic, strong) APAVPlayerView *player3;
@property (nonatomic, strong) APBiliBiliLive *bilibiliLive3;

@property (nonatomic, strong) APAVPlayerView *player4;
@property (nonatomic, strong) APBiliBiliLive *bilibiliLive4;
@end

@implementation ViewController

- (void)didInitialize {
    [super didInitialize];
}

- (void)initSubviews {
    [super initSubviews];
    
    self.player = [[APAVPlayerView alloc] init];
    [self.view addSubview:self.player];
    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).dividedBy(2);
        make.width.equalTo(self.view.mas_width).dividedBy(2);
    }];
    
    self.player2 = [[APAVPlayerView alloc] init];
    [self.view addSubview:self.player2];
    [self.player2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).dividedBy(2);
        make.width.equalTo(self.view.mas_width).dividedBy(2);
    }];
    
    self.player3 = [[APAVPlayerView alloc] init];
    [self.view addSubview:self.player3];
    [self.player3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).dividedBy(2);
        make.width.equalTo(self.view.mas_width).dividedBy(2);
    }];
    
    self.player4 = [[APAVPlayerView alloc] init];
    [self.view addSubview:self.player4];
    [self.player4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).dividedBy(2);
        make.width.equalTo(self.view.mas_width).dividedBy(2);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bilibiliLive = [[APBiliBiliLive alloc] initWithRoomID:10112];
    weakSelf(self);
    [self.bilibiliLive requestRealRoomIDWithCompletion:^(NSInteger realRoomID, NSError * _Nullable error) {
        if (error == nil) {
            [weakSelf.bilibiliLive requestPlayURLWithCompletion:^(NSArray<NSString *> * _Nullable playUrls, NSError * _Nullable error) {
                if (error == nil && playUrls.count > 0) {
                    weakSelf.player.playURL = [NSURL URLWithString:playUrls[0]];
                    NSLog(@"Ready to play");
                }
            }];
        }
    }];
    
    self.bilibiliLive2 = [[APBiliBiliLive alloc] initWithRoomID:449541];
    [self.bilibiliLive2 requestRealRoomIDWithCompletion:^(NSInteger realRoomID, NSError * _Nullable error) {
        if (error == nil) {
            [weakSelf.bilibiliLive2 requestPlayURLWithCompletion:^(NSArray<NSString *> * _Nullable playUrls, NSError * _Nullable error) {
                if (error == nil && playUrls.count > 0) {
                    weakSelf.player2.playURL = [NSURL URLWithString:playUrls[0]];
                    NSLog(@"Ready to play");
                }
            }];
        }
    }];
    
    self.bilibiliLive3 = [[APBiliBiliLive alloc] initWithRoomID:544588];
    [self.bilibiliLive3 requestRealRoomIDWithCompletion:^(NSInteger realRoomID, NSError * _Nullable error) {
        if (error == nil) {
            [weakSelf.bilibiliLive3 requestPlayURLWithCompletion:^(NSArray<NSString *> * _Nullable playUrls, NSError * _Nullable error) {
                if (error == nil && playUrls.count > 0) {
                    weakSelf.player3.playURL = [NSURL URLWithString:playUrls[0]];
                    NSLog(@"Ready to play");
                }
            }];
        }
    }];
    
    self.bilibiliLive4 = [[APBiliBiliLive alloc] initWithRoomID:888];
    [self.bilibiliLive4 requestRealRoomIDWithCompletion:^(NSInteger realRoomID, NSError * _Nullable error) {
        if (error == nil) {
            [weakSelf.bilibiliLive4 requestPlayURLWithCompletion:^(NSArray<NSString *> * _Nullable playUrls, NSError * _Nullable error) {
                if (error == nil && playUrls.count > 0) {
                    weakSelf.player4.playURL = [NSURL URLWithString:playUrls[0]];
                    NSLog(@"Ready to play");
                }
            }];
        }
    }];
}

@end
