//
//  APAddLiveURLViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APAddLiveURLViewDataSource.h"
#import "APAddLiveURLViewController.h"

@interface APAddLiveURLViewController ()
@property (nonatomic, strong) APAddLiveURLViewDataSource *dataSource;
@end

@implementation APAddLiveURLViewController

- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:style];
    
    self.title = NSLocalizedString(@"ap_add_live_url_title", @"添加直播间");
    self.dataSource = [[APAddLiveURLViewDataSource alloc] init];
    self.tableView.qmui_staticCellDataSource = self.dataSource;
}


@end
