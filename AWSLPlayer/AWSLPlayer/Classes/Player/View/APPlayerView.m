//
//  APPlayerView.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "APPlayerControlView.h"
#import "APPlayerDisplayView.h"
#import "APPlayerView.h"

@implementation APPlayerView

- (void)didInitialize {
    [super didInitialize];
    
    self.displayView = [[[self displayViewClass] alloc] init];
    self.controlView = [[[self controlViewClass] alloc] init];
    
    [self addSubview:self.displayView];
    [self addSubview:self.controlView];
    
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

- (Class)displayViewClass {
    return [APPlayerDisplayView class];
}

- (Class)controlViewClass {
    return [APPlayerControlView class];
}

- (void)setupWithViewModel:(APPlayerViewModel *)model {
    [self.controlView setupWithViewModel:model];
    [self.displayView setupWithViewModel:model];
}

@end
