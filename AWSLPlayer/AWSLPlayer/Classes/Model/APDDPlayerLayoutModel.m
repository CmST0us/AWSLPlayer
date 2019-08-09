//
//  APDDPlayerLayoutModel.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APDDPlayerLayoutModel.h"

#define kAPDDPlayerLayoutModelMaxPlayerCount (4)

@interface APDDPlayerLayoutModel ()
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *> *playerLayout;
@end

@implementation APDDPlayerLayoutModel

- (instancetype)init {
    self = [super init];
    if (self) {
        CGRect screenBound = [UIScreen mainScreen].bounds;
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) {
            _landscapeViewFrame = CGRectMake(0, 0, screenBound.size.height, screenBound.size.width);
            _portraitViewFrame = screenBound;
        } else if (orientation == UIInterfaceOrientationLandscapeLeft ||
                   orientation == UIInterfaceOrientationLandscapeRight) {
            _landscapeViewFrame = screenBound;
            _portraitViewFrame = CGRectMake(0, 0, screenBound.size.height, screenBound.size.width);
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_playerLayout forKey:@"playerLayout"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        _playerLayout = [[coder decodeObjectForKey:@"playerLayout"] mutableCopy] ? : [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSMutableDictionary<NSNumber *,NSMutableDictionary<NSNumber *,NSValue *> *> *)playerLayout {
    if (_playerLayout == nil) {
        _playerLayout = [NSMutableDictionary dictionary];
    }
    return _playerLayout;
}

- (NSInteger)playerCount {
    return self.playerLayout.count;
}

- (CGRect)playerFrameWithIndex:(NSInteger)index orientation:(UIInterfaceOrientation)orientation {
    NSMutableDictionary *playerFrames = [self.playerLayout objectForKey:@(index)];
    if (playerFrames == nil) return CGRectNull;
    
    NSValue *layoutFrame = [playerFrames objectForKey:@(orientation)];
    if (layoutFrame == nil) return CGRectNull;
    
    return [layoutFrame CGRectValue];
}

- (void)updatePlayerFrame:(CGRect)aFrame withOrientation:(UIInterfaceOrientation)orientation forPlayerIndex:(NSInteger)index {
    NSMutableDictionary *playersFrame = [self.playerLayout objectForKey:@(index)];
    if (playersFrame == nil)  {
        playersFrame = @{
            @(orientation): [NSValue valueWithCGRect:aFrame]
        }.mutableCopy;
        [self.playerLayout setObject:playersFrame forKey:@(index)];
    } else {
        [playersFrame setObject:[NSValue valueWithCGRect:aFrame] forKey:@(orientation)];
    }
}

- (void)setupWithPlayerCount:(NSInteger)count {
    NSAssert(count <= [self.class maxPlayerCount], @"player count > max player count");
    
    NSString *setupDefaultLayoutSelector = [NSString stringWithFormat:@"setupPlayerDefaultLayout_%ld", count];
    SEL selector = NSSelectorFromString(setupDefaultLayoutSelector);
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:selector];
    #pragma clang diagnostic pop
}

- (void)setupPlayerDefaultLayout_1 {
    CGRect landscapeLayoutFrame = self.landscapeViewFrame;
    NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

    CGRect portraitLayoutFrame = self.portraitViewFrame;
    NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];
    
    [self.playerLayout addEntriesFromDictionary:@{
        @(0): @{
                @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
        }.mutableCopy,
    }];
}

- (void)setupPlayerDefaultLayout_2 {
    CGFloat halfWidthLandScape = self.landscapeViewFrame.size.width / 2;
//    CGFloat halfHeightLandScape = self.landscapeViewFrame.size.height / 2;
    
//    CGFloat halfWidthPortrait = self.portraitViewFrame.size.width / 2;
    CGFloat halfHeightPortrait = self.portraitViewFrame.size.height / 2;
    {
        CGRect landscapeLayoutFrame = CGRectMake(self.landscapeViewFrame.origin.x,
                                                 self.landscapeViewFrame.origin.y,
                                                 halfWidthLandScape,
                                                 self.landscapeViewFrame.size.height);
        NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

        CGRect portraitLayoutFrame = CGRectMake(self.portraitViewFrame.origin.x,
                                                self.portraitViewFrame.origin.y,
                                                self.portraitViewFrame.size.width,
                                                halfHeightPortrait);
        NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];

        [self.playerLayout addEntriesFromDictionary:@{
            @(0): @{
                @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
            }.mutableCopy,
        }];
    }
    {
         CGRect landscapeLayoutFrame = CGRectMake(self.landscapeViewFrame.origin.x + halfWidthLandScape,
                                                  self.landscapeViewFrame.origin.y,
                                                  halfWidthLandScape,
                                                  self.landscapeViewFrame.size.height);
         NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

         CGRect portraitLayoutFrame = CGRectMake(self.portraitViewFrame.origin.x,
                                                 self.portraitViewFrame.origin.y + halfHeightPortrait,
                                                 self.portraitViewFrame.size.width,
                                                 halfHeightPortrait);
         NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];

         [self.playerLayout addEntriesFromDictionary:@{
             @(1): @{
                 @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                 @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                 @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                 @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
             }.mutableCopy,
         }];
    }
}

- (void)setupPlayerDefaultLayout_3 {
    CGFloat threeOnceWidthLandScape = self.landscapeViewFrame.size.width / 3;
//    CGFloat threeOnceHeightLandScape = self.landscapeViewFrame.size.height / 3;
    
//    CGFloat threeOnceWidthPortrait = self.portraitViewFrame.size.width / 3;
    CGFloat threeOnceHeightPortrait = self.portraitViewFrame.size.height / 3;
    
    {
        CGRect landscapeLayoutFrame = CGRectMake(self.landscapeViewFrame.origin.x,
                                                 self.landscapeViewFrame.origin.y,
                                                 threeOnceWidthLandScape,
                                                 self.landscapeViewFrame.size.height);
        NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

        CGRect portraitLayoutFrame = CGRectMake(self.portraitViewFrame.origin.x,
                                                self.portraitViewFrame.origin.y,
                                                self.portraitViewFrame.size.width,
                                                threeOnceHeightPortrait);
        NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];

        [self.playerLayout addEntriesFromDictionary:@{
            @(0): @{
                @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
            }.mutableCopy,
        }];
    }
    {
         CGRect landscapeLayoutFrame = CGRectMake(self.landscapeViewFrame.origin.x + threeOnceWidthLandScape,
                                                  self.landscapeViewFrame.origin.y,
                                                  threeOnceWidthLandScape,
                                                  self.landscapeViewFrame.size.height);
         NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

         CGRect portraitLayoutFrame = CGRectMake(self.portraitViewFrame.origin.x,
                                                 self.portraitViewFrame.origin.y + threeOnceHeightPortrait,
                                                 self.portraitViewFrame.size.width,
                                                 threeOnceHeightPortrait);
         NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];

         [self.playerLayout addEntriesFromDictionary:@{
             @(1): @{
                 @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                 @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                 @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                 @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
             }.mutableCopy,
         }];
    }
    {
         CGRect landscapeLayoutFrame = CGRectMake(self.landscapeViewFrame.origin.x + threeOnceWidthLandScape * 2,
                                                  self.landscapeViewFrame.origin.y,
                                                  threeOnceWidthLandScape,
                                                  self.landscapeViewFrame.size.height);
         NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

         CGRect portraitLayoutFrame = CGRectMake(self.portraitViewFrame.origin.x,
                                                 self.portraitViewFrame.origin.y + threeOnceHeightPortrait * 2,
                                                 self.portraitViewFrame.size.width,
                                                 threeOnceHeightPortrait);
         NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];

         [self.playerLayout addEntriesFromDictionary:@{
             @(2): @{
                 @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                 @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                 @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                 @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
             }.mutableCopy,
         }];
    }
}

- (void)setupPlayerDefaultLayout_4 {
    CGFloat halfWidthLandScape = self.landscapeViewFrame.size.width / 2;
    CGFloat halfHeightLandScape = self.landscapeViewFrame.size.height / 2;
    
    CGFloat halfWidthPortrait = self.portraitViewFrame.size.width / 2;
    CGFloat halfHeightPortrait = self.portraitViewFrame.size.height / 2;
    
    {
        CGRect landscapeLayoutFrame = CGRectMake(self.landscapeViewFrame.origin.x,
                                                 self.landscapeViewFrame.origin.y,
                                                 halfWidthLandScape,
                                                 halfHeightLandScape);
        NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

        CGRect portraitLayoutFrame = CGRectMake(self.portraitViewFrame.origin.x,
                                                self.portraitViewFrame.origin.y,
                                                halfWidthPortrait,
                                                halfHeightPortrait);
        NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];

        [self.playerLayout addEntriesFromDictionary:@{
            @(0): @{
                @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
            }.mutableCopy,
        }];
    }
    {
         CGRect landscapeLayoutFrame = CGRectMake(self.landscapeViewFrame.origin.x + halfWidthLandScape,
                                                  self.landscapeViewFrame.origin.y,
                                                  halfWidthLandScape,
                                                  halfHeightLandScape);
         NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

         CGRect portraitLayoutFrame = CGRectMake(self.portraitViewFrame.origin.x + halfWidthPortrait,
                                                 self.portraitViewFrame.origin.y,
                                                 halfWidthPortrait,
                                                 halfHeightPortrait);
         NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];

         [self.playerLayout addEntriesFromDictionary:@{
             @(1): @{
                 @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                 @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                 @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                 @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
             }.mutableCopy,
         }];
    }
    {
        CGRect landscapeLayoutFrame = CGRectMake(self.landscapeViewFrame.origin.x,
                                                 self.landscapeViewFrame.origin.y + halfHeightLandScape,
                                                 halfWidthLandScape,
                                                 halfHeightLandScape);
        NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

        CGRect portraitLayoutFrame = CGRectMake(self.portraitViewFrame.origin.x,
                                                self.portraitViewFrame.origin.y + halfHeightPortrait,
                                                halfWidthPortrait,
                                                halfHeightPortrait);
        NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];

        [self.playerLayout addEntriesFromDictionary:@{
            @(2): @{
                @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
            }.mutableCopy,
        }];
    }
    {
         CGRect landscapeLayoutFrame = CGRectMake(self.landscapeViewFrame.origin.x + halfWidthLandScape,
                                                  self.landscapeViewFrame.origin.y + halfHeightLandScape,
                                                  halfWidthLandScape,
                                                  halfHeightLandScape);
         NSValue *landscapeLayoutValue = [NSValue valueWithCGRect:landscapeLayoutFrame];

         CGRect portraitLayoutFrame = CGRectMake(self.portraitViewFrame.origin.x + halfWidthPortrait,
                                                 self.portraitViewFrame.origin.y + halfHeightPortrait,
                                                 halfWidthPortrait,
                                                 halfHeightPortrait);
         NSValue *portraitLayoutValue = [NSValue valueWithCGRect:portraitLayoutFrame];

         [self.playerLayout addEntriesFromDictionary:@{
             @(3): @{
                 @(UIInterfaceOrientationLandscapeLeft): landscapeLayoutValue,
                 @(UIInterfaceOrientationLandscapeRight): landscapeLayoutValue,
                 @(UIInterfaceOrientationPortrait): portraitLayoutValue,
                 @(UIInterfaceOrientationPortraitUpsideDown): portraitLayoutValue,
             }.mutableCopy,
         }];
    }
}

+ (NSInteger)maxPlayerCount {
    return kAPDDPlayerLayoutModelMaxPlayerCount;
}



@end
