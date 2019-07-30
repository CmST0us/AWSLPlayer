//
//  APUserStorageHelper.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APUserStorageKey.h"
#import "APUserStorageHelper.h"

@interface APUserStorageHelper ()
@property (nonatomic, strong) NSMutableDictionary *storage;
@end

@implementation APUserStorageHelper
MAKE_CLASS_SINGLETON(APUserStorageHelper, instance, sharedInstance)

- (instancetype)init {
    self = [super init];
    if (self) {
        _storage = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setObject:(id)object forKey:(NSString *)key {
    NSDictionary *keyConfig = [[self userDefaultConfigs] valueForKey:key];
    if (keyConfig != nil && [keyConfig isKindOfClass:[NSDictionary class]]) {
        // check value class type
        if (object != nil && [object isKindOfClass:NSClassFromString(keyConfig[APUserDefaultHelperValueClassTypeKey])]) {
            [self.storage setValue:object forKey:key];
        }
    }
}

- (id)objectForKey:(NSString *)key {
    NSDictionary *keyConfig = [[self userDefaultConfigs] valueForKey:key];
    if (keyConfig != nil && [keyConfig isKindOfClass:[NSDictionary class]]) {
        id obj = [self.storage valueForKey:key];
        Class valueClassType = keyConfig[APUserDefaultHelperValueClassTypeKey];
        if (obj != nil && [obj isKindOfClass:valueClassType]) {
            return obj;
        }
    }
    id defaultObj = keyConfig[APUserDefaultHelperValueDefaultKey];
    [self.storage setValue:defaultObj forKey:key];
    return defaultObj;
}

- (NSDictionary *)userDefaultConfigs {
    static NSDictionary *config = nil;
    if (config != nil) {
        return config;
    }
    config = @{
        kAPUserStorageKeyURLFolder: @{
                APUserDefaultHelperValueClassTypeKey: @"NSArray",
                APUserDefaultHelperValueDefaultKey: @[],
        },
    };
    return config;
}

@end


@implementation APUserStorageHelper (KeyListening)


@end
