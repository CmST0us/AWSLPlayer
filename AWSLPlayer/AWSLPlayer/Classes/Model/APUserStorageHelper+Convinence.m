//
//  APUserStorageHelper+Convinence.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APUserStorageKey.h"
#import "APUserStorageHelper+Convinence.h"

@implementation APUserStorageHelper (Convinence)

+ (APModelStorageContainer *)modelStorageContainer {
    APUserStorageHelper *instance = [[self class] sharedInstance];
    return [instance objectForKey:kAPUserStorageKeyModelContainer];
}

@end
