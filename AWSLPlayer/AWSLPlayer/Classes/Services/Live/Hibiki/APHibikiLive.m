//
//  APHibikiLive.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/17.
//  Copyright © 2019 eric3u. All rights reserved.
//


#import "APHibikiLive.h"
#import "APHibikiURLSession.h"
#import "APMacroHelper.h"
#import "NSError+APURLSession.h"
@interface APHibikiLive ()

@property (nonatomic, copy) NSString *accessID;
@property (nonatomic, assign) NSInteger videoID;

@property (nonatomic, strong) NSDictionary<NSString *, NSURL *> *playURLs;

@property (nonatomic, strong) APHibikiURLSession *session;
@end

@implementation APHibikiLive

- (instancetype)initWithAccessID:(NSString *)accessID {
    self = [super init];
    if (self) {
        _accessID = accessID;
    }
    return self;
}

- (APHibikiURLSession *)session {
    if (_session == nil) {
        _session = [[APHibikiURLSession alloc] init];
    }
    return _session;
}

- (void)requestPlayURLsWithCompletion:(APRequestPlatformLivePlayURLBlock)block {
    weakSelf(target);
    [self.session requestVideoIDWithAccessID:self.accessID completion:^(NSInteger videoID, NSError * _Nullable error) {
        if (error == nil) {
            target.videoID = videoID;
            [target.session requestPlayURLsWithVideoID:videoID completion:^(NSString * _Nullable playURL, NSError * _Nullable ee) {
                if (ee == nil) {
                    NSURL *url = [NSURL URLWithString:playURL];
                    if (url == nil) {
                        block(nil, [NSError errorWithAPURLSessionError:APURLSessionErrorServerNotHaveThisObject userInfo:nil]);
                    } else {
                        target.playURLs = @{
                                              @"origin": url
                                              };
                        block(target.playURLs, nil);
                    }
                } else {
                    block(nil, ee);
                }
            }];
        } else {
            block(nil, error);
        }
    }];
}
@end
