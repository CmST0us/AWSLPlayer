//
//  APFilePathHelper.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/7/21.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APFilePathHelper.h"

@implementation APFilePathHelper
MAKE_CLASS_SINGLETON(APFilePathHelper, instance, sharedInstance)

- (NSString *)documentPath {
    static NSString *documentPath;
    if (documentPath == nil) {
        documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return documentPath;
}

- (NSString *)fileSavePathWithFileName:(NSString *)filename {
    NSString *documentPath = [self documentPath];
    return [documentPath stringByAppendingPathComponent:filename];
}

@end
