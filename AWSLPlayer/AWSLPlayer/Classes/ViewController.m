//
//  ViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//
#import <NSObjectSignals/NSObjectSignals.h>
#import <KVOController/KVOController.h>
#import <Masonry/Masonry.h>
#import "ViewController.h"
#import "APAVPlayerView.h"
#import "APBiliBiliLive.h"
#import "APMacroHelper.h"
#import "APYoutubeLive.h"
#import "APLineLive.h"
#import "APHibikiLive.h"

@slots ViewControllerSlots
@required

@end

@interface ViewController ()<ViewControllerSlots>
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
    __weak typeof(self) weakSelf = self;
    [self.bilibiliLive addKVOObserver:self
                           forKeyPath:FBKVOKeyPath([self bilibiliLive].playURLs)
                                block:^(id  _Nullable oldValue, id  _Nullable newValue) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.player.userInteractionEnabled = newValue == nil ? NO : YES;
        });
    }];
    
    [self.player connectSignal:@signalSelector(playerStatusChange)
                   forObserver:self
                     blockSlot:^(NSArray * _Nonnull param) {
        NSLog(@"bilibili player status change");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    weakSelf(target);
    
    self.bilibiliLive = [[APBiliBiliLive alloc] initWithRoomID:13291884];

    [self.bilibiliLive requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
        if (error == nil && playURLs.count > 0) {
            target.player.playURL = [playURLs allValues][0];
            NSLog(@"Ready to play1");
        }
    }];
    
    self.hibiki = [[APHibikiLive alloc] initWithAccessID:@"poppin-radio"];
    [self.hibiki requestPlayURLsWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
        if (error == nil && playURLs.count > 0) {
            target.player2.playURL = [playURLs allValues][0];
            NSLog(@"Ready to play2");
        }
    }];
    
    self.lineLive = [[APLineLive alloc] initWithChannelID:3539389 broadcastID:11656845];
    [self.lineLive requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
        if (error == nil) {
            target.player3.playURL = [playURLs allValues][0];
            NSLog(@"Ready to play3");
        }
    }];
    
    NSURL *liveRoomURL = [NSURL URLWithString:@"https://www.youtube.com/watch?v=vrwSrCr9J4s&app=desktop"];
    self.youtubeLive = [[APYoutubeLive alloc] initWithLiveRoomURL:liveRoomURL];
    [self.youtubeLive requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
        if (error == nil && playURLs.count > 0) {
            target.player4.playURL = [playURLs allValues][0];
            NSLog(@"Ready to play4");
        }
    }];
    
    [self bindData];
}

@end
