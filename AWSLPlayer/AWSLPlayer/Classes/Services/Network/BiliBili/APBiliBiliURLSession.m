//
//  APBiliBiliURLSession.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APBiliBiliURLSession.h"
#import "APURLSession.h"
#import "NSURLRequest+APURLRequest.h"

const NSString *APBiliBiliLiveRoomIDRequestURL = @"https://api.live.bilibili.com/room/v1/Room/room_init?id=";
const NSString *APBiliBiliLivePlayURLRequestURLFormat = @"https://api.live.bilibili.com/api/playurl?cid=%lu&otype=json&quality=0&platform=web";

@interface APBiliBiliURLSession ()
@property (nonatomic, strong) APURLSession *session;
@end

@implementation APBiliBiliURLSession
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

- (void)requestRealRoomID:(NSUInteger)requestedRoomID completion:(void(^)(NSInteger realRoomID, NSError * _Nullable error))block {
    NSString *requestURLString = [NSString stringWithFormat:@"%@%lu", APBiliBiliLiveRoomIDRequestURL, requestedRoomID];
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    if (requestURL == nil) {
        block(0, [NSError errorWithAPURLSessionError:APURLSessionErrorBadURL userInfo:nil]);
        return;
    }
    NSURLRequest *req = [NSURLRequest URLRequestWithURL:requestURL Method:@"GET"];
    
    [[self.session getRequest:req completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil || data == nil) {
            block(0, error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (jsonError != nil || jsonObject == nil) {
                block(0, jsonError);
            } else {
                NSDictionary *dataObject = [jsonObject valueForKey:@"data"];
                NSNumber *realRoomIDValue = [dataObject valueForKey:@"room_id"];
                if (realRoomIDValue != nil) {
                    NSUInteger realRoomID = [realRoomIDValue unsignedIntegerValue];
                    block(realRoomID, nil);
                } else {
                    block(0, [NSError errorWithAPURLSessionError:APURLSessionErrorBadJSONObject userInfo:nil]);
                }
            }
        }
    }] resume];
}

- (void)requestPlayURLWithReadRoomID:(NSUInteger)realRoomID completion:(void(^)(NSArray<NSString *> *_Nullable urlStrings, NSError * _Nullable error))block {
    NSString *requestURLString = [NSString stringWithFormat:[APBiliBiliLivePlayURLRequestURLFormat copy], realRoomID];
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    if (requestURL == nil) {
        block(NULL, [NSError errorWithAPURLSessionError:APURLSessionErrorBadURL userInfo:nil]);
        return;
    }
    NSURLRequest *req = [NSURLRequest URLRequestWithURL:requestURL Method:@"GET"];
    [[self.session getRequest:req completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil || data == nil || [data length] == 0) {
            block(NULL, error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (jsonError != nil || jsonObject == nil) {
                block(NULL, jsonError);
            } else {
                NSArray *durl = [jsonObject valueForKey:@"durl"];
                NSMutableArray *playUrls = [NSMutableArray array];
                [durl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        NSString *url = [obj valueForKey:@"url"];
                        if (url != nil && [url isKindOfClass:[NSString class]]) {
                            [playUrls addObject:url];
                        }
                    }
                }];
                block(playUrls, nil);
            }
        }
    }] resume];
}
@end
