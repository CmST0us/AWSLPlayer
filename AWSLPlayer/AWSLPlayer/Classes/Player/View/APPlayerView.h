//
//  APPlayerView.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APView.h"

NS_ASSUME_NONNULL_BEGIN

@class APPlayerViewModel;
@class APPlayerDisplayView;
@class APPlayerControlView;
@interface APPlayerView : APView
@property (nonatomic, strong) APPlayerDisplayView *displayView;
@property (nonatomic, strong) APPlayerControlView *controlView;

- (Class)displayViewClass;
- (Class)controlViewClass;

- (void)setupWithViewModel:(APPlayerViewModel *)model;

@end

NS_ASSUME_NONNULL_END
