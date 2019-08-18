//
//  NSString+Unique.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/18.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "NSString+Unique.h"

@implementation NSString (Unique)
+ (NSString *)uniqueString {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}
@end
