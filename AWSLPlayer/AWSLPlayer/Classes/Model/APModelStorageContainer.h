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
@property (nonatomic, readonly) NSMutableDictionary<NSString *, APDDPlayerModel *> *players;

- (void)addLiveURL:(APLiveURLModel *)model forKey:(NSString *)aKey;
- (void)addPlayer:(APDDPlayerModel *)aPlayer forKey:(NSString *)aKey;

- (void)removeLiveURLWithKey:(NSString *)aKey;
- (void)removePlayerWithKey:(NSString *)aKey;
@end

NS_ASSUME_NONNULL_END
