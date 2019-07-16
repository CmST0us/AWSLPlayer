//
//  APHibikiURLSession.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/16.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APHibikiURLSession.h"
#import "APURLSession.h"
#import "NSURLRequest+APURLRequest.h"

const NSString *APHibikiURLVideoIDRequestFormat = @"https://vcms-api.hibiki-radio.jp/api/v1/programs/%@";
const NSString *APHibikiURLPlayURLsRequestFormat = @"https://vcms-api.hibiki-radio.jp/api/v1/videos/play_check?video_id=%ld";

@interface APHibikiURLSession ()
@property (nonatomic, strong) APURLSession *session;
@end

@implementation APHibikiURLSession

- (APURLSession *)session {
    if (_session == nil) {
        _session = [[APURLSession alloc] init];
    }
    return _session;
}

- (void)requestVideoIDWithAccessID:(NSString *)accessID completion:(void (^)(NSInteger videoID, NSError * _Nullable))block {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:[APHibikiURLVideoIDRequestFormat copy], accessID]];
    if (url == nil) {
        block(0, [NSError errorWithAPURLSessionError:APURLSessionErrorBadURL userInfo:nil]);
        return;
    }
    NSURLRequest *request = [NSURLRequest
                             URLRequestWithURL:url
                             Method:@"GET"
                             customHTTPFields:@{
                                                @"X-Requested-With": @"XMLHttpRequest"
                                                }];
    [[self.session request:request completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            block(0, error);
        } else {
            if (data == nil || data.length == 0) {
                block(0, [NSError errorWithAPURLSessionError:APURLSessionErrorAPIReturnNotSuccess userInfo:nil]);
            }
            NSError *jsonError;
            NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (jsonObj == nil) {
                block(0, jsonError);
            } else {
                NSNumber *videoID = jsonObj[@"episode"][@"video"][@"id"];
                if (videoID == nil) {
                    block(0, [NSError errorWithAPURLSessionError:APURLSessionErrorServerNotHaveThisObject userInfo:nil]);
                } else {
                    block(videoID.integerValue, nil);
                }
            }
        }
    }] resume];
}

- (void)requestPlayURLsWithVideoID:(NSInteger)videoID completion:(void (^)(NSString * _Nullable, NSError * _Nullable))block {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:[APHibikiURLPlayURLsRequestFormat copy], videoID]];
    if (url == nil) {
        block(0, [NSError errorWithAPURLSessionError:APURLSessionErrorBadURL userInfo:nil]);
        return;
    }
    NSURLRequest *request = [NSURLRequest
                             URLRequestWithURL:url
                             Method:@"GET"
                             customHTTPFields:@{
                                                @"X-Requested-With": @"XMLHttpRequest"
                                                }];
    
    [[self.session request:request completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            block(nil, error);
        } else {
            if (data == nil || data.length == 0) {
                block(nil, [NSError errorWithAPURLSessionError:APURLSessionErrorAPIReturnNotSuccess userInfo:nil]);
            }
            NSError *jsonError;
            NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (jsonObj == nil) {
                block(nil, jsonError);
            } else {
                NSString *playURLString = [jsonObj valueForKey:@"playlist_url"];
                if (playURLString == nil) {
                    block(nil, [NSError errorWithAPURLSessionError:APURLSessionErrorServerNotHaveThisObject userInfo:nil]);
                } else {
                    block(playURLString, nil);
                }
            }
        }
    }] resume];
}
@end
