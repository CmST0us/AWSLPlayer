//
//  APAddLiveURLViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APAddLiveURLViewDataSource.h"
#import "APAddLiveURLViewController.h"
#import "APUserDefaultHelper.h"

@interface APAddLiveURLViewController ()
@property (nonatomic, strong) APAddLiveURLViewDataSource *dataSource;
@property (nonatomic, strong) UIBarButtonItem *saveBarButton;
@end

@implementation APAddLiveURLViewController

- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:style];
    
    self.saveBarButton = [UIBarButtonItem qmui_itemWithSystemItem:UIBarButtonSystemItemSave target:self action:@selector(navigationBarSaveButtonAction:)];
    self.saveBarButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.saveBarButton;
    
    UIBarButtonItem *cancel = [UIBarButtonItem qmui_itemWithSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    self.title = NSLocalizedString(@"ap_add_live_url_title", @"添加直播间");
    self.dataSource = [[APAddLiveURLViewDataSource alloc] init];
    self.tableView.qmui_staticCellDataSource = self.dataSource;
    
    [self bindSignals];
}

- (void)bindSignals {
    [self.dataSource connectSignal:NS_SIGNAL_SELECTOR(didChangeLiveRoom) forObserver:self slot:NS_SLOT_SELECTOR(updateSaveBarButtonStatusWithCurrentInput)];
}

- (BOOL)isInputVaild {
    APLiveURLModel *model = self.dataSource.liveRoom;
    if (model.name == nil || model.name.length == 0) {
        return NO;
    }
    if (model.liveURL == nil || model.liveURL.absoluteString.length == 0) {
        return NO;
    }
    if (model.liveURL == APLiveURLTypeRaw) {
        return NO;
    }
    return YES;
}

#pragma mark - Slots
- (NS_SLOT)updateSaveBarButtonStatusWithCurrentInput {
    if ([self isInputVaild]) {
        self.saveBarButton.enabled = YES;
    } else {
        self.saveBarButton.enabled = NO;
    }
}

#pragma mark - Action
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationBarSaveButtonAction:(id)sender {
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:self.dataSource.liveRoom];
    NSArray *savedArray = [[APUserDefaultHelper sharedInstance] objectForKey:[APLiveURLModelsKey copy]];
    NSMutableArray *mutableArray = [NSMutableArray array];
    if (savedArray == nil) {
        mutableArray = [[NSMutableArray alloc] initWithObjects:archivedData, nil];
    } else {
        [mutableArray addObjectsFromArray:savedArray];
        [mutableArray addObject:archivedData];
    }
    [[APUserDefaultHelper sharedInstance] setObject:mutableArray forKey:[APLiveURLModelsKey copy]];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end