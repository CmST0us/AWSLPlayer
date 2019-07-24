//
//  APUserDefaultHelper.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APUserDefaultHelper.h"

NSString * const APDDPlayerModelsKey = @"APDDPlayerModelsKey";
NSString * const APLiveURLModelsKey = @"APLiveURLModelsKey";
NSString * const APLiveURLFolderModelsKey = @"APLiveURLFolderModelsKey";

@implementation APUserDefaultHelper
MAKE_CLASS_SINGLETON(APUserDefaultHelper, instance, sharedInstance)

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}

- (id<NSCoding>)objectForKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (NSMutableArray *)mutableArrayObjectWithKey:(NSString *)key {
    NSArray *a = [self objectForKey:key];
    if (a == nil || ![a isKindOfClass:[NSArray class]] || a.count == 0) {
        return [NSMutableArray array];
    } else {
        return [[NSMutableArray alloc] initWithArray:a];
    }
}

@end
