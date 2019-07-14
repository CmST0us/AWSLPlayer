//
//  APURLSessionManager.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APURLSessionManager.h"
#import "APMacroHelper.h"

@implementation APURLSessionManager
MAKE_CLASS_SINGLETON(APURLSessionManager, manager, sharedInstance);

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
