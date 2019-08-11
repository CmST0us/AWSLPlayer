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

- (instancetype)initWithLiveRoomURL:(NSURL *)url {
    NSString *urlString = url.absoluteString;
    if (urlString == nil || urlString.length == 0) return nil;
    
    NSString *regex = @"live.line.me\\/channels\\/(\\d+?)\\/broadcast\\/(\\d+)";
    NSError *error = nil;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    if (error != nil) return nil;
    NSArray *match = [reg matchesInString:urlString options:NSMatchingReportCompletion range:NSMakeRange(0, urlString.length)];
    if (match.count < 1) return nil;
    
    NSTextCheckingResult *channelsResult = match[0];
    NSTextCheckingResult *broadcastResult = match[0];
    
    NSInteger channelID = 0;
    NSInteger broadcastID = 0;
    
    NSRange matchRange = [channelsResult rangeAtIndex:1];
    NSString *matchString = [urlString substringWithRange:matchRange];
    
    channelID = matchString.integerValue;
    
    matchRange = [broadcastResult rangeAtIndex:2];
    matchString = [urlString substringWithRange:matchRange];
    
    broadcastID = matchString.integerValue;
    
    return [self initWithChannelID:channelID broadcastID:broadcastID];
    
}

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

- (void)requestPlayURLWithCompletion:(APRequestPlatformLivePlayURLBlock)block {
    [self.session requestPlayURLsWithChannelID:self.requestedChannelID broadcast:self.requestedBroadcastID completion:block];
}
@end
