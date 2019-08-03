//
//  APUserDefaultHelper.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APUserDefaultKey.h"
#import "APUserDefaultHelper.h"

@implementation APUserDefaultHelper
MAKE_CLASS_SINGLETON(APUserDefaultHelper, instance, sharedInstance)

- (void)setObject:(id)object forKey:(NSString *)key {
    NSDictionary *keyConfig = [[self userDefaultConfigs] valueForKey:key];
    if (keyConfig != nil && [keyConfig isKindOfClass:[NSDictionary class]]) {
        // check value class type
        if (object != nil && [object isKindOfClass:NSClassFromString(keyConfig[APUserStorageHelperValueClassTypeKey])]) {
            [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
            [self.storage setValue:object forKey:key];
        }
    }
}

@end
