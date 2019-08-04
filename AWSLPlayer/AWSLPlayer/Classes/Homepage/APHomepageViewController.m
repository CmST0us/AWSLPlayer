//
//  APHomepageViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/20.
//  Copyright © 2019 eric3u. All rights reserved.
//


#import "APHomepageViewController.h"
#import "APAddLiveURLViewController.h"
#import "APNavigationController.h"
#import "APPlayerViewController.h"

#import "APHomepageAddItemPopupView.h"

#import "APMacroHelper.h"
#import "APHomepageDataSource.h"

@interface APHomepageViewController () <QMUITableViewDelegate>
@property (nonatomic, strong) UIBarButtonItem *addItemBarButtonItem;
@property (nonatomic, strong) APHomepageAddItemPopupView *popupView;

@property (nonatomic, strong) APHomepageDataSource *dataSource;
@end

@implementation APHomepageViewController

- (APHomepageDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[APHomepageDataSource alloc] init];
    }
    return _dataSource;
}

- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:style];
    self.title = NSLocalizedString(@"ap_homepage_title", @"DD播放器");
    
    self.addItemBarButtonItem = [UIBarButtonItem qmui_itemWithSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(navigationBarAddButtonAction:)];
    self.navigationItem.rightBarButtonItem = self.addItemBarButtonItem;
    
    self.popupView = [[APHomepageAddItemPopupView alloc] init];
    self.popupView.sourceBarItem = self.addItemBarButtonItem;
    
    [self.tableView registerClass:[QMUITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self bindSignal];
}

- (void)bindSignal {
    [self.popupView connectSignal:NS_SIGNAL_SELECTOR(didPressAddItem) forObserver:self slot:NS_SLOT_SELECTOR(popupViewDidPressAddItem:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadAllData];
}

- (void)reloadAllData {
    [self.tableView reloadData];
}

- (void)createNewLiveURLFolderWithName:(NSString *)name {
    APLiveURLFolderModel *model = [[APLiveURLFolderModel alloc] init];
    model.name = name;
    [self.dataSource addLiveURLFolders:model];
    [self reloadAllData];
}

- (void)gotoAddLiveURLViewController {
    APAddLiveURLViewController *vc = [[APAddLiveURLViewController alloc] initWithStyle:UITableViewStyleGrouped];
    APNavigationController *nav = [[APNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showAddURLFolderDialog {
    weakSelf(target);
    QMUIDialogTextFieldViewController *addLiveURLFolderDiglog = [[QMUIDialogTextFieldViewController alloc] init];
    addLiveURLFolderDiglog.title = NSLocalizedString(@"ap_add_live_url_folder_title", nil);
    addLiveURLFolderDiglog.shouldManageTextFieldsReturnEventAutomatically = YES;
    addLiveURLFolderDiglog.enablesSubmitButtonAutomatically = YES;
    [addLiveURLFolderDiglog addTextFieldWithTitle:NSLocalizedString(@"ap_add_live_url_folder_name", nil) configurationHandler:nil];
    [addLiveURLFolderDiglog addCancelButtonWithText:NSLocalizedString(@"ap_cancel", nil) block:^(__kindof QMUIDialogViewController * _Nonnull aDialogViewController) {
        [aDialogViewController hideWithAnimated:YES completion:nil];
    }];
    [addLiveURLFolderDiglog addSubmitButtonWithText:NSLocalizedString(@"ap_submit", nil) block:^(__kindof QMUIDialogViewController * _Nonnull aDialogViewController) {
        QMUIDialogTextFieldViewController *textDialog = (QMUIDialogTextFieldViewController *)aDialogViewController;
        [target createNewLiveURLFolderWithName:textDialog.textFields[0].text];
        [aDialogViewController hideWithAnimated:YES completion:nil];
        [target reloadAllData];
    }];
    [addLiveURLFolderDiglog showWithAnimated:YES completion:nil];
}

#pragma mark - Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TableViewCellNormalHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QMUILabel *label = [[QMUILabel alloc] init];
    label.text = [self.dataSource titleForSection:section];
    label.textColor = UIColorGray;
    label.contentEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 0);
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell = (QMUITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == APHomepageDataSourceSectionTypeLiveURL) {
        cell.textLabel.text = self.dataSource.liveURLs[indexPath.row].name;
    } else if (indexPath.section == APHomepageDataSourceSectionTypeFolder) {
        cell.textLabel.text = self.dataSource.liveURLFolders[indexPath.row].name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == APHomepageDataSourceSectionTypeLiveURL) {
        APDDPlayerModel *ddPlayer = [[APDDPlayerModel alloc] init];
        ddPlayer.liveURLs = @{
            @(1): self.dataSource.liveURLs[indexPath.row]
        };
        APPlayerViewController *vc = [[APPlayerViewController alloc] initWithDDPlayerModel:ddPlayer];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowInSection:section];
}

#pragma mark - Action
- (void)navigationBarAddButtonAction:(id)sender {
    [self.popupView showWithAnimated:YES];
}

#pragma mark - Slot
- (NS_SLOT)popupViewDidPressAddItem:(NSNumber *)itemType {
    if (itemType.unsignedIntegerValue == APHomepageAddItemTypeLiveURL) {
        [self gotoAddLiveURLViewController];
    } else if (itemType.unsignedIntegerValue == APHomepageAddItemTypeLiveURLFolder) {
        [self showAddURLFolderDialog];
    }
}

@end
