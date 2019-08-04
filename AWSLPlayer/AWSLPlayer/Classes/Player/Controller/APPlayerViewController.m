//
//  APPlayerViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "APMacroHelper.h"

#import "APVVMBindingContainer.h"
#import "APDDPlayerModel.h"
#import "APLiveURLModel.h"

#import "APYoutubeLive.h"
#import "APBiliBiliLive.h"

#import "APPlayerViewModel.h"
#import "APPlayerViewController.h"
#import "APPlayerView.h"
#import "APPlayerControlView.h"

@interface APPlayerViewController ()
@property (nonatomic, strong) APDDPlayerModel *ddPlayerModel;
@property (nonatomic, strong) NSMutableArray<APVVMBindingContainer<APPlayerView *, APPlayerViewModel *> *> *playersContainer;
@end

@implementation APPlayerViewController

#pragma mark - Init
- (instancetype)initWithDDPlayerModel:(APDDPlayerModel *)model {
    self = [super init];
    if (self) {
        _ddPlayerModel = model;
        _playersContainer = [[NSMutableArray alloc] initWithCapacity:model.liveURLs.count];
        
        [self setupPlayerView];
        [self addSubviews];
        [self setupConstraints];
        [self bindData];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)bindData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

#pragma mark - Slot

- (NS_SLOT)onPlayerStatusChangeWithNewValue:(NSNumber *)newValue
                                   oldValue:(NSNumber *)oldValue
                                  viewModel:(APPlayerViewModel *)viewModel{
    __block APPlayerView *v = nil;
    [self.playersContainer enumerateObjectsUsingBlock:^(APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj viewModel] == viewModel) {
            v = [obj view];
        }
    }];
    if ([newValue isEqualToNumber:@(AVPlayerStatusReadyToPlay)]) {
        [viewModel play];
    }
}

- (NS_SLOT)onPressPlayPauseButtonWithView:(APPlayerControlView *)controlView
                                viewModel:(APPlayerViewModel *)viewModel
                                   button:(APButton *)button {
    if (viewModel.isPlaying) {
        [viewModel pause];
    } else {
        [viewModel play];
    }
}

- (NS_SLOT)onPressExitPlayerButtonWithView:(APPlayerControlView *)view
                                 viewModel:(APPlayerViewModel *)viewModel
                                    button:(APButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NS_SLOT)onEnterBackgroundPlayerRateChangeWithNewValue:(NSNumber *)newValue
                                                oldValue:(NSNumber *)oldValue
                                               viewModel:(APPlayerViewModel *)viewModel {
    if ([newValue floatValue] < 0.0001) {
        if (viewModel.enableBackground) {
            [viewModel play];
        }
    }
}
#pragma mark - Action
- (void)onAppDidEnterBackground {
    [self pauseAll:YES];
}

- (void)onAppWillEnterForeground {
    [self playAll:YES];
}

#pragma mark - Private
- (void)pauseAll:(BOOL)shouldCheckPlayInBackground {
    [self.playersContainer enumerateObjectsUsingBlock:^(APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (shouldCheckPlayInBackground) {
            if (![obj viewModel].enableBackground) {
                [[obj viewModel] pause];
            } else {
                [[obj viewModel] connectSignal:NS_SIGNAL_SELECTOR(rateChange) forObserver:self slot:NS_SLOT_SELECTOR(onEnterBackgroundPlayerRateChangeWithNewValue:oldValue:viewModel:)];
            }
        } else {
            [[obj viewModel] pause];
        }
        
    }];
}

- (void)playAll:(BOOL)shouldKeepLastStatus {
    [self.playersContainer enumerateObjectsUsingBlock:^(APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[obj viewModel] disconnectSignal:NS_SIGNAL_SELECTOR(rateChange) forObserver:self];
        if (!shouldKeepLastStatus) {
            [[obj viewModel] play];
        }
    }];
}
#pragma mark - Lazy Init


#pragma mark - Setup View
- (void)setupPlayerView {
    weakSelf(target);
    APLiveURLModel *liveURL = [self.ddPlayerModel.liveURLs allValues][0];
    APPlayerViewModel *playerViewModel = [[APPlayerViewModel alloc] init];
    APPlayerView *playerView = [[APPlayerView alloc] init];
    APVVMBindingContainer *container = [APVVMBindingContainer bindView:playerView withViewModel:playerViewModel];
    
    [playerView.controlView connectSignal:NS_SIGNAL_SELECTOR(didPressPlayPauseButton) forObserver:self slot:NS_SLOT_SELECTOR(onPressPlayPauseButtonWithView:viewModel:button:)];
    [playerView.controlView connectSignal:NS_SIGNAL_SELECTOR(didPressExitPlayerButton) forObserver:self slot:NS_SLOT_SELECTOR(onPressExitPlayerButtonWithView:viewModel:button:)];
    
    
    [self.playersContainer addObject:container];
    if (liveURL.urlType == APLiveURLTypeYoutube) {
        APYoutubeLive *youtubeLive = [[APYoutubeLive alloc] initWithLiveRoomURL:liveURL.liveURL];
        liveURL.processor = youtubeLive;
        [youtubeLive requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [playerViewModel setupPlayerWithPlayURLs:playURLs];
                [playerView setupWithViewModel:playerViewModel];
                [playerViewModel connectSignal:NS_SIGNAL_SELECTOR(playerStatusChange) forObserver:target slot:NS_SLOT_SELECTOR(onPlayerStatusChangeWithNewValue:oldValue:viewModel:)];
            });
        }];
    } if (liveURL.urlType == APLiveURLTypeBiliBili) {
        APBiliBiliLive *bilibili = [[APBiliBiliLive alloc] initWithLiveRoomURL:liveURL.liveURL];
        liveURL.processor = bilibili;
        [bilibili requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [playerViewModel setupPlayerWithPlayURLs:playURLs];
                [playerView setupWithViewModel:playerViewModel];
                [playerViewModel connectSignal:NS_SIGNAL_SELECTOR(playerStatusChange) forObserver:target slot:NS_SLOT_SELECTOR(onPlayerStatusChangeWithNewValue:oldValue:viewModel:)];
            });
        }];
    }
}

- (void)addSubviews {
    [self.playersContainer enumerateObjectsUsingBlock:^(APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addSubview:[obj view]];
    }];
}

- (void)setupConstraints {
    [self.playersContainer enumerateObjectsUsingBlock:^(APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[obj view] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [self playAll:NO];
                break;
            case UIEventSubtypeRemoteControlPause:
                [self pauseAll:YES];
            default:
                break;
        }
    }
}
@end
