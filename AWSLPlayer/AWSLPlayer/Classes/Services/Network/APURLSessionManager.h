//
//  APURLSessionManager.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APURLSessionManager : NSObject
+ (instancetype)sharedInstance;

- (NSURLSession *)createURLSession;
@end

NS_ASSUME_NONNULL_END
