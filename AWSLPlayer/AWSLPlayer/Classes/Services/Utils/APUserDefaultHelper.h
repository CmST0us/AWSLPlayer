//
//  APUserDefaultHelper.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APUserStorageHelper.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const APUserDefaultHelperValueClassTypeKey;
extern NSString * const APUserDefaultHelperValueDefaultKey;

// 用于储存
@interface APUserDefaultHelper : APUserStorageHelper
+ (instancetype)sharedInstance;

- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

// APUserDefaultKey
- (NSDictionary *)userDefaultConfigs;

@end

NS_ASSUME_NONNULL_END
