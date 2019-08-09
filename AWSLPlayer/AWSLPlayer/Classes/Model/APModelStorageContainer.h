//
//  APModelStorageContainer.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/3.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APUserStorageHasDefaultProtocol.h"
#import "APLiveURLFolderModel.h"
#import "APLiveURLModel.h"
#import "APDDPlayerModel.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString * const APModelStorageDefaultLiveFolderKey;

@interface APModelStorageContainer : NSObject <NSCoding, APUserStorageHasDefaultProtocol>
@property (nonatomic, readonly) NSMutableDictionary<NSString *, APLiveURLModel *> *liveURLs;
@property (nonatomic, readonly) NSMutableDictionary<NSString *, APLiveURLFolderModel *> *liveURLFolders;
@property (nonatomic, readonly) NSMutableDictionary<NSString *, APDDPlayerModel *> *players;

- (APLiveURLFolderModel *)defaultFolder;
- (void)addLiveURL:(APLiveURLModel *)model inFolder:(APLiveURLFolderModel *)folderModel;

- (void)addPlayer:(APDDPlayerModel *)aPlayer;
@end

NS_ASSUME_NONNULL_END
