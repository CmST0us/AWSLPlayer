//
//  APUserStorageHasDefaultProtocol.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/3.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol APUserStorageHasDefaultProtocol <NSObject>
@required
+ (id)defaultValue;
@end

NS_ASSUME_NONNULL_END
