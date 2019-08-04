//
//  APPlayerViewController.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class APDDPlayerModel;
@interface APPlayerViewController : APViewController

- (instancetype)initWithDDPlayerModel:(APDDPlayerModel *)model;

@end

NS_ASSUME_NONNULL_END
