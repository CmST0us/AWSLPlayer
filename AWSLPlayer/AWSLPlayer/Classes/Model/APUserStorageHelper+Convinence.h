//
//  APUserStorageHelper+Convinence.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APUserStorageHelper.h"
#import "APModelStorageContainer.h"
NS_ASSUME_NONNULL_BEGIN

@class APModelStorageContainer;
@interface APUserStorageHelper (Convinence)
+ (APModelStorageContainer *)modelStorageContainer;
@end

NS_ASSUME_NONNULL_END
