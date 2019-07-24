//
//  APHomepageDataSource.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/24.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import <Foundation/Foundation.h>
#import "APLiveURLModel.h"
#import "APDDPlayerModel.h"
#import "APLiveURLFolderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, APHomepageDataSourceSectionType) {
    APHomepageDataSourceSectionTypeDDPlayer,
    APHomepageDataSourceSectionTypeFolder,
    APHomepageDataSourceSectionTypeLiveURL,
};

@interface APHomepageDataSource : NSObject

@property (nonatomic, readonly) NSArray<APLiveURLModel *> *liveURLs;
@property (nonatomic, readonly) NSArray<APLiveURLFolderModel *> *liveURLFolders;
- (void)reloadData;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowInSection:(APHomepageDataSourceSectionType)section;
- (NSString *)titleForSection:(APHomepageDataSourceSectionType)secion;

- (void)removeLiveURLsAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
