//
//  AWSLPlayerTests.m
//  AWSLPlayerTests
//
//  Created by CmST0us on 2019/7/14.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APBiliBiliURLSession.h"

@interface AWSLPlayerBiliBiliNetworkRequestsTests : XCTestCase
@property (nonatomic, strong) APBiliBiliURLSession *currentSession;
@end

@implementation AWSLPlayerBiliBiliNetworkRequestsTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testRequestRealRoomID {
    NSUInteger requestedRoomID = 1221;
    self.currentSession = [[APBiliBiliURLSession alloc] init];
    __block BOOL isSuccess = NO;
    [self.currentSession requestRealRoomID:requestedRoomID completion:^(NSInteger realRoomID, NSError * _Nonnull error) {
        XCTAssert(error == nil);
        NSLog(@"RoomID: %lu", realRoomID);
        isSuccess = YES;;
    }];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    XCTAssert(isSuccess);
}

@end
