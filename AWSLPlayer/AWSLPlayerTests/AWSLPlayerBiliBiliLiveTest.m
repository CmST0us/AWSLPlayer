//
//  AWSLPlayerBiliBiliLiveTest.m
//  AWSLPlayerTests
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APBiliBiliLive.h"
#import "APMacroHelper.h"

@interface AWSLPlayerBiliBiliLiveTest : XCTestCase
@property (nonatomic, strong) APBiliBiliLive *bilibiliLive;
@end

@implementation AWSLPlayerBiliBiliLiveTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.bilibiliLive = [[APBiliBiliLive alloc] initWithRoomID:197];
}

- (void)testRequestRealRoomID {
    __block BOOL isSuccess = NO;
    [self.bilibiliLive requestRealRoomIDWithCompletion:^(NSInteger realRoomID, NSError * _Nonnull error) {
        XCTAssert(error == nil);
        NSLog(@"RoomID: %lu", realRoomID);
        isSuccess = YES;
    }];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    if (!isSuccess) {
        XCTFail(@"Fail");
    }
}

- (void)testRequestPlayURL {
    __block BOOL isSuccess = NO;
    weakSelf(self);
    [self.bilibiliLive requestRealRoomIDWithCompletion:^(NSInteger realRoomID, NSError * _Nonnull error) {
        XCTAssert(error == nil);
        NSLog(@"RoomID: %lu", realRoomID);
        [weakSelf.bilibiliLive requestPlayURLWithCompletion:^(NSArray<NSString *> * _Nullable playUrls, NSError * _Nullable error) {
            if (error == nil && playUrls != nil) {
                [playUrls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSLog(@"PlayURL: %@", obj);
                }];
                isSuccess = YES;
            }
        }];
    }];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    if (!isSuccess) {
        XCTFail(@"Fail");
    }
}
@end
