//
//  APTableViewController.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/20.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APTableViewController.h"

@interface APTableViewController ()

@end

@implementation APTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
