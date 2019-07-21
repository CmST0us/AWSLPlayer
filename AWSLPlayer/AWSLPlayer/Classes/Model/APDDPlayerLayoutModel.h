//
//  APDDPlayerLayoutModel.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APDDPlayerLayoutModel : NSObject <NSCoding>
// 最大支持同屏播放个数
@property (nonatomic, readonly) NSInteger maxPlayerCount;
// 每个播放窗口布局
@property (nonatomic, copy) NSDictionary<NSNumber *, NSValue *> *playerLayout;
@end

NS_ASSUME_NONNULL_END
