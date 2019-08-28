//
//  APAVPlayerView.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <NSObjectSignals/NSObjectSignals.h>
#import "APView.h"

NS_ASSUME_NONNULL_BEGIN

@signals APAVPlayerViewSignals
@optional
- (void)playerStatusChange;
@end

@interface APAVPlayerView : APView<APAVPlayerViewSignals>
@property (nonatomic, copy) NSURL *playURL;

@end

NS_ASSUME_NONNULL_END
