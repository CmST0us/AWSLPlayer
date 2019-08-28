//
//  APAddDDPlayerViewController.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/17.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <NSObjectSignals/NSObject+SignalsSlots.h>
#import "APTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class APDDPlayerModel;

@signals APAddDDPlayerViewControllerSignals
@optional
/// 保存时触发，无参数
- (void)didAddDDPlayer;
@end

@interface APAddDDPlayerViewController : APTableViewController<APAddDDPlayerViewControllerSignals>

- (void)editModel:(APDDPlayerModel *)model withModelKey:(NSString *)modelKey;

@end

NS_ASSUME_NONNULL_END
