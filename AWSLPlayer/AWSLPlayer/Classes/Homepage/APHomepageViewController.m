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
#import "APAddDDPlayerViewController.h"

#import "APHomepageAddItemPopupView.h"

#import "APMacroHelper.h"
#import "APHomepageDataSource.h"

static NSString * const APHomepageViewControllerNormalCell = @"cell";

typedef NS_ENUM(NSUInteger, APHomepageViewControllerStatus) {
    APHomepageViewControllerStatusNormal,
    APHomepageViewControllerStatusEdit,
};

@interface APHomepageViewController () <QMUITableViewDelegate>
@property (nonatomic, assign) APHomepageViewControllerStatus status;

@property (nonatomic, strong) UIBarButtonItem *addItemBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *editBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *doneBarButtonItem;

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
    
    self.editBarButtonItem = [UIBarButtonItem qmui_itemWithSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(handleNavigationBarEditButtonAction:)];
    
    self.doneBarButtonItem = [UIBarButtonItem qmui_itemWithSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleNavigationBarDoneButtonAction:)];
    
    self.status = APHomepageViewControllerStatusNormal;
    
    self.popupView = [[APHomepageAddItemPopupView alloc] init];
    self.popupView.sourceBarItem = self.addItemBarButtonItem;
    
    [self.tableView registerClass:[QMUITableViewCell class] forCellReuseIdentifier:APHomepageViewControllerNormalCell];
    [self bindSignal];
}

- (void)bindSignal {
    [self.popupView connectSignal:NS_SIGNAL_SELECTOR(didPressAddItem) forObserver:self slot:NS_SLOT_SELECTOR(popupViewDidPressAddItem:)];
}

- (void)setStatus:(APHomepageViewControllerStatus)status {
    _status = status;
    if (_status == APHomepageViewControllerStatusEdit) {
        [self.navigationItem setLeftBarButtonItem:self.doneBarButtonItem animated:YES];
        [self.tableView setEditing:NO animated:YES];
        [self.tableView setEditing:YES animated:YES];
    } else if (_status == APHomepageViewControllerStatusNormal) {
        [self.navigationItem setLeftBarButtonItem:self.editBarButtonItem animated:YES];
        [self.tableView setEditing:NO animated:YES];
    }
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
    nav.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)gotoAddDDPlayerViewController {
    APAddDDPlayerViewController *vc = [[APAddDDPlayerViewController alloc] initWithStyle:UITableViewStyleGrouped];
    APNavigationController *nav = [[APNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationPageSheet;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell = (QMUITableViewCell *)[tableView dequeueReusableCellWithIdentifier:APHomepageViewControllerNormalCell];
    if (cell == nil) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:APHomepageViewControllerNormalCell];
    }
    if (indexPath.section == APHomepageDataSourceSectionTypeLiveURL) {
        cell.textLabel.text = self.dataSource.liveURLs[indexPath.row].name;
    } else if (indexPath.section == APHomepageDataSourceSectionTypeFolder) {
        cell.textLabel.text = self.dataSource.liveURLFolders[indexPath.row].name;
    } else if (indexPath.section == APHomepageDataSourceSectionTypeDDPlayer) {
        cell.textLabel.text = self.dataSource.players[indexPath.row].name;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == APHomepageDataSourceSectionTypeDDPlayer) {
        APDDPlayerModel *model = self.dataSource.players[indexPath.row];
        APAddDDPlayerViewController *v = [[APAddDDPlayerViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [v editModel:model];
        APNavigationController *nav = [[APNavigationController alloc] initWithRootViewController:v];
        nav.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:nav animated:YES completion:nil];
    } else if (indexPath.section == APHomepageDataSourceSectionTypeLiveURL) {
        APLiveURLModel *selectLiveRoom = self.dataSource.liveURLs[indexPath.row];
        APAddLiveURLViewController *v = [[APAddLiveURLViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [v editModel:selectLiveRoom];
        APNavigationController *nav = [[APNavigationController alloc] initWithRootViewController:v];
        nav.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataSource titleForSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == APHomepageDataSourceSectionTypeLiveURL) {
        APDDPlayerModel *ddPlayer = [[APDDPlayerModel alloc] init];
        ddPlayer.liveURLs = @{
            @(0): self.dataSource.liveURLs[indexPath.row]
        };
        APPlayerViewController *vc = [[APPlayerViewController alloc] initWithDDPlayerModel:ddPlayer];
        [self presentViewController:vc animated:YES completion:nil];
    } else if (indexPath.section == APHomepageDataSourceSectionTypeDDPlayer) {
        APDDPlayerModel *model = self.dataSource.players[indexPath.row];
        APPlayerViewController *vc = [[APPlayerViewController alloc] initWithDDPlayerModel:model];
        [self presentViewController:vc animated:YES completion:nil];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowInSection:section];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle & UITableViewCellEditingStyleDelete) {
        if (indexPath.section == APHomepageDataSourceSectionTypeDDPlayer) {
            
        } else if (indexPath.section == APHomepageDataSourceSectionTypeLiveURL) {
            
        }
    }
}

#pragma mark - Action
- (void)navigationBarAddButtonAction:(id)sender {
    [self.popupView showWithAnimated:YES];
}

- (void)handleNavigationBarEditButtonAction:(id)sender {
    self.status = APHomepageViewControllerStatusEdit;
}

- (void)handleNavigationBarDoneButtonAction:(id)sender {
    self.status = APHomepageViewControllerStatusNormal;
}

#pragma mark - Slot
- (NS_SLOT)popupViewDidPressAddItem:(NSNumber *)itemType {
    if (itemType.unsignedIntegerValue == APHomepageAddItemTypeLiveURL) {
        [self gotoAddLiveURLViewController];
    } else if (itemType.unsignedIntegerValue == APHomepageAddItemTypeLiveURLFolder) {
        [self showAddURLFolderDialog];
    } else if (itemType.unsignedIntegerValue == APHomepageAddItemTypeDDPlayer) {
        [self gotoAddDDPlayerViewController];
    }
}

@end
