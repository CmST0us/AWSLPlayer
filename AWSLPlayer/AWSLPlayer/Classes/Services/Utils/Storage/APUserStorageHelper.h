//
//  APUserStorageHelper.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APMacroHelper.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const APUserStorageHelperValueClassTypeKey;
extern NSString * const APUserStorageHelperValueDefaultKey;

@interface APUserStorageHelper : NSObject
@property (nonatomic, readonly) NSMutableDictionary *storage;

+ (instancetype)sharedInstance;

- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

// save right now
- (void)saveStorage;

// APUserStorageKey
- (NSDictionary *)userDefaultConfigs;

@end

NS_ASSUME_NONNULL_END
