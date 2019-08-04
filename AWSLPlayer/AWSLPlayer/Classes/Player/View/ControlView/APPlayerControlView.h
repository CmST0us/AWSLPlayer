//
//  APPlayerControlView.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <NSObjectSignals/NSObject+SignalsSlots.h>
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
@interface APPlayerControlView : APView
@property (nonatomic, readonly) APButton *playPauseButton;
@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, readonly) APButton *exitPlayerButton;

@property (nonatomic, assign) APPlayerControlViewType controlViewType;

- (void)setupWithViewModel:(APPlayerViewModel *)model;

#pragma mark - Signals
// 当播放暂停按钮按下时
// @param: view 当前view
// @param: view model 当前视图的view model
// @param: button 触摸的button
NS_SIGNAL(didPressPlayPauseButton);

// 按下退出播放器按钮时
// @param: view 当前view
// @param: view model 当前视图的view model
// @param: button 触摸的button
NS_SIGNAL(didPressExitPlayerButton);
@end

@interface APPlayerControlView (MiniState)
- (void)miniState;
@end

@interface APPlayerControlView (FullState)
- (void)fullState;
@end

NS_ASSUME_NONNULL_END
