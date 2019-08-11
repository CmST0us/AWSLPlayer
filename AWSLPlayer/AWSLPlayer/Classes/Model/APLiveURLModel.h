//
//  APLiveURLModel.h
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class APPlatformLiveURLProcessor;
typedef NS_ENUM(NSUInteger, APLiveURLType) {
    APLiveURLTypeRaw, // 未选择
    
    APLiveURLTypeBiliBili,
    APLiveURLTypeYoutube,
    APLiveURLTypeHibikiRadio,
    APLiveURLTypeLineLive,
    APLiveURLTypeNicoNico
};

@interface APLiveURLModel : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSURL *liveURL;
@property (nonatomic, strong) NSString *folderName;
@property (nonatomic, assign) APLiveURLType urlType;

// just hold liveURL processor
@property (nonatomic, readonly) Class processorClass;
@property (nonatomic, strong, nullable) APPlatformLiveURLProcessor *processor;
@end

NS_ASSUME_NONNULL_END
