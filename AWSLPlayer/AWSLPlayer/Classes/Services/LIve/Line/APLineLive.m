//
//  APLineLive.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/16.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APLineLive.h"
#import "APLineLiveURLSession.h"
@interface APLineLive ()
@property (nonatomic, assign) NSUInteger requestedChannelID;
@property (nonatomic, assign) NSUInteger requestedBroadcastID;
@property (nonatomic, strong) APLineLiveURLSession *session;
@end

@implementation APLineLive

- (instancetype)initWithChannelID:(NSUInteger)channelID
                      broadcastID:(NSUInteger)broadcastID {
    self = [super init];
    if (self) {
        _requestedChannelID = channelID;
        _requestedBroadcastID = broadcastID;
    }
    return self;
}

- (APLineLiveURLSession *)session {
    if (_session == nil) {
        _session = [[APLineLiveURLSession alloc] init];
    }
    return _session;
}

- (void)requestPlayURLsWithCompletions:(APRequestPlatformLivePlayURLBlock)block {
    [self.session requestPlayURLsWithChannelID:self.requestedChannelID broadcast:self.requestedBroadcastID completion:block];
}
@end
