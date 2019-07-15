//
//  APLineLiveURLSession.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/15.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class APURLSession;
@interface APLineLiveURLSession : NSObject
@property (nonatomic, readonly) APURLSession *session;


- (void)requestPlayURLsWithChannelID:(NSUInteger)channelID
                           broadcast:(NSUInteger)broadcastID
                          completion:(void(^)(NSDictionary * _Nullable playURLs, NSError * _Nullable error))block;
@end

NS_ASSUME_NONNULL_END
