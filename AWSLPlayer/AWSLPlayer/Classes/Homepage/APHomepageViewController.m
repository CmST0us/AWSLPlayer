//
//  APHomepageViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/20.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APHomepageAddItemPopupView.h"
#import "APHomepageViewController.h"

@interface APHomepageViewController ()
@property (nonatomic, strong) UIBarButtonItem *addItemBarButtonItem;
@property (nonatomic, strong) APHomepageAddItemPopupView *popupView;
@end

@implementation APHomepageViewController

- (void)didInitialize {
    [super didInitialize];
    self.title = NSLocalizedString(@"ap_homepage_title", @"DD播放器");
    
    self.addItemBarButtonItem = [UIBarButtonItem qmui_itemWithSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(navigationBarAddButtonAction:)];
    self.navigationItem.rightBarButtonItem = self.addItemBarButtonItem;
    
    self.popupView = [[APHomepageAddItemPopupView alloc] init];
    self.popupView.sourceBarItem = self.addItemBarButtonItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Action
- (void)navigationBarAddButtonAction:(id)sender {
    [self.popupView showWithAnimated:YES];
}
@end
