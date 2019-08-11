//
//  APLiveURLModel.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APLiveURLModel.h"

@implementation APLiveURLModel
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_liveURL forKey:@"liveURL"];
    [coder encodeObject:@(_urlType) forKey:@"urlType"];
    [coder encodeObject:_folderName forKey:@"folderName"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _liveURL = [coder decodeObjectForKey:@"liveURL"];
        _urlType = [[coder decodeObjectForKey:@"urlType"] unsignedIntegerValue];
        _folderName = [coder decodeObjectForKey:@"folderName"];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _urlType = APLiveURLTypeRaw;
        _name = @"";
        _liveURL = [NSURL URLWithString:@""];
        _folderName = @"";
    }
    return self;
}

- (Class)processorClass {
    static NSDictionary *supportProcessorClass = nil;
    if (supportProcessorClass == nil) {
        NSDictionary *d = @{
            @(APLiveURLTypeNicoNico): @"APNicoNicoLive",
            @(APLiveURLTypeHibikiRadio): @"APHibikiLive",
            @(APLiveURLTypeLineLive): @"APLineLive",
            @(APLiveURLTypeBiliBili): @"APBiliBiliLive",
            @(APLiveURLTypeYoutube): @"APYoutubeLive",
        };
        supportProcessorClass = d;
    }
    NSString *classString = supportProcessorClass[@(self.urlType)];
    if (classString == nil || classString.length == 0) {
        return nil;
    }
    return NSClassFromString(classString);
}

@end
