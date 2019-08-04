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

- (void)bindData {
    
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
        v.controlView.isPlaying = viewModel.isPlaying;
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
    controlView.isPlaying = viewModel.isPlaying;
}

- (NS_SLOT)onPressExitPlayerButtonWithView:(APPlayerControlView *)view
                                 viewModel:(APPlayerViewModel *)viewModel
                                    button:(APButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
