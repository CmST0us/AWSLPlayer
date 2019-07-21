//
//  APAddLiveURLViewDataSource.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import <NSObjectSignals/NSObject+SignalsSlots.h>
#import "APLiveURLModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface APAddLiveURLViewDataSource : QMUIStaticTableViewCellDataSource
@property (nonatomic, strong) APLiveURLModel *liveRoom;

#pragma mark - Signals
NS_SIGNAL(didChangeLiveRoom);

@end

NS_ASSUME_NONNULL_END
