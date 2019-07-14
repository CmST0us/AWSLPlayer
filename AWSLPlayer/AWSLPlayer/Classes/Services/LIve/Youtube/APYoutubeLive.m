//
//  APYoutubeLive.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/15.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APMacroHelper.h"
#import "APYoutubeLive.h"


@interface APYoutubeLive ()
@property (nonatomic, strong) APYoutubeURLSession *session;
@end

@implementation APYoutubeLive
- (instancetype)initWithLiveRoomURL:(NSURL *)liveRoomURL {
    self = [super init];
    if (self) {
        _liveRoomURL = liveRoomURL;
    }
    return self;
}

- (APYoutubeURLSession *)session {
    if (_session == nil) {
        _session = [[APYoutubeURLSession alloc] init];
    }
    return _session;
}

- (void)requestPlayURLWithCompletion:(APYoutubeURLSessionRequestPlayURLHandler)block {
    weakSelf(self);
    [self.session requestPlayURLWithLiveRoomURL:self.liveRoomURL completion:^(NSString * _Nullable playURL, NSError * _Nullable error) {
        weakSelf.session = nil;
        block(playURL, error);
    }];
}
@end
