//
//  APPlayerView.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APPlayerView.h"

@implementation APPlayerView

- (void)didInitialize {
    [super didInitialize];
    
    self.displayView = [[[self displayViewClass] alloc] init];
    self.controlView = [[[self controlViewClass] alloc] init];
    
    [self addSubview:self.displayView];
    [self addSubview:self.controlView];
}

- (Class)displayViewClass {
    return NSClassFromString(@"APPlayerDisplayView");
}

- (Class)controlViewClass {
    return NSClassFromString(@"APPlayerControlView");
}

@end
