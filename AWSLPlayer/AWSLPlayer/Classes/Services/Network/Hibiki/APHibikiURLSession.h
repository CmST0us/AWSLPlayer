//
//  APHibikiURLSession.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/16.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class APURLSession;
@interface APHibikiURLSession : NSObject
@property (nonatomic, readonly) APURLSession *session;

- (void)requestVideoIDWithAccessID:(NSString *)accessID
                       completion:(void (^)(NSInteger videoID, NSError * _Nullable error))block;

- (void)requestPlayURLsWithVideoID:(NSInteger)videoID
                        completion:(void (^)(NSString * _Nullable playURL, NSError * _Nullable error))block;
@end

NS_ASSUME_NONNULL_END
