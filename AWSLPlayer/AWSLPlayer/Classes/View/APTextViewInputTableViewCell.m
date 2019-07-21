//
//  APTextInputTableViewCell.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "APTextViewInputTableViewCell.h"

@interface APTextViewInputTableViewCell ()
@property (nonatomic, strong) QMUILabel *inputTitleLabel;
@property (nonatomic, strong) QMUITextView *inputTextView;
@end

@implementation APTextViewInputTableViewCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
    [super didInitializeWithStyle:style];
    
    self.inputTitleLabel = [[QMUILabel alloc] init];
    self.inputTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.inputTitleLabel];
    [self.inputTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(12);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(120);
    }];
    
    self.inputTextView = [[QMUITextView alloc] init];
    [self addSubview:self.inputTextView];
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputTitleLabel.mas_right);
        make.top.equalTo(self.inputTitleLabel);
        make.bottom.equalTo(self.mas_bottom).offset(-12);
        make.right.equalTo(self).offset(-15);
    }];
}

- (void)setInputText:(NSString *)inputText {
    self.inputTextView.text = inputText;
}

- (void)setInputTitle:(NSString *)inputTitle {
    self.inputTitleLabel.text = inputTitle;
}

- (NSString *)inputText {
    return self.inputTextView.text;
}

- (NSString *)inputTitle {
    return self.inputTitleLabel.text;
}

@end
