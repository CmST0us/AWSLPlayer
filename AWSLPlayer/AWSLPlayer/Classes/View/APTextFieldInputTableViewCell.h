//
//  APTextFieldInputTableViewCell.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface APTextFieldInputTableViewCell : QMUITableViewCell
@property (nonatomic, copy) NSString *inputTitle;
@property (nonatomic, copy) NSString *inputText;

@property (nonatomic, readonly) QMUILabel *inputTitleLabel;
@property (nonatomic, readonly) QMUITextField *inputTextField;
@end

NS_ASSUME_NONNULL_END
