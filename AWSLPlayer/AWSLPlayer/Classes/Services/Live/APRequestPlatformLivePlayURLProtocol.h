//
//  APRequestPlatformLivePlayURLProtocol.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/15.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^APRequestPlatformLivePlayURLBlock)(NSDictionary * _Nullable playURLs, NSError * _Nullable error);

@protocol APRequestPlatformLivePlayURLProtocol <NSObject>
@required
- (NSDictionary<NSString *, NSURL *> * _Nullable )playURLs;

@end

NS_ASSUME_NONNULL_END
