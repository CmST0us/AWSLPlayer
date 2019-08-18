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
@interface APAddDDPlayerViewController : APTableViewController

- (void)editModel:(APDDPlayerModel *)model withModelKey:(NSString *)modelKey;

/// 保存时触发，无参数
NS_SIGNAL(didAddDDPlayer);

@end

NS_ASSUME_NONNULL_END
