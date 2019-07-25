//
//  APHomepageDataSource.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/24.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APUserDefaultHelper.h"
#import "APHomepageDataSource.h"

@interface APHomepageDataSource ()
@property (nonatomic, strong) NSMutableArray *mutableLiveURLs;
@property (nonatomic, strong) NSMutableArray *mutableLiveURLFolder;
@end

@implementation APHomepageDataSource

- (NSArray<NSString *> *)titles {
    static NSArray<NSString *> *t = nil;
    if (t == nil) {
        t = @[
              NSLocalizedString(@"ap_homepage_section_title_dd_player", nil),
              NSLocalizedString(@"ap_homepage_section_title_live_url_folder", nil),
              NSLocalizedString(@"ap_homepage_section_title_live_url", nil)
              ];
    }
    return t;
}

- (NSArray<APLiveURLModel *> *)liveURLs {
    if (_mutableLiveURLs == nil) {
        NSMutableArray *ta = [NSMutableArray array];
        [self.liveURLFolders enumerateObjectsUsingBlock:^(APLiveURLFolderModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.liveURLs enumerateObjectsUsingBlock:^(APLiveURLModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ta addObject:obj];
            }];
        }];
        _mutableLiveURLs = ta;
    }
    return _mutableLiveURLs;
}

- (NSArray<APLiveURLFolderModel *> *)liveURLFolders {
    if (_mutableLiveURLFolder == nil) {
        _mutableLiveURLFolder = [[APUserDefaultHelper sharedInstance] mutableArrayObjectWithKey:APLiveURLFolderModelsKey];
    }
    return _mutableLiveURLFolder;
}

- (void)reloadData {
    _mutableLiveURLs = nil;
    _mutableLiveURLFolder = nil;
}

- (NSInteger)numberOfSections {
    return [self titles].count;
}

- (NSInteger)numberOfRowInSection:(APHomepageDataSourceSectionType)section {
    if (section == APHomepageDataSourceSectionTypeDDPlayer) {
        return 0;
    } else if (section == APHomepageDataSourceSectionTypeFolder) {
        return self.liveURLFolders.count;
    } else if (section == APHomepageDataSourceSectionTypeLiveURL) {
        return self.liveURLs.count;
    }
    return 0;
}

- (NSString *)titleForSection:(APHomepageDataSourceSectionType)section {
    NSAssert(section < [self titles].count, @"section out of range");
    return [self titles][section];
}

- (void)removeLiveURLsAtIndex:(NSInteger)index {
    [self.mutableLiveURLs removeObjectAtIndex:index];
    [[APUserDefaultHelper sharedInstance] setObject:self.mutableLiveURLs forKey:APLiveURLFolderModelsKey];
}

@end
