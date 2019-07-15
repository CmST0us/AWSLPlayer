//
//  APLineLiveURLSession.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/15.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APURLSession.h"
#import "APLineLiveURLSession.h"
#import "NSURLRequest+APURLRequest.h"

const NSString *APLineLivePlayURLRequestFormat = @"https://live-api.line-apps.com/app/v3.2/channel/%lu/broadcast/%lu/player_status";

@interface APLineLiveURLSession ()
@property (nonatomic, strong) APURLSession *session;
@end

@implementation APLineLiveURLSession
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (APURLSession *)session {
    if (_session == nil) {
        _session = [[APURLSession alloc] init];
    }
    return _session;
}

- (void)requestPlayURLsWithChannelID:(NSUInteger)channelID broadcast:(NSUInteger)broadcastID completion:(void(^)(NSDictionary * _Nullable playURLs, NSError * _Nullable error))block {
    NSString *requestURLString = [NSString stringWithFormat:[APLineLivePlayURLRequestFormat copy], channelID, broadcastID];
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    if (requestURL == nil) {
        block(nil, [NSError errorWithAPURLSessionError:APURLSessionErrorBadURL userInfo:nil]);
        return;
    }
    
    NSURLRequest *request = [NSURLRequest URLRequestWithURL:requestURL Method:@"GET"];
    [[self.session getRequest:request completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 检查返回内容
        if (error != nil || data == nil || [data length] == 0) {
            block(NULL, error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (jsonError != nil || jsonObject == nil) {
                block(NULL, jsonError);
            } else {
                // 检查api结果
                NSNumber *retCode = [jsonObject valueForKey:@"status"];
                if (retCode != nil && [retCode integerValue] == 200) {
                    // Success
                    NSDictionary *liveHLSURLs = [jsonObject valueForKey:@"liveHLSURLs"];
                    NSMutableDictionary *vaildPlayURLs = [NSMutableDictionary dictionary];
                    [liveHLSURLs enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        if (![obj isKindOfClass:[NSNull class]]) {
                            NSURL *url = [NSURL URLWithString:obj];
                            if (url != nil) {
                                [vaildPlayURLs setObject:url forKey:key];
                            }
                        }
                    }];
                    
                    if (vaildPlayURLs.count > 0) {
                        block(vaildPlayURLs, nil);
                    } else {
                        block(nil, [NSError errorWithAPURLSessionError:APURLSessionErrorServerNotHaveThisObject userInfo:nil]);
                    }
                } else {
                    block(NULL, [NSError errorWithAPURLSessionError:APURLSessionErrorAPIReturnNotSuccess userInfo:nil]);
                }
            }
        }
    }] resume];
    
}
@end
