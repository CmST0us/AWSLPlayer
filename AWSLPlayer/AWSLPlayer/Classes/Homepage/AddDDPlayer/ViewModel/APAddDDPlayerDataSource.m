//
//  APAddDDPlayerDataSource.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/17.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "NSString+Unique.h"
#import "APUserStorageHelper+Convinence.h"
#import "APDDPlayerModel.h"
#import "APDDPlayerLayoutModel.h"
#import "APAddDDPlayerDataSource.h"

@interface APAddDDPlayerDataSource ()
@property (nonatomic, strong) APDDPlayerModel *ddPlayerModel;
@property (nonatomic, strong) NSIndexSet *selectedIndex;
@end

@implementation APAddDDPlayerDataSource

#pragma mark - Init

#pragma mark - Lazy
- (APDDPlayerModel *)ddPlayerModel {
    if (_ddPlayerModel == nil) {
        _ddPlayerModel = [[APDDPlayerModel alloc] init];
        _selectedIndex = [[NSIndexSet alloc] init];
    }
    return _ddPlayerModel;
}

- (NSString *)modelKey {
    if (_modelKey == nil || _modelKey.length == 0) {
        _modelKey = [NSString uniqueString];
    }
    return _modelKey;
}

#pragma mark - Getter Setter
- (NSString *)name {
    return self.ddPlayerModel.name;
}

- (void)setName:(NSString *)name {
    self.ddPlayerModel.name = name;
}

- (NSArray<APLiveURLModel *> *)allLiveRoom {
    return [[APUserStorageHelper modelStorageContainer].liveURLs allValues];
}

- (NSArray<APLiveURLModel *> *)selectedLiveRoom {
    return [self.allLiveRoom objectsAtIndexes:self.selectedIndex];
}

#pragma mark - Private

#pragma mark - Method
- (void)editModel:(APDDPlayerModel *)model withModelKey:(nonnull NSString *)modelKey {
    self.ddPlayerModel = model;
    self.modelKey = modelKey;
    NSMutableIndexSet *select = [[NSMutableIndexSet alloc] init];
    [NSAllMapTableKeys(self.ddPlayerModel.liveURLs) enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger i = [self.allLiveRoom indexOfObject:obj];
        if (i != NSNotFound) {
            [select addIndex:i];
        }
    }];
    self.selectedIndex = select;
}

- (void)useLiveURLsWithIndexs:(NSIndexSet *)indexs {
    self.selectedIndex = indexs;
}

- (void)save {
    NSMapTable *liveRooms = [NSMapTable strongToWeakObjectsMapTable];
    [self.selectedLiveRoom enumerateObjectsUsingBlock:^(APLiveURLModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [liveRooms setObject:obj forKey:@(idx)];
    }];
    self.ddPlayerModel.liveURLs = liveRooms;
    [self.ddPlayerModel.layoutModel setupWithPlayerCount:liveRooms.count];
    [[APUserStorageHelper modelStorageContainer] addPlayer:self.ddPlayerModel forKey:self.modelKey];
}

#pragma mark - Slot

#pragma mark - Action

#pragma mark - Life Cycle


@end

@implementation APAddDDPlayerDataSource (SectionRows)

- (NSArray<NSString *> *)sectionTitles {
    static NSArray *sectionTitles = nil;
    if (sectionTitles != nil) return sectionTitles;
    sectionTitles = @[
                        NSLocalizedString(@"ap_add_dd_player_player_name", nil),
                        NSLocalizedString(@"ap_add_dd_player_selected_live_url", nil),
                        @"",
                     ];
    return sectionTitles;
}

- (NSInteger)numberOfRowInSection:(NSInteger)section {
    if (section == APAddDDPlayerSectionName) {
        return 1;
    } else if (section == APAddDDPlayerSectionSelected) {
        return [self.selectedIndex count];
    } else if (section == APAddDDPlayerSectionSelectButton) {
        return 1;
    }
    return 0;
}
@end
