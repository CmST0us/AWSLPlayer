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
@property (nonatomic, assign) NSInteger requestedRoomID;
@property (nonatomic, assign) NSInteger realRoomID;
@property (nonatomic, strong, nullable) NSDictionary<NSString *, NSURL *> *playURLs;
@end

@implementation APBiliBiliLive
- (instancetype)initWithRoomID:(NSInteger)roomID {
    self = [super init];
    if (self) {
        _realRoomID = 0;
        _requestedRoomID = roomID;
        self.timeout = 10;
    }
    return self;
}

- (instancetype)initWithLiveRoomURL:(NSURL *)url {
    if (url.absoluteString.length == 0) {
        return nil;
    }
    NSString *s = url.absoluteString;
    NSString *regex = @"live.bilibili.com\\/(\\d+)";
    NSError *error = nil;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    if (error != nil) return nil;
    
    NSArray *match = [reg matchesInString:s options:NSMatchingReportCompletion range:NSMakeRange(0, s.length)];
    
    if (match.count < 1) return nil;
    
    NSTextCheckingResult *result = match[0];
    NSString *roomID = [s substringWithRange:[result rangeAtIndex:1]];
    return [self initWithRoomID:[roomID integerValue]];
}

- (APBiliBiliURLSession *)session {
    if (_session == nil) {
        _session = [[APBiliBiliURLSession alloc] init];
    }
    return _session;
}

- (void)requestPlayURLWithCompletion:(APRequestPlatformLivePlayURLBlock)block {
    weakSelf(target);
    [self.session requestRealRoomID:self.requestedRoomID completion:^(NSInteger realRoomID, NSError * _Nullable error) {
        if (error == nil) {
            target.realRoomID = realRoomID;
            [target.session requestPlayURLWithReadRoomID:realRoomID completion:^(NSArray<NSString *> * _Nullable urlStrings, NSError * _Nullable ee) {
                if (ee == nil) {
                    if (urlStrings == nil) {
                        block(nil, [NSError errorWithAPURLSessionError:APURLSessionErrorServerNotHaveThisObject userInfo:nil]);
                    } else {
                        NSMutableDictionary *playURLs = [NSMutableDictionary dictionary];
                        [urlStrings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            NSURL *url = [NSURL URLWithString:obj];
                            if (url) {
                                [playURLs setObject:url forKey:[NSNumber numberWithUnsignedInteger:idx].stringValue];
                            }
                        }];
                        target.playURLs = playURLs;
                        block(playURLs, nil);
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
