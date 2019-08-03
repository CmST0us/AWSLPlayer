//
//  APUserStorageHelper.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <pthread.h>
#import <NSObjectSignals/NSObject+SignalsSlots.h>
#import "APUserStorageKey.h"
#import "APUserStorageHelper.h"
#import "APUserStorageHasDefaultProtocol.h"
#import "APFilePathHelper.h"
#define kAPUserStorageHelperSaveInterval 10

NSString * const APUserStorageHelperValueClassTypeKey = @"ClassTypeKey";
NSString * const APUserStorageHelperValueDefaultKey = @"DefaultKey";
NSString * const APUserStorageHelperUseDefauleValueSelector = @"$defaultValue";
NSString * const APUserStorageHelperStorageFileSaveName = @"storage.cfg";

@interface APUserStorageHelper () {
    pthread_mutex_t _saveLocker;
}
@property (nonatomic, copy) NSString *storageFilePath;
@property (nonatomic, strong) NSMutableDictionary *storage;

@property (nonatomic, strong) NSTimer *storageSaveTimer;

@end

@implementation APUserStorageHelper
MAKE_CLASS_SINGLETON(APUserStorageHelper, instance, sharedInstance)

- (instancetype)init {
    self = [super init];
    if (self) {
        _storageFilePath = [[APFilePathHelper sharedInstance] fileSavePathWithFileName:APUserStorageHelperStorageFileSaveName];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:_storageFilePath];
        if (dict) {
            _storage = [[NSMutableDictionary alloc] initWithDictionary:dict];
        } else {
            _storage = [[NSMutableDictionary alloc] init];
        }
        _storageSaveTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(saveStorage) userInfo:nil repeats:YES];
        pthread_mutex_init(&_saveLocker, NULL);
    }
    return self;
}

- (void)dealloc {
    pthread_mutex_destroy(&_saveLocker);
}

- (void)setObject:(id)object forKey:(NSString *)key {
    pthread_mutex_lock(&_saveLocker);
    NSDictionary *keyConfig = [[self userDefaultConfigs] valueForKey:key];
    if (keyConfig != nil && [keyConfig isKindOfClass:[NSDictionary class]]) {
        // check value class type
        if (object != nil && [object isKindOfClass:NSClassFromString(keyConfig[APUserStorageHelperValueClassTypeKey])]) {
            [self.storage setValue:object forKey:key];
        }
    }
    pthread_mutex_unlock(&_saveLocker);
}

- (id)objectForKey:(NSString *)key {
    pthread_mutex_lock(&_saveLocker);
    NSDictionary *keyConfig = [[self userDefaultConfigs] valueForKey:key];
    if (keyConfig != nil && [keyConfig isKindOfClass:[NSDictionary class]]) {
        id obj = [self.storage valueForKey:key];
        Class valueClassType = NSClassFromString(keyConfig[APUserStorageHelperValueClassTypeKey]);
        if (obj != nil && [obj isKindOfClass:valueClassType]) {
            pthread_mutex_unlock(&_saveLocker);
            return obj;
        }
    }
    id defaultObj = keyConfig[APUserStorageHelperValueDefaultKey];
    Class targetClass = NSClassFromString(keyConfig[APUserStorageHelperValueClassTypeKey]);
    if (defaultObj != nil &&
        [defaultObj isKindOfClass:[NSString class]] &&
        [defaultObj isEqualToString:APUserStorageHelperUseDefauleValueSelector] &&
        [targetClass conformsToProtocol:@protocol(APUserStorageHasDefaultProtocol)] &&
        [targetClass respondsToSelector:@selector(defaultValue)]) {
        Class<APUserStorageHasDefaultProtocol> target = targetClass;
        defaultObj = [target defaultValue];
    }
    [self.storage setValue:defaultObj forKey:key];
    pthread_mutex_unlock(&_saveLocker);
    return defaultObj;
}

- (void)saveStorage {
    pthread_mutex_lock(&_saveLocker);
    // save changes;
    if (self.storageFilePath.length > 0) {
        [NSKeyedArchiver archiveRootObject:self.storage toFile:self.storageFilePath];
    }
    pthread_mutex_unlock(&_saveLocker);
}

+ (void)clearStorage {
    [[NSFileManager defaultManager] removeItemAtPath:[[APFilePathHelper sharedInstance] fileSavePathWithFileName:APUserStorageHelperStorageFileSaveName] error:nil];
}

- (NSDictionary *)userDefaultConfigs {
    static NSDictionary *config = nil;
    if (config != nil) {
        return config;
    }
    config = @{
        kAPUserStorageKeyModelContainer: @{
                APUserStorageHelperValueClassTypeKey: kAPUserStorageModelContainerClassName,
                APUserStorageHelperValueDefaultKey: APUserStorageHelperUseDefauleValueSelector,
        },
    };
    return config;
}

@end
