//
//  APYoutubeURLSession.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <QMUIKit/NSURL+QMUI.h>
#import "APYoutubeURLSession.h"
#import "APMacroHelper.h"
#import "NSError+APURLSession.h"
const NSString *APYoutubeLiveRoomRequestURL = @"https://www.youtube.com/watch?v=%@";

@interface APYoutubeURLSession () <WKNavigationDelegate>
@property (nonatomic, copy) APYoutubeURLSessionRequestPlayURLHandler handler;
@property (nonatomic, strong) WKWebView *hiddenWebView;
@end

@implementation APYoutubeURLSession
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (nullable NSURL *)convertRequestURLWithLiveRoomURL:(NSURL *)aURL {
    NSDictionary *parameters = [aURL qmui_queryItems];
    NSString *liveRoomID = [parameters valueForKey:@"v"];
    if (liveRoomID == nil) {
        return nil;
    }
    NSString *convertedURLString = [[NSString alloc] initWithFormat:[APYoutubeLiveRoomRequestURL copy], liveRoomID];
    return [NSURL URLWithString:convertedURLString];
}

- (WKWebView *)hiddenWebView {
    if (_hiddenWebView == nil) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        _hiddenWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _hiddenWebView.navigationDelegate = self;
    }
    return _hiddenWebView;
}

- (void)requestPlayURLWithLiveRoomURL:(NSURL *)liveRoomURL completion:(APYoutubeURLSessionRequestPlayURLHandler)block {
    self.handler = block;
    NSURL *reqestURL = [self convertRequestURLWithLiveRoomURL:liveRoomURL];
    if (reqestURL == nil) {
        block(nil, [NSError errorWithAPURLSessionError:APURLSessionErrorBadURL userInfo:nil]);
        return;
    }
    [self.hiddenWebView loadRequest:[NSURLRequest requestWithURL:liveRoomURL]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *getPlayURLJavascript = @"\
    var config = JSON.parse(ytplayer.config.args.player_response);\
    config.streamingData.hlsManifestUrl;\
    ";
    weakSelf(target);
    [webView evaluateJavaScript:getPlayURLJavascript completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        if (error == nil) {
            target.handler(obj, nil);
        } else {
            target.handler(nil, error);
        }
        [target.hiddenWebView stopLoading];
        target.hiddenWebView = nil;
    }];
}

@end
