//
//  APAddDDPlayerDataSource.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/17.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 Section 0:
    name;
 Section 1:
    select url;
 
 Section 2:
    select button;
 */

typedef NS_ENUM(NSUInteger, APAddDDPlayerSection) {
    APAddDDPlayerSectionName,
    APAddDDPlayerSectionSelected,
    APAddDDPlayerSectionSelectButton,
};

@class APDDPlayerModel;
@class APLiveURLModel;
@interface APAddDDPlayerDataSource : NSObject
@property (nonatomic, readonly) APDDPlayerModel *ddPlayerModel;
@property (nonatomic, readonly) NSIndexSet *selectedIndex;
@property (nonatomic, readwrite) NSString *name;

- (NSArray<APLiveURLModel *> *)allLiveRoom;
- (NSArray<APLiveURLModel *> *)selectedLiveRoom;

- (void)editModel:(APDDPlayerModel *)model;
- (void)useLiveURLsWithIndexs:(NSIndexSet *)indexs;
- (void)save;
@end


@interface APAddDDPlayerDataSource (SectionRows)
- (NSArray<NSString *> *)sectionTitles;
- (NSInteger)numberOfRowInSection:(NSInteger)section;
@end
NS_ASSUME_NONNULL_END
