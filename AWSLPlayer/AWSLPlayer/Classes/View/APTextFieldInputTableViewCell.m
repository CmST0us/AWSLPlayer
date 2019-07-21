//
//  APTextFieldInputTableViewCell.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "APTextFieldInputTableViewCell.h"

@interface APTextFieldInputTableViewCell ()
@property (nonatomic, strong) QMUILabel *inputTitleLabel;
@property (nonatomic, strong) QMUITextField *inputTextField;
@end

@implementation APTextFieldInputTableViewCell
- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
    [super didInitializeWithStyle:style];
    
    self.inputTitleLabel = [[QMUILabel alloc] init];
    self.inputTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.inputTitleLabel];
    [self.inputTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(12);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    
    self.inputTextField = [[QMUITextField alloc] init];
    [self addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputTitleLabel.mas_right);
        make.right.equalTo(self).offset(-15);
        make.top.bottom.equalTo(self.inputTitleLabel);
    }];
}

- (void)setInputText:(NSString *)inputText {
    self.inputTextField.text = inputText;
}

- (void)setInputTitle:(NSString *)inputTitle {
    self.inputTitleLabel.text = inputTitle;
}

- (NSString *)inputText {
    return self.inputTextField.text;
}

- (NSString *)inputTitle {
    return self.inputTitleLabel.text;
}
@end
