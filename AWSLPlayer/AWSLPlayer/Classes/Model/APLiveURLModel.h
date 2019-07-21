//
//  APLiveURLModel.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, APLiveURLType) {
    APLiveURLTypeBiliBili,
    APLiveURLTypeYoutube,
    APLiveURLTypeHibikiRadio,
    APLiveURLTypeLineLive,
    APLiveURLTypeNicoNico
};

@interface APLiveURLModel : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSURL *liveURL;
@property (nonatomic, assign) APLiveURLType urlType;
@end

NS_ASSUME_NONNULL_END
