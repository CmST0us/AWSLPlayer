//
//  APAddLiveURLViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APAddLiveURLViewDataSource.h"
#import "APAddLiveURLViewController.h"
#import "APUserStorageHelper+Convinence.h"

@slots APAddLiveURLViewControllerSlots
@required
- (void)updateSaveBarButtonStatusWithCurrentInput;
@end

@interface APAddLiveURLViewController () <APAddLiveURLViewControllerSlots>
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

- (void)editModel:(APLiveURLModel *)model withModelKey:(nonnull NSString *)modelKey {
    self.dataSource.liveRoom = model;
    self.dataSource.modelKey = modelKey;
}

- (void)bindSignals {
    [self.dataSource connectSignal:@signalSelector(didChangeLiveRoom) forObserver:self slot:@slotSelector(updateSaveBarButtonStatusWithCurrentInput)];
}

- (BOOL)isInputVaild {
    APLiveURLModel *model = self.dataSource.liveRoom;
    if (model.name == nil || model.name.length == 0) {
        return NO;
    }
    if (model.liveURL == nil || model.liveURL.absoluteString.length == 0) {
        return NO;
    }
    if (model.urlType == APLiveURLTypeRaw) {
        return NO;
    }
    return YES;
}

#pragma mark - Slots
- (void)updateSaveBarButtonStatusWithCurrentInput {
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
    [[APUserStorageHelper modelStorageContainer] addLiveURL:self.dataSource.liveRoom forKey:self.dataSource.modelKey];
    [self emitSignal:@signalSelector(didAddLiveURL) withParams:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
