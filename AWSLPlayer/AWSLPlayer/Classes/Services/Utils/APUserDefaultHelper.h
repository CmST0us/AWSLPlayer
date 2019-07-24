//
//  APUserDefaultHelper.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APMacroHelper.h"
NS_ASSUME_NONNULL_BEGIN

extern NSString * const APDDPlayerModelsKey;
extern NSString * const APLiveURLModelsKey;
extern NSString * const APLiveURLFolderModelsKey;

@interface APUserDefaultHelper : NSObject
+ (instancetype)sharedInstance;

- (void)setObject:(id)object forKey:(NSString *)key;
- (nullable id)objectForKey:(NSString *)key;

- (NSMutableArray *)mutableArrayObjectWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
