//
//  APPlayerView.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APView.h"

NS_ASSUME_NONNULL_BEGIN

@interface APPlayerView : APView
@property (nonatomic, strong) APView *displayView;
@property (nonatomic, strong) APView *controlView;

- (Class)displayViewClass;
- (Class)controlViewClass;

@end

NS_ASSUME_NONNULL_END
