//
//  APVVMBindingContainer.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APVVMBindingContainer<ViewType, ViewModelType> : NSObject
@property (nonatomic, readonly) id view;
@property (nonatomic, readonly) id viewModel;

+ (APVVMBindingContainer *)bindView:(id)view withViewModel:(id)viewModel;

- (ViewType)view;
- (ViewModelType)viewModel;
@end

NS_ASSUME_NONNULL_END
