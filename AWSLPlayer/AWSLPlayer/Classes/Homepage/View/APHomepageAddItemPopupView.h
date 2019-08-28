//
//  APHomepageAddItemPopupView.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import <NSObjectSignals/NSObjectSignals.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, APHomepageAddItemType) {
    APHomepageAddItemTypeDDPlayer,
    APHomepageAddItemTypeLiveURL,
};

@signals APHomepageAddItemPopupViewSignals
@optional
// 按下菜单某一项时触发，槽参数为@(APHomepageAddItemType)
- (void)didPressAddItem;
@end

@interface APHomepageAddItemPopupView : QMUIPopupMenuView<APHomepageAddItemPopupViewSignals>

@end

NS_ASSUME_NONNULL_END
