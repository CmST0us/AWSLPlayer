//
//  APPlatformLiveURLProcessor.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/11.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APRequestPlatformLivePlayURLProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface APPlatformLiveURLProcessor : NSObject<APRequestPlatformLivePlayURLProtocol>

- (nullable instancetype)initWithLiveRoomURL:(NSURL *)url;
- (NSDictionary<NSString *, NSURL *> * _Nullable )playURLs;
- (void)requestPlayURLWithCompletion:(APRequestPlatformLivePlayURLBlock)block;
@end

NS_ASSUME_NONNULL_END
