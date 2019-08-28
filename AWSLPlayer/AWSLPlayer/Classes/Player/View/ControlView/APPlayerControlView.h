//
//  APPlayerControlView.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <NSObjectSignals/NSObjectSignals.h>
#import "APView.h"
/*

+------------------------------------------+
|  Title                              Live |
|                                          |
|                                          |
|                                          |
|                Stop                      |
|                                          |
|                                          |
|                                          |
|                            Float         |
|  Volume                   4Screen  Full  |
|                          All Float       |
+------------------------------------------+

+------------------------------------------------------------------+
|  Title                                                           |
|                                                                  |
|                                                   Volume         |
|     Light                                       This Player      |
|       ^                                                          |
|       |                                              ^           |
|       |                                              |           |
|       |                                              |           |
|       |                                              |           |
|       |                                              |           |
|       |                                              |           |
|       |                                              |           |
|       |                                              |           |
|       |                                              |           |
|       +                                              +           |
|                                                                  |
|    +--------------------------------------------------------+    |
|                                                                  |
|                                                                  |
|                                                                  |
|       Stop  Vloume   Live                         Setting  Mini  |
|                                                                  |
+------------------------------------------------------------------+
*/

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, APPlayerControlViewType) {
    APPlayerControlViewTypeMini,
    APPlayerControlViewTypeFull,
};

@class APButton;
@class APPlayerViewModel;

@signals APPlayerControlViewSignals
@optional
// 当播放暂停按钮按下时
// @param: view 当前view
// @param: view model 当前视图的view model
// @param: button 触摸的button
- (void)didPressPlayPauseButton;

// 按下退出播放器按钮时
// @param: view 当前view
// @param: view model 当前视图的view model
// @param: button 触摸的button
- (void)didPressExitPlayerButton;
@end

@interface APPlayerControlView : APView<APPlayerControlViewSignals>
@property (nonatomic, readonly) APButton *playPauseButton;

@property (nonatomic, readonly) APButton *exitPlayerButton;

@property (nonatomic, assign) APPlayerControlViewType controlViewType;

- (void)setupWithViewModel:(APPlayerViewModel *)model;

@end

@interface APPlayerControlView (MiniState)
- (void)miniState;
@end

@interface APPlayerControlView (FullState)
- (void)fullState;
@end

NS_ASSUME_NONNULL_END
