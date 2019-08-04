//
//  APPlayerDisplayView.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "APPlayerDisplayView.h"

@interface APPlayerDisplayView ()
@property (nonatomic, readonly) AVPlayerLayer *playerLayer;
@end

@implementation APPlayerDisplayView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

@end
