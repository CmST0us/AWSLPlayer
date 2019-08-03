//
//  APAddLiveURLViewDataSource.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APAddLiveURLViewDataSource.h"
#import "APTextFieldInputTableViewCell.h"
#import "APMacroHelper.h"
#import "APUserStorageHelper+Convinence.h"

@interface APAddLiveURLViewDataSource () <QMUITextFieldDelegate>
@property (nonatomic, weak) APTextFieldInputTableViewCell *nameCell;
@property (nonatomic, weak) APTextFieldInputTableViewCell *urlCell;

@property (nonatomic, copy) NSArray *folders;
@property (nonatomic, assign) NSUInteger currentSelectIndex;
@end

@implementation APAddLiveURLViewDataSource
NS_USE_SIGNAL(didChangeLiveRoom);

- (void)didInitialize {
    [super didInitialize];
    self.currentSelectFolderModel = [[APUserStorageHelper modelStorageContainer] defaultFolder];
    self.liveRoom = [[APLiveURLModel alloc] init];
    self.cellDataSections = [self cellData];
    self.folders = [[APUserStorageHelper modelStorageContainer].liveURLFolders allValues];
    self.currentSelectIndex = 0;
}


- (NSArray<NSArray<QMUIStaticTableViewCellData *> *> *)cellData {
    weakSelf(target);
    QMUIStaticTableViewCellData *nameCellData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:0 image:nil text:nil detailText:nil didSelectTarget:nil didSelectAction:nil accessoryType:QMUIStaticTableViewCellAccessoryTypeNone];
    nameCellData.height = 44;
    nameCellData.cellClass = [APTextFieldInputTableViewCell class];
    nameCellData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        if (![cell isKindOfClass:[APTextFieldInputTableViewCell class]]) {
            return;
        }
        APTextFieldInputTableViewCell *textInputCell = (APTextFieldInputTableViewCell *)cell;
        textInputCell.inputTitle = NSLocalizedString(@"ap_add_live_url_live_room_name", nil);
        textInputCell.inputTextField.delegate = target;
        [textInputCell.inputTextField addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        target.nameCell = cell;
        
    };
    
    QMUIStaticTableViewCellData *urlCellData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:1 image:nil text:nil detailText:nil didSelectTarget:nil didSelectAction:nil accessoryType:QMUIStaticTableViewCellAccessoryTypeNone];
    urlCellData.height = 44;
    urlCellData.cellClass = [APTextFieldInputTableViewCell class];
    urlCellData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        if (![cell isKindOfClass:[APTextFieldInputTableViewCell class]]) {
            return;
        }
        APTextFieldInputTableViewCell *textInputCell = (APTextFieldInputTableViewCell *)cell;
        textInputCell.inputTitle = NSLocalizedString(@"ap_add_live_url_live_room_url", nil);
        textInputCell.inputTextField.delegate = target;
        [textInputCell.inputTextField addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        target.urlCell = cell;
    };
    
    QMUIStaticTableViewCellData *urlYoutubeTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:2 image:nil text:NSLocalizedString(@"ap_youtube", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectYoutubeType:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlYoutubeTypeData.height = 44;
    urlYoutubeTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = target.liveRoom.urlType == APLiveURLTypeYoutube ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
    QMUIStaticTableViewCellData *urlBiliBiliTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:3 image:nil text:NSLocalizedString(@"ap_bilibili", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectBiliBili:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlBiliBiliTypeData.height = 44;
    urlBiliBiliTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = target.liveRoom.urlType == APLiveURLTypeBiliBili ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
    QMUIStaticTableViewCellData *urlLineLiveTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:4 image:nil text:NSLocalizedString(@"ap_linelive", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectLineLive:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlLineLiveTypeData.height = 44;
    urlLineLiveTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = target.liveRoom.urlType == APLiveURLTypeLineLive ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
    QMUIStaticTableViewCellData *urlNicoNicoTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:5 image:nil text:NSLocalizedString(@"ap_niconico", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectNicoNico:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlNicoNicoTypeData.height = 44;
    urlNicoNicoTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = target.liveRoom.urlType == APLiveURLTypeNicoNico ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
    QMUIStaticTableViewCellData *urlHibikiRadioTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:6 image:nil text:NSLocalizedString(@"ap_hibiki_radio", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectHibikiRadio:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlHibikiRadioTypeData.height = 44;
    urlHibikiRadioTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = target.liveRoom.urlType == APLiveURLTypeHibikiRadio ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
    QMUIStaticTableViewCellData *selectFolderData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:7 image:nil text:NSLocalizedString(@"ap_homepage_section_title_live_url_folder", nil) detailText:self.currentSelectFolderModel.name didSelectTarget:self didSelectAction:@selector(onPressSelectFolder:) accessoryType:QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator];
    selectFolderData.style = UITableViewCellStyleSubtitle;
    selectFolderData.height = 44;
    
    return @[
             @[
                 nameCellData,
                 urlCellData,
                 ],
             @[
                 urlYoutubeTypeData,
                 urlBiliBiliTypeData,
                 urlLineLiveTypeData,
                 urlHibikiRadioTypeData,
                 urlNicoNicoTypeData
                 ],
             @[
                 selectFolderData
                 ]
             ];
}

#pragma mark - Action
- (void)onPressSelectFolder:(QMUIStaticTableViewCellData *)data {
    weakSelf(target);
    QMUIDialogSelectionViewController *selectionVC = [[QMUIDialogSelectionViewController alloc] init];
    selectionVC.title = NSLocalizedString(@"ap_add_live_url_select_folder", nil);
    selectionVC.rowHeight = 44;
    selectionVC.selectedItemIndex = self.currentSelectIndex;

    NSArray<APLiveURLFolderModel *> *folderArray = self.folders;
    
    NSMutableArray *items = [NSMutableArray array];
    [folderArray enumerateObjectsUsingBlock:^(APLiveURLFolderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObject:obj.name];
    }];
    selectionVC.items = items;
    selectionVC.didSelectItemBlock = ^(__kindof QMUIDialogSelectionViewController * _Nonnull aDialogViewController, NSUInteger itemIndex) {
        target.currentSelectFolderModel = folderArray[itemIndex];
        target.currentSelectIndex = itemIndex;
    };
    [selectionVC addSubmitButtonWithText:NSLocalizedString(@"ap_submit", nil) block:^(__kindof QMUIDialogViewController * _Nonnull aDialogViewController) {
        [aDialogViewController hideWithAnimated:YES completion:nil];
        data.detailText = target.currentSelectFolderModel.name;
        [target.tableView reloadData];
    }];
    [selectionVC addCancelButtonWithText:NSLocalizedString(@"ap_cancel", nil) block:^(__kindof QMUIDialogViewController * _Nonnull aDialogViewController) {
        [aDialogViewController hideWithAnimated:YES completion:nil];
        [target.tableView reloadData];
    }];
    [selectionVC showWithAnimated:YES completion:nil];
}
- (void)textFieldDidChange:(QMUITextField *)textField {
    if (textField == self.nameCell.inputTextField) {
        self.liveRoom.name = textField.text;
        [self emitSignal:NS_SIGNAL_SELECTOR(didChangeLiveRoom) withParams:nil];
    } else if (textField == self.urlCell.inputTextField) {
        self.liveRoom.liveURL = [NSURL URLWithString:textField.text];
        [self emitSignal:NS_SIGNAL_SELECTOR(didChangeLiveRoom) withParams:nil];
    }
}
- (void)didSelectYoutubeType:(QMUIStaticTableViewCellData *)cellData {
    self.liveRoom.urlType = APLiveURLTypeYoutube;
    [self emitSignal:NS_SIGNAL_SELECTOR(didChangeLiveRoom) withParams:nil];
    [self.tableView reloadData];
}

- (void)didSelectBiliBili:(QMUIStaticTableViewCellData *)cellData {
    self.liveRoom.urlType = APLiveURLTypeBiliBili;
    [self emitSignal:NS_SIGNAL_SELECTOR(didChangeLiveRoom) withParams:nil];
    [self.tableView reloadData];
}

- (void)didSelectNicoNico:(QMUIStaticTableViewCellData *)cellData {
    self.liveRoom.urlType = APLiveURLTypeNicoNico;
    [self emitSignal:NS_SIGNAL_SELECTOR(didChangeLiveRoom) withParams:nil];
    [self.tableView reloadData];
}

- (void)didSelectLineLive:(QMUIStaticTableViewCellData *)cellData {
    self.liveRoom.urlType = APLiveURLTypeLineLive;
    [self emitSignal:NS_SIGNAL_SELECTOR(didChangeLiveRoom) withParams:nil];
    [self.tableView reloadData];
}

- (void)didSelectHibikiRadio:(QMUIStaticTableViewCellData *)cellData {
    self.liveRoom.urlType = APLiveURLTypeHibikiRadio;
    [self emitSignal:NS_SIGNAL_SELECTOR(didChangeLiveRoom) withParams:nil];
    [self.tableView reloadData];
}

#pragma mark - Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
