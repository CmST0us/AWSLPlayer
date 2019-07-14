//
//  APBiliBiliLive.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APMacroHelper.h"
#import "APBiliBiliLive.h"
#import "APBiliBiliURLSession.h"
#import "NSError+APURLSession.h"

@interface APBiliBiliLive ()
@property (nonatomic, strong) APBiliBiliURLSession *session;
@property (nonatomic, assign) NSUInteger requestedRoomID;
@property (nonatomic, assign) NSUInteger realRoomID;
@property (nonatomic, copy, nullable) NSArray *playURL;
@end

@implementation APBiliBiliLive
- (instancetype)initWithRoomID:(NSUInteger)roomID {
    self = [super init];
    if (self) {
        _realRoomID = 0;
        _requestedRoomID = roomID;
        self.timeout = 10;
    }
    return self;
}

- (APBiliBiliURLSession *)session {
    if (_session == nil) {
        _session = [[APBiliBiliURLSession alloc] init];
    }
    return _session;
}

- (void)requestRealRoomIDWithCompletion:(void(^)(NSInteger realRoomID, NSError *error))block {
    weakSelf(self);
    [self.session requestRealRoomID:self.requestedRoomID completion:^(NSInteger realRoomID, NSError * _Nonnull error) {
        weakSelf.realRoomID = realRoomID;
        block(realRoomID, error);
    }];
}

- (void)requestPlayURLWithCompletion:(void (^)(NSArray<NSString *> * _Nullable playUrls, NSError * _Nullable error))block {
    weakSelf(self);
    [self.session requestPlayURLWithReadRoomID:self.realRoomID completion:^(NSArray<NSString *> * _Nonnull urlStrings, NSError * _Nonnull error) {
        weakSelf.playURL = urlStrings;
        block(urlStrings, error);
    }];
}

@end
