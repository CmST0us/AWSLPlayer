//
//  APPlayerViewController.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <NSObjectSignals/NSObject+SignalsSlots.h>
#import "APViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class APDDPlayerModel;
@interface APPlayerViewController : APViewController

- (instancetype)initWithDDPlayerModel:(APDDPlayerModel *)model;

#pragma mark - Signals


@end

NS_ASSUME_NONNULL_END
