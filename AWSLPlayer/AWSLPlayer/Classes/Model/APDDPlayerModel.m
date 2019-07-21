//
//  APDDPlayerModel.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APDDPlayerModel.h"

@implementation APDDPlayerModel
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_layoutModel forKey:@"layoutModel"];
    [coder encodeObject:_liveURLs forKey:@"liveURLs"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _layoutModel = [coder decodeObjectForKey:@"layoutModel"];
        _liveURLs = [coder decodeObjectForKey:@"liveURLs"];
    }
    return self;
}
@end
