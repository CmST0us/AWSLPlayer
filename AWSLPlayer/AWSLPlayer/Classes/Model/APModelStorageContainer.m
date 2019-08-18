//
//  APModelStorageContainer.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/3.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APLiveURLModel.h"
#import "APLiveURLFolderModel.h"
#import "APModelStorageContainer.h"
#import "NSString+Unique.h"

#define kAPModelStorageDefaultLiveURL @"https://www.youtube.com/watch?v=vrwSrCr9J4s"
#define kAPModelStorageDefaultLiveURLName @"24時間"

NSString * const APModelStorageDefaultLiveFolderKey = @"Default";

@interface APModelStorageContainer ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, APLiveURLModel *> *liveURLs;
@property (nonatomic, strong) NSMutableDictionary<NSString *, APDDPlayerModel *> *players;
@end

@implementation APModelStorageContainer
- (instancetype)init {
    self = [super init];
    if (self) {
        _liveURLs = [NSMutableDictionary dictionary];
        _players = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        NSDictionary *dict = [coder decodeObjectForKey:@"liveURLs"];
        if (dict != nil &&
            ([dict isKindOfClass:[NSDictionary class]] ||
             [dict isKindOfClass:[NSMutableDictionary class]])) {
            [_liveURLs addEntriesFromDictionary:dict];
        }
        
        dict = [coder decodeObjectForKey:@"players"];
        if (dict != nil &&
            ([dict isKindOfClass:[NSDictionary class]] ||
             [dict isKindOfClass:[NSMutableDictionary class]])) {
            [_players addEntriesFromDictionary:dict];
        }

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.liveURLs forKey:@"liveURLs"];
    [coder encodeObject:self.players forKey:@"players"];
}

#pragma mark - Live URL

- (void)addLiveURL:(APLiveURLModel *)model forKey:(NSString *)aKey {
    model.folderName = APModelStorageDefaultLiveFolderKey;
    [self.liveURLs setObject:model forKey:aKey];
}

- (void)removeLiveURLWithKey:(NSString *)aKey {
    [self.liveURLs removeObjectForKey:aKey];
}

#pragma mark - DD Player
- (void)addPlayer:(APDDPlayerModel *)aPlayer forKey:(NSString *)aKey{
    if (aPlayer == nil) return;

    [self.players setObject:aPlayer forKey:aKey];
}

- (void)removePlayerWithKey:(NSString *)aKey {
    [self.players removeObjectForKey:aKey];
}

#pragma mark - Default
+ (id)defaultValue {
    APModelStorageContainer *defaultConfig = [[APModelStorageContainer alloc] init];
    
    APLiveURLModel *liveURL = [[APLiveURLModel alloc] init];
    liveURL.urlType = APLiveURLTypeYoutube;
    liveURL.name = kAPModelStorageDefaultLiveURLName;
    liveURL.folderName = APModelStorageDefaultLiveFolderKey;
    liveURL.liveURL = [NSURL URLWithString:kAPModelStorageDefaultLiveURL];
    
    APDDPlayerModel *player = [[APDDPlayerModel alloc] init];
    [player.liveURLs setObject:liveURL forKey:@(0)];
    
    player.name = kAPModelStorageDefaultLiveURLName;
    
    [defaultConfig.players setObject:player forKey:[NSString uniqueString]];
    [defaultConfig.liveURLs setObject:liveURL forKey:[NSString uniqueString]];
    
    return defaultConfig;
}

@end
