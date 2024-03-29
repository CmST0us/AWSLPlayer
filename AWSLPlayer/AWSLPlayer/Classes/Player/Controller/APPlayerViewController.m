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
#import "APDDPlayerLayoutModel.h"

#import "APPlatformLiveURLProcessor.h"

#import "APPlayerViewModel.h"
#import "APPlayerViewController.h"
#import "APPlayerView.h"
#import "APPlayerControlView.h"

@slots APPlayerViewControllerSlots
@required
- (void)onPlayerStatusChangeWithNewValue:(NSNumber *)newValue
                                oldValue:(NSNumber *)oldValue
                               viewModel:(APPlayerViewModel *)viewModel;

- (void)onPressPlayPauseButtonWithView:(APPlayerControlView *)controlView
                             viewModel:(APPlayerViewModel *)viewModel
                                button:(APButton *)button;

- (void)onEnterBackgroundPlayerStatusChangeWIthNewValue:(NSNumber *)newValue
                                               oldValue:(NSNumber *)oldValue
                                              viewModel:(APPlayerViewModel *)viewModel;
@end

@interface APPlayerViewController () <APPlayerViewControllerSlots>
@property (nonatomic, strong) APDDPlayerModel *ddPlayerModel;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, APVVMBindingContainer<APPlayerView *, APPlayerViewModel *> *> *playersContainer;
@end

@implementation APPlayerViewController

#pragma mark - Init
- (instancetype)initWithDDPlayerModel:(APDDPlayerModel *)model {
    self = [super init];
    if (self) {
        _ddPlayerModel = model;
        _playersContainer = [[NSMutableDictionary alloc] initWithCapacity:model.liveURLs.count];
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

- (void)onPlayerStatusChangeWithNewValue:(NSNumber *)newValue
                                   oldValue:(NSNumber *)oldValue
                                  viewModel:(APPlayerViewModel *)viewModel {
    __block APPlayerView *v = nil;
    [self.playersContainer enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj viewModel] == viewModel) {
            v = [obj view];
        }
    }];
    if ([newValue isEqualToNumber:@(APPlayerViewModelStatusItemReady)]) {
        [viewModel play];
    } else if ([newValue isEqualToNumber:@(APPlayerViewModelStatusItemFailed)]) {
        __weak typeof(viewModel) weakViewModel = viewModel;
        [viewModel.liveURLModel.processor requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
            if (error == nil) {
                [weakViewModel setupPlayerWithPlayURLs:playURLs];
            }
        }];
    }
}

- (void)onPressPlayPauseButtonWithView:(APPlayerControlView *)controlView
                                viewModel:(APPlayerViewModel *)viewModel
                                   button:(APButton *)button {
    if (viewModel.status == APPlayerViewModelStatusPlaying) {
        [viewModel pause];
    } else if (viewModel.status == APPlayerViewModelStatusPause){
        [viewModel play];
    } else if (viewModel.status == APPlayerViewModelStatusLoading) {
        [viewModel playImmediately:YES];
    }
}

- (void)onPressExitPlayerButtonWithView:(APPlayerControlView *)view
                                 viewModel:(APPlayerViewModel *)viewModel
                                    button:(APButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onEnterBackgroundPlayerStatusChangeWIthNewValue:(NSNumber *)newValue
                                                  oldValue:(NSNumber *)oldValue
                                                 viewModel:(APPlayerViewModel *)viewModel {
    if ([newValue isEqualToNumber:@(APPlayerViewModelStatusPause)]) {
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
    [self.playersContainer enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, BOOL * _Nonnull stop) {
        if (shouldCheckPlayInBackground) {
            if (![obj viewModel].enableBackground) {
                [[obj viewModel] pause];
            } else {
                [[obj viewModel] connectSignal:@signalSelector(statusChange)
                                   forObserver:self slot:@slotSelector(onEnterBackgroundPlayerStatusChangeWIthNewValue:oldValue:viewModel:)];
            }
        } else {
            [[obj viewModel] pause];
        }
    }];
}

- (void)playAll:(BOOL)shouldKeepLastStatus {
    [self.playersContainer enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, BOOL * _Nonnull stop) {
                [[obj viewModel] disconnectSignal:@signalSelector(statusChange) forObserver:self];
        if (!shouldKeepLastStatus) {
            [[obj viewModel] play];
        }
    }];
}
#pragma mark - Lazy Init



#pragma mark - Setup View
- (void)setupPlayerView {
    weakSelf(target);
    if (self.ddPlayerModel.layoutModel.playerCount == 0) {
        [self.ddPlayerModel.layoutModel setupWithPlayerCount:self.ddPlayerModel.liveURLs.count];
    }
    [NSAllMapTableKeys(self.ddPlayerModel.liveURLs) enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        
        APLiveURLModel *liveURL = [target.ddPlayerModel.liveURLs objectForKey:key];
        APPlayerViewModel *playerViewModel = [[APPlayerViewModel alloc] init];
        playerViewModel.liveURLModel = liveURL;
        APPlayerView *playerView = [[APPlayerView alloc] init];
        APVVMBindingContainer *container = [APVVMBindingContainer bindView:playerView withViewModel:playerViewModel];
        
        [playerView.controlView connectSignal:@signalSelector(didPressPlayPauseButton) forObserver:target slot:@slotSelector(onPressPlayPauseButtonWithView:viewModel:button:)];
        [playerView.controlView connectSignal:@signalSelector(didPressExitPlayerButton) forObserver:target slot:@slotSelector(onPressExitPlayerButtonWithView:viewModel:button:)];
        
        
        [target.playersContainer setObject:container forKey:key];
        Class processClass = liveURL.processorClass;
        if (processClass != nil) {
            APPlatformLiveURLProcessor *processor = [[processClass alloc] initWithLiveRoomURL:liveURL.liveURL];
            if (processor != nil) {
                liveURL.processor = processor;
                [processor requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error == nil) {
                            [playerViewModel setupPlayerWithPlayURLs:playURLs];
                            [playerView setupWithViewModel:playerViewModel];
                            [playerViewModel connectSignal:@signalSelector(statusChange) forObserver:target slot:@slotSelector(onPlayerStatusChangeWithNewValue:oldValue:viewModel:)];
                        }
                    });
                }];
            }
        }
    }];
}

- (void)addPlayerViews {
    weakSelf(target);
    [self.playersContainer enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, BOOL * _Nonnull stop) {
        [target.view addSubview:[obj view]];
    }];
}

- (void)layoutPlayerViews {
    weakSelf(target);
    [self.playersContainer enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, APVVMBindingContainer<APPlayerView *,APPlayerViewModel *> * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.view.frame = [target.ddPlayerModel.layoutModel playerFrameWithIndex:key.integerValue orientation:[target currentOrientation]];
    }];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPlayerView];
    [self addPlayerViews];
    [self bindData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutPlayerViews];
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

#pragma mark - Getter
- (UIInterfaceOrientation)currentOrientation {
    return [[UIApplication sharedApplication] statusBarOrientation];
}
@end
