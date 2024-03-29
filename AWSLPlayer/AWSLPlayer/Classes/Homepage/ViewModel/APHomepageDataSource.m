//
//  APHomepageDataSource.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/24.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APUserStorageHelper+Convinence.h"
#import "APHomepageDataSource.h"

@interface APHomepageDataSource ()

@end

@implementation APHomepageDataSource

- (NSDictionary<NSString *,APLiveURLModel *> *)liveURLs {
    return self.container.liveURLs;
}

- (NSDictionary<NSString *,APDDPlayerModel *> *)players {
    return self.container.players;
}

- (APModelStorageContainer *)container {
    return [APUserStorageHelper modelStorageContainer];
}

- (NSArray<NSString *> *)titles {
    static NSArray<NSString *> *t = nil;
    if (t == nil) {
        t = @[
              NSLocalizedString(@"ap_homepage_section_title_dd_player", nil),
              NSLocalizedString(@"ap_homepage_section_title_live_url", nil)
              ];
    }
    return t;
}

- (NSInteger)numberOfSections {
    return [self titles].count;
}

- (NSInteger)numberOfRowInSection:(APHomepageDataSourceSectionType)section {
    if (section == APHomepageDataSourceSectionTypeDDPlayer) {
        return self.container.players.count;
    } else if (section == APHomepageDataSourceSectionTypeLiveURL) {
        return self.container.liveURLs.count;
    }
    return 0;
}

- (NSString *)titleForSection:(APHomepageDataSourceSectionType)section {
    NSAssert(section < [self titles].count, @"section out of range");
    return [self titles][section];
}

- (void)removePlayerWithKey:(NSString *)aKey {
    [[APUserStorageHelper modelStorageContainer] removePlayerWithKey:aKey];
}

- (void)removeLiveURLWithKey:(NSString *)aKey {
    [[APUserStorageHelper modelStorageContainer] removeLiveURLWithKey:aKey];
}

@end
