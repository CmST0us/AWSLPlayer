//
//  APDDPlayerModel.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class APDDPlayerLayoutModel;
@class APLiveURLModel;
@interface APDDPlayerModel : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
// 布局，默认四分屏
@property (nonatomic, strong, nonnull) APDDPlayerLayoutModel *layoutModel;
// 直播间地址，对应布局Index
@property (nonatomic, strong, nonnull) NSDictionary<NSNumber *, APLiveURLModel *> *liveURLs;
@end

NS_ASSUME_NONNULL_END
