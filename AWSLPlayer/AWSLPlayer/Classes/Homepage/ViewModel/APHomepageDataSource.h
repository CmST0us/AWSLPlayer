//
//  APHomepageDataSource.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/24.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import <Foundation/Foundation.h>
#import "APModelStorageContainer.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, APHomepageDataSourceSectionType) {
    APHomepageDataSourceSectionTypeDDPlayer = 0,
    APHomepageDataSourceSectionTypeFolder = -1,
    APHomepageDataSourceSectionTypeLiveURL = 1,
};

@interface APHomepageDataSource : NSObject

@property (nonatomic, readonly) NSArray<APLiveURLModel *> *liveURLs;
@property (nonatomic, readonly) NSArray<APLiveURLFolderModel *> *liveURLFolders;
@property (nonatomic, readonly) NSArray<APDDPlayerModel *> *players;
@property (nonatomic, weak) APModelStorageContainer *container;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowInSection:(APHomepageDataSourceSectionType)section;
- (NSString *)titleForSection:(APHomepageDataSourceSectionType)secion;

- (void)addLiveURLFolders:(APLiveURLFolderModel *)urlFolders;
@end

NS_ASSUME_NONNULL_END
