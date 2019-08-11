//
//  APHibikiLive.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/17.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APPlatformLiveURLProcessor.h"

NS_ASSUME_NONNULL_BEGIN

@interface APHibikiLive : APPlatformLiveURLProcessor

@property (nonatomic, readonly) NSString *accessID;
@property (nonatomic, readonly) NSInteger videoID;

@property (nonatomic, readonly) NSDictionary<NSString *, NSURL *> *playURLs;

- (instancetype)initWithAccessID:(NSString *)accessID;

- (void)requestPlayURLsWithCompletion:(APRequestPlatformLivePlayURLBlock)block;

@end

NS_ASSUME_NONNULL_END
