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

@interface APAddLiveURLViewDataSource () <QMUITextFieldDelegate>
@property (nonatomic, weak) APTextFieldInputTableViewCell *nameCell;
@property (nonatomic, weak) APTextFieldInputTableViewCell *urlCell;
@end

@implementation APAddLiveURLViewDataSource
NS_USE_SIGNAL(didChangeLiveRoom);

- (void)didInitialize {
    [super didInitialize];
    self.liveRoom = [[APLiveURLModel alloc] init];
    self.cellDataSections = [self cellData];
}


- (NSArray<NSArray<QMUIStaticTableViewCellData *> *> *)cellData {
    weakSelf(self);
    QMUIStaticTableViewCellData *nameCellData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:0 image:nil text:nil detailText:nil didSelectTarget:nil didSelectAction:nil accessoryType:QMUIStaticTableViewCellAccessoryTypeNone];
    nameCellData.height = 44;
    nameCellData.cellClass = [APTextFieldInputTableViewCell class];
    nameCellData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        if (![cell isKindOfClass:[APTextFieldInputTableViewCell class]]) {
            return;
        }
        APTextFieldInputTableViewCell *textInputCell = (APTextFieldInputTableViewCell *)cell;
        textInputCell.inputTitle = NSLocalizedString(@"ap_add_live_url_live_room_name", nil);
        textInputCell.inputTextField.delegate = weakSelf;
        [textInputCell.inputTextField addTarget:weakSelf action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        weakSelf.nameCell = cell;
        
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
        textInputCell.inputTextField.delegate = weakSelf;
        [textInputCell.inputTextField addTarget:weakSelf action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        weakSelf.urlCell = cell;
    };
    
    QMUIStaticTableViewCellData *urlYoutubeTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:2 image:nil text:NSLocalizedString(@"ap_youtube", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectYoutubeType:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlYoutubeTypeData.height = 44;
    urlYoutubeTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = weakSelf.liveRoom.urlType == APLiveURLTypeYoutube ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
    QMUIStaticTableViewCellData *urlBiliBiliTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:3 image:nil text:NSLocalizedString(@"ap_bilibili", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectBiliBili:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlBiliBiliTypeData.height = 44;
    urlBiliBiliTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = weakSelf.liveRoom.urlType == APLiveURLTypeBiliBili ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
    QMUIStaticTableViewCellData *urlLineLiveTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:4 image:nil text:NSLocalizedString(@"ap_linelive", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectLineLive:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlLineLiveTypeData.height = 44;
    urlLineLiveTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = weakSelf.liveRoom.urlType == APLiveURLTypeLineLive ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
    QMUIStaticTableViewCellData *urlNicoNicoTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:5 image:nil text:NSLocalizedString(@"ap_niconico", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectNicoNico:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlNicoNicoTypeData.height = 44;
    urlNicoNicoTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = weakSelf.liveRoom.urlType == APLiveURLTypeNicoNico ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
    QMUIStaticTableViewCellData *urlHibikiRadioTypeData = [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:6 image:nil text:NSLocalizedString(@"ap_hibiki_radio", nil) detailText:nil didSelectTarget:self didSelectAction:@selector(didSelectHibikiRadio:) accessoryType:QMUIStaticTableViewCellAccessoryTypeCheckmark];
    urlHibikiRadioTypeData.height = 44;
    urlHibikiRadioTypeData.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
        cell.accessoryType = weakSelf.liveRoom.urlType == APLiveURLTypeHibikiRadio ? QMUIStaticTableViewCellAccessoryTypeCheckmark : QMUIStaticTableViewCellAccessoryTypeNone;
    };
    
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
             ];
}

#pragma mark - Action
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
