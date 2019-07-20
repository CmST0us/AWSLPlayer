//
//  APHomepageAddItemPopupView.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APHomepageAddItemPopupView.h"

@implementation APHomepageAddItemPopupView

- (void)didInitialize {
    [super didInitialize];
    // 点击空白处关闭
    self.automaticallyHidesWhenUserTap = YES;
    self.maskViewBackgroundColor = [UIColor clearColor];
}

- (CGSize)sizeThatFitsInContentView:(CGSize)size {
    return CGSizeMake(110, 120);
}

@end
