//
//  APYoutubeURLSession.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^APYoutubeURLSessionRequestPlayURLHandler)(NSString *_Nullable playURL, NSError * _Nullable error);

@class APURLSession;
@interface APYoutubeURLSession : NSObject

- (void)requestPlayURLWithLiveRoomURL:(NSURL *)liveRoomURL completion:(APYoutubeURLSessionRequestPlayURLHandler)block;

@end

NS_ASSUME_NONNULL_END
