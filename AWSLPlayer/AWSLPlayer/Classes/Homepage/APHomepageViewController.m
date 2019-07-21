//
//  APHomepageViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/20.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APHomepageAddItemPopupView.h"
#import "APHomepageViewController.h"
#import "APAddLiveURLViewController.h"
#import "APUserDefaultHelper.h"
#import "APNavigationController.h"

@interface APHomepageViewController ()
@property (nonatomic, strong) UIBarButtonItem *addItemBarButtonItem;
@property (nonatomic, strong) APHomepageAddItemPopupView *popupView;
@end

@implementation APHomepageViewController

- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:style];
    self.title = NSLocalizedString(@"ap_homepage_title", @"DD播放器");
    
    self.addItemBarButtonItem = [UIBarButtonItem qmui_itemWithSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(navigationBarAddButtonAction:)];
    self.navigationItem.rightBarButtonItem = self.addItemBarButtonItem;
    
    self.popupView = [[APHomepageAddItemPopupView alloc] init];
    self.popupView.sourceBarItem = self.addItemBarButtonItem;
    
    [self bindSignal];
}

- (void)bindSignal {
    [self.popupView connectSignal:NS_SIGNAL_SELECTOR(didPressAddItem) forObserver:self slot:NS_SLOT_SELECTOR(popupViewDidPressAddItem:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

#pragma mark - Action
- (void)navigationBarAddButtonAction:(id)sender {
    [self.popupView showWithAnimated:YES];
}

#pragma mark - Slot
- (NS_SLOT)popupViewDidPressAddItem:(NSNumber *)itemType {
    if (itemType.unsignedIntegerValue == APHomepageAddItemTypeLiveURL) {
        APAddLiveURLViewController *vc = [[APAddLiveURLViewController alloc] initWithStyle:UITableViewStyleGrouped];
        APNavigationController *nav = [[APNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
}

@end
