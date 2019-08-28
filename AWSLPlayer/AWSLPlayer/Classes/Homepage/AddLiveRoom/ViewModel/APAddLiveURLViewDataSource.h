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
#import "APLiveURLFolderModel.h"
NS_ASSUME_NONNULL_BEGIN

@signals APAddLiveURLViewDataSourceSignals
@optional
#pragma mark - Signals
- (void)didChangeLiveRoom;
@end

@interface APAddLiveURLViewDataSource : QMUIStaticTableViewCellDataSource<APAddLiveURLViewDataSourceSignals>
@property (nonatomic, strong) APLiveURLModel *liveRoom;
@property (nonatomic, copy) NSString *modelKey;
@end

NS_ASSUME_NONNULL_END
