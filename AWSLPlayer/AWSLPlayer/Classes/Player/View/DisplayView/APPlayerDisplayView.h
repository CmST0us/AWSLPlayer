//
//  APPlayerDisplayView.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APView.h"

NS_ASSUME_NONNULL_BEGIN
@class APPlayerViewModel;
@interface APPlayerDisplayView : APView
- (void)setupWithViewModel:(APPlayerViewModel *)model;
@end

NS_ASSUME_NONNULL_END
