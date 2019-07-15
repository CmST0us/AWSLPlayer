//
//  NSError+APURLSession.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, APURLSessionError) {
    APURLSessionErrorTimeout = -10000,
    APURLSessionErrorBadURL = -10001,
    APURLSessionErrorBadJSONObject = -10002,
    
    APURLSessionErrorAPIReturnNotSuccess = -10003,
    APURLSessionErrorServerNotHaveThisObject = -10004
};

extern const NSString *APURLSessionErrorDomain;

@interface NSError (APURLSession)
+ (NSError *)errorWithAPURLSessionError:(APURLSessionError)error
                               userInfo:(nullable NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
