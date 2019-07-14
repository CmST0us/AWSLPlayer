//
//  APBiliBiliURLSession.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, APBiliBiliLiveStreamType) {
    APBiliBiliLiveStreamTypeFLV,
    APBiliBiliLiveStreamTypeM3U8,
};

@class APURLSession;
@interface APBiliBiliURLSession : NSObject
@property (nonatomic, readonly) APURLSession *session;
@property (nonatomic, assign) APBiliBiliLiveStreamType streamType;

- (void)requestRealRoomID:(NSUInteger)requestedRoomID completion:(void(^)(NSInteger realRoomID, NSError * _Nullable error))block;
- (void)requestPlayURLWithReadRoomID:(NSUInteger)realRoomID completion:(void(^)(NSArray<NSString *> *_Nullable urlStrings, NSError * _Nullable error))block;

@end

NS_ASSUME_NONNULL_END
