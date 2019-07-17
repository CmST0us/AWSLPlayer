//
//  APAVPlayerView.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <NSObjectSignals/NSObject+SignalsSlots.h>
#import "APView.h"

NS_ASSUME_NONNULL_BEGIN

@interface APAVPlayerView : APView
@property (nonatomic, copy) NSURL *playURL;

NS_SIGNAL(playerStatusChange);

@end

NS_ASSUME_NONNULL_END
