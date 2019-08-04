//
//  APPlayerViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "APVVMBindingContainer.h"
#import "APDDPlayerModel.h"
#import "APLiveURLModel.h"

#import "APYoutubeLive.h"

#import "APPlayerViewModel.h"
#import "APPlayerViewController.h"
#import "APPlayerView.h"

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
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    [super didInitialize];
    
    [self setupPlayerView];
    [self addSubviews];
    [self setupConstraints];
}


#pragma mark - Lazy Init


#pragma mark - Setup View
- (void)setupPlayerView {
    APLiveURLModel *liveURL = [self.ddPlayerModel.liveURLs allValues][0];
    APPlayerView *playerView = [[APPlayerView alloc] init];
    APPlayerViewModel *playerViewModel = [[APPlayerViewModel alloc] init];
    APVVMBindingContainer *container = [APVVMBindingContainer bindView:playerView withViewModel:playerViewModel];
    [self.playersContainer addObject:container];
    if (liveURL.urlType == APLiveURLTypeYoutube) {
        APYoutubeLive *youtubeLive = [[APYoutubeLive alloc] initWithLiveRoomURL:liveURL.liveURL];
        [youtubeLive requestPlayURLWithCompletion:^(NSDictionary * _Nullable playURLs, NSError * _Nullable error) {
            
        }];
    }
}

- (void)addSubviews {
    
}

- (void)setupConstraints {
    
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
