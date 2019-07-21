//
//  APDDPlayerLayoutModel.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APDDPlayerLayoutModel.h"

@implementation APDDPlayerLayoutModel

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInteger:_maxPlayerCount forKey:@"maxPlayerCount"];
    [coder encodeObject:_playerLayout forKey:@"playerLayout"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _maxPlayerCount = [coder decodeIntegerForKey:@"maxPlayerCount"];
        _playerLayout = [coder decodeObjectForKey:@"_playerLayout"];
    }
    return self;
}


@end
