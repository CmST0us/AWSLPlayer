//
//  APLiveURLFolderModel.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APLiveURLFolderModel.h"

@implementation APLiveURLFolderModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"";
        _liveURLs = [NSMutableArray array];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_liveURLs forKey:@"liveURLs"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _liveURLs = [[coder decodeObjectForKey:@"liveURLs"] mutableCopy] ? : [@[] mutableCopy];
    }
    return self;
}
@end
