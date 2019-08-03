//
//  APHomepageAddItemPopupView.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import <NSObjectSignals/NSObject+SignalsSlots.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, APHomepageAddItemType) {
    APHomepageAddItemTypeLiveURL,
    APHomepageAddItemTypeDDPlayer,
    APHomepageAddItemTypeLiveURLFolder,
};

@interface APHomepageAddItemPopupView : QMUIPopupMenuView

// 按下菜单某一项时触发，槽参数为@(APHomepageAddItemType)
NS_SIGNAL(didPressAddItem);

@end

NS_ASSUME_NONNULL_END
