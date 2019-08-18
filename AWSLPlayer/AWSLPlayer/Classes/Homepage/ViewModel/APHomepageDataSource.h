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
    APHomepageDataSourceSectionTypeLiveURL = 1,
};

@interface APHomepageDataSource : NSObject

@property (nonatomic, readonly) NSDictionary<NSString *, APLiveURLModel *> *liveURLs;
@property (nonatomic, readonly) NSDictionary<NSString *, APDDPlayerModel *> *players;
@property (nonatomic, weak) APModelStorageContainer *container;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowInSection:(APHomepageDataSourceSectionType)section;
- (NSString *)titleForSection:(APHomepageDataSourceSectionType)secion;

- (void)removeLiveURLWithKey:(NSString *)aKey;
- (void)removePlayerWithKey:(NSString *)aKey;
@end

NS_ASSUME_NONNULL_END
