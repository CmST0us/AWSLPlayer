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
#define kAPModelStorageDefaultLiveFolderKey @"Default"

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

+ (APModelStorageContainer *)defaultValue {
    APModelStorageContainer *defaultConfig = [[APModelStorageContainer alloc] init];
    
    APLiveURLModel *liveURL = [[APLiveURLModel alloc] init];
    liveURL.urlType = APLiveURLTypeYoutube;
    liveURL.name = kAPModelStorageDefaultLiveURLName;
    liveURL.liveURL = [NSURL URLWithString:kAPModelStorageDefaultLiveURL];
    
    APLiveURLFolderModel *defaultFolder = [[APLiveURLFolderModel alloc] init];
    defaultFolder.name = NSLocalizedString(@"ap_default", nil);
    defaultFolder.liveURLs = @[liveURL];
    
    [defaultConfig.liveURLs setObject:liveURL forKey:liveURL.name];
    [defaultConfig.liveURLFolders setObject:defaultFolder forKey:kAPModelStorageDefaultLiveFolderKey];
    
    return defaultConfig;
}


@end