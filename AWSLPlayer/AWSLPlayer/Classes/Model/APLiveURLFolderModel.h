//
//  APLiveURLFolderModel.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class APLiveURLModel;
@interface APLiveURLFolderModel : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong, nonnull) NSArray<APLiveURLModel *> *liveURLs;
@end

NS_ASSUME_NONNULL_END
