//
//  APBiliBiliLive.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APBiliBiliLive : NSObject
@property (nonatomic, assign) NSTimeInterval timeout; // Default is 10 sec;
@property (nonatomic, readonly) NSUInteger requestedRoomID;
@property (nonatomic, readonly) NSUInteger realRoomID;

@property (nonatomic, readonly, nullable) NSArray *playURL;

- (instancetype)initWithRoomID:(NSUInteger)roomID;
- (void)requestRealRoomIDWithCompletion:(void(^)(NSInteger realRoomID, NSError * _Nullable error))block;
- (void)requestPlayURLWithCompletion:(void (^)(NSArray<NSString *> * _Nullable playUrls, NSError * _Nullable error))block;
    
@end

NS_ASSUME_NONNULL_END
