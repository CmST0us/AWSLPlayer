//
//  APUserDefaultHelper.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APUserDefaultHelper.h"

const NSString *APDDPlayerModelsKey = @"APDDPlayerModelsKey";
const NSString *APLiveURLModelsKey = @"APLiveURLModelsKey";
const NSString *APLiveURLFolderModelsKey = @"APLiveURLFolderModelsKey";

@implementation APUserDefaultHelper
MAKE_CLASS_SINGLETON(APUserDefaultHelper, instance, sharedInstance)

- (void)setObject:(id)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}

- (id)objectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
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
