//
//  APFilePathHelper.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APMacroHelper.h"
NS_ASSUME_NONNULL_BEGIN

@interface APFilePathHelper : NSObject
+ (instancetype)sharedInstance;

- (NSString *)documentPath;

- (NSString *)fileSavePathWithFileName:(NSString *)filename;

@end

NS_ASSUME_NONNULL_END
