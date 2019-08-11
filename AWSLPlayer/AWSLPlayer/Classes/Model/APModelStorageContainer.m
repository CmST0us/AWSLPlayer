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

#define kAPModelStorageDefaultLiveURL @"https://www.youtube.com/watch?v=vrwSrCr9J4s"
#define kAPModelStorageDefaultLiveURLName @"24時間"

NSString * const APModelStorageDefaultLiveFolderKey = @"Default";

@interface APModelStorageContainer ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, APLiveURLModel *> *liveURLs;
@property (nonatomic, strong) NSMutableDictionary<NSString *, APLiveURLFolderModel *> *liveURLFolders;
@property (nonatomic, strong) NSMutableDictionary<NSString *, APDDPlayerModel *> *players;
@end

@implementation APModelStorageContainer
- (instancetype)init {
    self = [super init];
    if (self) {
        _liveURLs = [NSMutableDictionary dictionary];
        _liveURLFolders = [NSMutableDictionary dictionary];
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
        
        dict = [coder decodeObjectForKey:@"liveURLFolders"];
        if (dict != nil &&
            ([dict isKindOfClass:[NSDictionary class]] ||
             [dict isKindOfClass:[NSMutableDictionary class]])) {
            [_liveURLFolders addEntriesFromDictionary:dict];
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
    [coder encodeObject:self.liveURLFolders forKey:@"liveURLFolders"];
    [coder encodeObject:self.players forKey:@"players"];
}

#pragma mark - Live URL

- (void)addLiveURL:(APLiveURLModel *)model inFolder:(APLiveURLFolderModel *)folderModel {
    if ([folderModel.name isEqualToString:self.liveURLFolders[APModelStorageDefaultLiveFolderKey].name]) {
        // Default Folder
        model.folderName = APModelStorageDefaultLiveFolderKey;
        [self.liveURLFolders[APModelStorageDefaultLiveFolderKey].liveURLs addObject:model];
    } else {
        model.folderName = folderModel.name;
        APLiveURLFolderModel *targetFolder = [self.liveURLFolders objectForKey:folderModel.name];
        if (targetFolder == nil) {
            targetFolder = [[APLiveURLFolderModel alloc] init];
            targetFolder.name = folderModel.name;
            targetFolder.liveURLs = [[NSMutableArray alloc] init];
            [self.liveURLFolders setObject:targetFolder forKey:targetFolder.name];
        }
        [targetFolder.liveURLs addObject:model];
    }
    [self.liveURLs setObject:model forKey:model.name];
}


#pragma mark - DD Player
- (void)addPlayer:(APDDPlayerModel *)aPlayer {
    if (aPlayer == nil) return;
    NSString *playName = aPlayer.name;
    [self.players setObject:aPlayer forKey:playName];
}

#pragma mark - Default
- (APLiveURLFolderModel *)defaultFolder {
    return [self.liveURLFolders objectForKey:APModelStorageDefaultLiveFolderKey];
}

+ (id)defaultValue {
    APModelStorageContainer *defaultConfig = [[APModelStorageContainer alloc] init];
    
    APLiveURLModel *liveURL1 = [[APLiveURLModel alloc] init];
    liveURL1.urlType = APLiveURLTypeBiliBili;
    liveURL1.name = @"daishu";
    liveURL1.folderName = APModelStorageDefaultLiveFolderKey;
    liveURL1.liveURL = [NSURL URLWithString:@"https://live.bilibili.com/45190"];
    
    APLiveURLModel *liveURL2 = [[APLiveURLModel alloc] init];
    liveURL2.urlType = APLiveURLTypeBiliBili;
    liveURL2.name = @"hoho";
    liveURL2.folderName = APModelStorageDefaultLiveFolderKey;
    liveURL2.liveURL = [NSURL URLWithString:@"https://live.bilibili.com/629869?visit_id=lsp2s55tr80"];
    
    APLiveURLModel *liveURL3 = [[APLiveURLModel alloc] init];
    liveURL3.urlType = APLiveURLTypeBiliBili;
    liveURL3.name = kAPModelStorageDefaultLiveURLName;
    liveURL3.folderName = APModelStorageDefaultLiveFolderKey;
    liveURL3.liveURL = [NSURL URLWithString:@"https://live.bilibili.com/43001?visit_id=lsp2s55tr80"];
    
    APLiveURLModel *liveURL4 = [[APLiveURLModel alloc] init];
    liveURL4.urlType = APLiveURLTypeBiliBili;
    liveURL4.name = @"空间站";
    liveURL4.folderName = APModelStorageDefaultLiveFolderKey;
    liveURL4.liveURL = [NSURL URLWithString:@"https://live.bilibili.com/14047?spm_id_from=333.334.b_62696c695f6c697665.9"];
    
    APLiveURLFolderModel *defaultFolder = [[APLiveURLFolderModel alloc] init];
    defaultFolder.name = NSLocalizedString(@"ap_default", nil);
    defaultFolder.liveURLs = [NSMutableArray arrayWithArray:@[liveURL1, liveURL2, liveURL3, liveURL4]];
    
    APDDPlayerModel *player = [[APDDPlayerModel alloc] init];
    player.liveURLs = @{
        @(0): liveURL1,
        @(1): liveURL2,
        @(2): liveURL3,
        @(3): liveURL4
    };
    player.name = kAPModelStorageDefaultLiveURLName;
    
    [defaultConfig.players setObject:player forKey:player.name];
    [defaultConfig.liveURLs setObject:liveURL1 forKey:liveURL1.name];
    [defaultConfig.liveURLs setObject:liveURL2 forKey:liveURL2.name];
    [defaultConfig.liveURLs setObject:liveURL3 forKey:liveURL3.name];
    [defaultConfig.liveURLs setObject:liveURL4 forKey:liveURL4.name];
    [defaultConfig.liveURLFolders setObject:defaultFolder forKey:APModelStorageDefaultLiveFolderKey];
    
    return defaultConfig;
}

@end
