//
//  APAddDDPlayerViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/17.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APTextFieldInputTableViewCell.h"
#import "APDDPlayerModel.h"
#import "APLiveURLModel.h"
#import "APDDPlayerLayoutModel.h"
#import "APAddDDPlayerDataSource.h"
#import "APAddDDPlayerViewController.h"
#import <NSObjectSignals/NSObject+SignalsSlots.h>

static NSString *const APAddDDPlayerViewControllerInputCellIdentifier = @"input_cell";
static NSString *const APAddDDPlayerViewControllerSelectedLiveRoomCellIdentifier = @"selected_live_room_cell";
static NSString *const APAddDDPlayerViewControllerSelectLiveRoomCellIdentifier = @"select_live_room_cell";

@interface APAddDDPlayerViewController ()<QMUITextFieldDelegate>
@property (nonatomic, strong) APAddDDPlayerDataSource *dataSource;
@property (nonatomic, strong) NSMutableIndexSet *selectedIndexSet;

@property (nonatomic, strong) UIBarButtonItem *saveBarButton;
@property (nonatomic, weak) QMUITextField *inputNameTextField;
@end

@implementation APAddDDPlayerViewController

#pragma mark - Init
- (void)didInitialize {
    [super didInitialize];
}

- (void)setupSaveButton {
    self.saveBarButton = [UIBarButtonItem qmui_itemWithSystemItem:UIBarButtonSystemItemSave target:self action:@selector(handleNavigationBarSaveButtonAction:)];
    self.saveBarButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.saveBarButton;
}

- (void)setupCancelButton {
    UIBarButtonItem *cancel = [UIBarButtonItem qmui_itemWithSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancel;
}

#pragma mark - Lazy
- (APAddDDPlayerDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[APAddDDPlayerDataSource alloc] init];
    }
    return _dataSource;
}

- (NSMutableIndexSet *)selectedIndexSet {
    if (_selectedIndexSet == nil) {
        _selectedIndexSet = [[NSMutableIndexSet alloc] init];
    }
    return _selectedIndexSet;
}


#pragma mark - Getter Setter

#pragma mark - Private
- (void)onInputValueChange {
    self.saveBarButton.enabled = [self checkInputVaild];
}

- (BOOL)checkInputVaild {
    BOOL vaild = NO;
    if (self.dataSource.ddPlayerModel.name != nil &&
        self.dataSource.ddPlayerModel.name.length > 0) {
        vaild = YES;
    } else {
        vaild = NO;
    }
    
    if (self.dataSource.selectedLiveRoom != nil &&
        self.dataSource.selectedLiveRoom.count > 0) {
        vaild = YES;
    } else {
        vaild = NO;
    }
    

    return vaild;
}

#pragma mark - Method
- (void)editModel:(APDDPlayerModel *)model withModelKey:(nonnull NSString *)modelKey {
    [self.dataSource editModel:model withModelKey:modelKey];
}

#pragma mark - Slot

#pragma mark - Action
- (void)handleSelectLiveRoomTableViewCellSelect {
    __weak typeof(self) weakSelf = self;
    QMUIDialogSelectionViewController *selectionVC = [[QMUIDialogSelectionViewController alloc] init];
    selectionVC.title = NSLocalizedString(@"ap_add_dd_player_select_live_url_button_title", nil);
    selectionVC.rowHeight = 44;
    selectionVC.allowsMultipleSelection = YES;
    
    NSMutableArray *item = [[NSMutableArray alloc] initWithCapacity:self.dataSource.allLiveRoom.count];
    [self.dataSource.allLiveRoom enumerateObjectsUsingBlock:^(APLiveURLModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [item addObject:obj.name];
    }];
    selectionVC.items= item;
    NSMutableSet *sets = [NSMutableSet set];
    [self.dataSource.selectedIndex enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [sets addObject:@(idx)];
    }];
    selectionVC.selectedItemIndexes = sets;
    
    [selectionVC addCancelButtonWithText:NSLocalizedString(@"ap_cancel", nil) block:^(__kindof QMUIDialogViewController * _Nonnull aDialogViewController) {
        [aDialogViewController hideWithAnimated:YES completion:nil];
    }];
    
    __weak typeof(selectionVC) weakSelectVC = selectionVC;
    selectionVC.canSelectItemBlock = ^BOOL(__kindof QMUIDialogSelectionViewController * _Nonnull aDialogViewController, NSUInteger itemIndex) {
        QMUIDialogSelectionViewController *v = (QMUIDialogSelectionViewController *)aDialogViewController;
        if ([v.selectedItemIndexes containsObject:@(itemIndex)]) return YES;
        
        if (v.selectedItemIndexes.count >= [APDDPlayerLayoutModel maxPlayerCount]) {
            [QMUITips showWithText:NSLocalizedString(@"ap_add_dd_player_bigger_than_max_count", nil) inView:weakSelectVC.tableView hideAfterDelay:1];
            return NO;
        }
        return YES;
    };
    
    [selectionVC addSubmitButtonWithText:NSLocalizedString(@"ap_submit", nil) block:^(__kindof QMUIDialogViewController * _Nonnull aDialogViewController) {
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
        QMUIDialogSelectionViewController *v = (QMUIDialogSelectionViewController *)aDialogViewController;
        [v.selectedItemIndexes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
            [indexSet addIndex:obj.integerValue];
        }];
        [weakSelf.dataSource useLiveURLsWithIndexs:indexSet];
        
        [weakSelf.tableView reloadData];
        [self onInputValueChange];
        [aDialogViewController hideWithAnimated:YES completion:nil];
    }];
     
    [selectionVC showWithAnimated:YES completion:nil];
}

- (void)handleNavigationBarSaveButtonAction:(id)sender {
    [self.dataSource save];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"ap_add_dd_player_title", nil);
    [self setupSaveButton];
    [self setupCancelButton];
    [self.tableView registerClass:[APTextFieldInputTableViewCell class] forCellReuseIdentifier:APAddDDPlayerViewControllerInputCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:APAddDDPlayerViewControllerSelectedLiveRoomCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:APAddDDPlayerViewControllerSelectLiveRoomCellIdentifier];
}

#pragma mark - Table View Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *rawCell = nil;
    if (indexPath.section == APAddDDPlayerSectionName) {
        APTextFieldInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:APAddDDPlayerViewControllerInputCellIdentifier];
        if (cell == nil) {
            cell = [[APTextFieldInputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:APAddDDPlayerViewControllerInputCellIdentifier];
        }
        cell.inputTitleLabel.text = NSLocalizedString(@"ap_add_dd_player_player_name", nil);
        cell.inputTextField.delegate = self;
        cell.inputText = self.dataSource.name;
        [cell.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.inputNameTextField = cell.inputTextField;
        rawCell = cell;
    } else if (indexPath.section == APAddDDPlayerSectionSelected) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:APAddDDPlayerViewControllerSelectedLiveRoomCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:APAddDDPlayerViewControllerSelectedLiveRoomCellIdentifier];
        }
        cell.textLabel.text = self.dataSource.selectedLiveRoom[indexPath.row].name;
        rawCell = cell;
    } else if (indexPath.section == APAddDDPlayerSectionSelectButton) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:APAddDDPlayerViewControllerSelectLiveRoomCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:APAddDDPlayerViewControllerSelectLiveRoomCellIdentifier];
        }
        cell.textLabel.text = NSLocalizedString(@"ap_add_dd_player_select_live_url_button_title", nil);
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        cell.textLabel.textColor = UIColorBlue;
        rawCell = cell;
    }
    return rawCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataSource.sectionTitles[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == APAddDDPlayerSectionSelectButton) {
        [self handleSelectLiveRoomTableViewCellSelect];
    }
}


#pragma mark - Text Field Delegate
- (void)textFieldDidChange:(QMUITextField *)textField {
    if (textField != self.inputNameTextField) return;
    
    self.dataSource.name = textField.text;
    [self onInputValueChange];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
