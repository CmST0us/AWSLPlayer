//
//  APVVMBindingContainer.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APVVMBindingContainer.h"

@interface APVVMBindingContainer ()
@property (nonatomic, strong) id view;
@property (nonatomic, strong) id viewModel;
@end

@implementation APVVMBindingContainer

+ (APVVMBindingContainer *)bindView:(id)view withViewModel:(id)viewModel {
    APVVMBindingContainer *container = [[APVVMBindingContainer alloc] init];
    container.view = view;
    container.viewModel = viewModel;
    return container;
}
@end
