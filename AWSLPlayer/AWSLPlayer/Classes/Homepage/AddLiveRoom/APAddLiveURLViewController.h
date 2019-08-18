//
//  APAddLiveURLViewController.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <NSObjectSignals/NSObject+SignalsSlots.h>
#import "APTableViewController.h"
#import "APViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class APLiveURLModel;
@interface APAddLiveURLViewController : APTableViewController

- (void)editModel:(APLiveURLModel *)model withModelKey:(NSString *)modelKey;

/// 完成添加直播间，无参数
NS_SIGNAL(didAddLiveURL);
@end

NS_ASSUME_NONNULL_END
