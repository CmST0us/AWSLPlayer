//
//  APDDPlayerModel.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APDDPlayerModel.h"
#import "APDDPlayerLayoutModel.h"
@implementation APDDPlayerModel

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_layoutModel forKey:@"layoutModel"];
    [coder encodeObject:_liveURLs forKey:@"liveURLs"];
    [coder encodeObject:_name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _layoutModel = [coder decodeObjectForKey:@"layoutModel"];
        _liveURLs = [coder decodeObjectForKey:@"liveURLs"];
        _name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

- (NSString *)name {
    if (_name == nil) {
        _name = @"";
    }
    return _name;
}

- (APDDPlayerLayoutModel *)layoutModel {
    if (_layoutModel == nil) {
        _layoutModel = [[APDDPlayerLayoutModel alloc] init];
    }
    return _layoutModel;
}

- (NSMapTable<NSNumber *,APLiveURLModel *> *)liveURLs {
    if (_liveURLs == nil) {
        _liveURLs = [NSMapTable strongToWeakObjectsMapTable];
    }
    return _liveURLs;
}

@end
