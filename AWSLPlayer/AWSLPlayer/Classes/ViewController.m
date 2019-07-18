//
//  ViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//
#import <NSObjectSignals/NSObject+SignalsSlots.h>
#import <Masonry/Masonry.h>
#import "ViewController.h"
#import "APAVPlayerView.h"
#import "APBiliBiliLive.h"
#import "APMacroHelper.h"
#import "APYoutubeLive.h"
#import "APLineLive.h"
#import "APHibikiLive.h"

@interface ViewController ()
@property (nonatomic, strong) APAVPlayerView *player;
@property (nonatomic, strong) APBiliBiliLive *bilibiliLive;

@property (nonatomic, strong) APAVPlayerView *player2;
@property (nonatomic, strong) APHibikiLive *hibiki;

@property (nonatomic, strong) APAVPlayerView *player3;
@property (nonatomic, strong) APLineLive *lineLive;

@property (nonatomic, strong) APAVPlayerView *player4;
@property (nonatomic, strong) APYoutubeLive *youtubeLive;

@end

@implementation ViewController

- (void)didInitialize {
    [super didInitialize];
}

- (void)initSubviews {
    [super initSubviews];
    
    self.player = [[APAVPlayerView alloc] init];
    self.player.userInteractionEnabled = NO;
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

- (void)bindData {
    [self.bilibiliLive listenKeypath:@"playURLs" pairWithSignal:NS_SIGNAL_SELECTOR(playURLsDidChange) forObserver:self slot:NS_PROPERTY_SLOT_SELECTOR(bilibiliLive_PlayURLs)];
    [self.player connectSignal:NS_SIGNAL_SELECTOR(playerStatusChange) forObserver:self slot:NS_SLOT_SELECTOR(onBiliBiliPlayerStatusChange)];
}

NS_PROPERTY_SLOT(bilibiliLive_PlayURLs) {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.player.userInteractionEnabled = newValue == nil ? NO : YES;
    });
}

- (NS_SLOT)onBiliBiliPlayerStatusChange {
    NSLog(@"bilibili player status change");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    weakSelf(self);
    
    self.bilibiliLive = [[APBiliBiliLive alloc] initWithRoomID:13291884];

    [self.bilibiliLive requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
        if (error == nil && playURLs.count > 0) {
            weakSelf.player.playURL = [playURLs allValues][0];
            NSLog(@"Ready to play1");
        }
    }];
    
    self.hibiki = [[APHibikiLive alloc] initWithAccessID:@"poppin-radio"];
    [self.hibiki requestPlayURLsWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
        if (error == nil && playURLs.count > 0) {
            weakSelf.player2.playURL = [playURLs allValues][0];
            NSLog(@"Ready to play2");
        }
    }];
    
    self.lineLive = [[APLineLive alloc] initWithChannelID:3539389 broadcastID:11656845];
    [self.lineLive requestPlayURLsWithCompletions:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
        if (error == nil) {
            weakSelf.player3.playURL = [playURLs allValues][0];
            NSLog(@"Ready to play3");
        }
    }];
    
    NSURL *liveRoomURL = [NSURL URLWithString:@"https://www.youtube.com/watch?v=vrwSrCr9J4s&app=desktop"];
    self.youtubeLive = [[APYoutubeLive alloc] initWithLiveRoomURL:liveRoomURL];
    [self.youtubeLive requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
        if (error == nil && playURLs.count > 0) {
            weakSelf.player4.playURL = [playURLs allValues][0];
            NSLog(@"Ready to play4");
        }
    }];
    
    [self bindData];
}

@end
