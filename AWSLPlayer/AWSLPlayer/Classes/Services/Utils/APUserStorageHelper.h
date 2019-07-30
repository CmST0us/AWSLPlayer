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

extern NSString * const APUserDefaultHelperValueClassTypeKey;
extern NSString * const APUserDefaultHelperValueDefaultKey;

@interface APUserStorageHelper : NSObject
@property (nonatomic, readonly) NSMutableDictionary *storage;

+ (instancetype)sharedInstance;

- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

// APUserStorageKey
- (NSDictionary *)userDefaultConfigs;

@end

@interface APUserStorageHelper (KeyListening)

- (void)listenKey:(NSString *)aKey observer:(NSObject *)aObserver slot:(SEL)aSlot;
- (void)observerStopListen:(NSObject *)observer;
- (void)observer:(NSObject *)observer stopListenKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
