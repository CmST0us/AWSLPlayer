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
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _liveURL = [coder decodeObjectForKey:@"liveURL"];
        _urlType = [[coder decodeObjectForKey:@"urlType"] unsignedIntegerValue];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _urlType = APLiveURLTypeRaw;
    }
    return self;
}
@end
