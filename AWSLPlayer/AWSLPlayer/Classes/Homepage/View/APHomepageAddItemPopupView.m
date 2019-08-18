//
//  APHomepageAddItemPopupView.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APHomepageAddItemPopupView.h"
#import "APMacroHelper.h"

@implementation APHomepageAddItemPopupView
NS_CLOSE_SIGNAL_WARN(didPressAddItem)

- (void)didInitialize {
    [super didInitialize];
    // 点击空白处关闭
    self.shouldShowItemSeparator = YES;
    self.automaticallyHidesWhenUserTap = YES;
    self.maskViewBackgroundColor = [UIColor clearColor];
    
    [self setupItems];
}

- (void)setupItems {
    weakSelf(target);
    QMUIOrderedDictionary *itemsTitle = [self itemsTitleAndAction];
    NSMutableArray *items = [NSMutableArray array];
    [itemsTitle.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *selector = [itemsTitle objectForKey:obj];
        QMUIPopupMenuButtonItem *item = [QMUIPopupMenuButtonItem itemWithImage:nil title:obj handler:^(QMUIPopupMenuButtonItem * _Nonnull aItem) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:NSSelectorFromString(selector) withObject:aItem];
#pragma clang diagnostic pop
            [target hideWithAnimated:YES];
        }];
        [items addObject:item];
    }];
    self.items = items;
}

#pragma mark - Action
- (void)addLiveURL:(QMUIPopupMenuButtonItem *)item {
    [self emitSignal:NS_SIGNAL_SELECTOR(didPressAddItem) withParams:@[@(APHomepageAddItemTypeLiveURL)]];
}

- (void)addDDPlayer:(QMUIPopupMenuButtonItem *)item {
    [self emitSignal:NS_SIGNAL_SELECTOR(didPressAddItem) withParams:@[@(APHomepageAddItemTypeDDPlayer)]];
}


#pragma mark - Data Source
- (QMUIOrderedDictionary<NSString *, NSString *> *)itemsTitleAndAction {
    static NSArray *titles = nil;
    static NSArray *selectors = nil;
    if (titles == nil || selectors == nil) {
        titles = @[
                    NSLocalizedString(@"ap_homepage_add_button_title_dd_player", @"DD 播放器"),
                    NSLocalizedString(@"ap_homepage_add_button_title_live_url", @"直播间地址"),
                   ];
        
        selectors = @[
                      NSStringFromSelector(@selector(addDDPlayer:)),
                      NSStringFromSelector(@selector(addLiveURL:)),
                      ];
    }
    QMUIOrderedDictionary *dict = [[QMUIOrderedDictionary alloc] init];
    [dict addObjects:selectors forKeys:titles];
    return dict;
}

@end
