//
//  APDDPlayerLayoutModel.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface APDDPlayerLayoutModel : NSObject <NSCoding>
// 最大支持同屏播放个数
@property (nonatomic, readonly) NSInteger playerCount;
@property (nonatomic, readonly) NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *> *playerLayout;
// 默认屏幕大小
@property (nonatomic, assign) CGRect landscapeViewFrame;
@property (nonatomic, assign) CGRect portraitViewFrame;
// 每个播放窗口布局
- (CGRect)playerFrameWithIndex:(NSInteger)index
                   orientation:(UIInterfaceOrientation)orientation;

- (void)updatePlayerFrame:(CGRect)aFrame
          withOrientation:(UIInterfaceOrientation)orientation
           forPlayerIndex:(NSInteger)index;

- (void)setupWithPlayerCount:(NSInteger)count;

+ (NSInteger)maxPlayerCount;

@end

NS_ASSUME_NONNULL_END
