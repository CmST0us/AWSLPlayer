//
//  APButton.m
//  AWSLPlayer
//
//  Created by CmST0us on 2019/8/4.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "APButton.h"

@implementation APButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect hitTect = CGRectMake(0 - self.extraTouchInsets.left,
                                0 - self.extraTouchInsets.top,
                                self.extraTouchInsets.left + self.bounds.size.width + self.extraTouchInsets.right,
                                self.extraTouchInsets.top + self.bounds.size.height + self.extraTouchInsets.bottom);
    if (CGRectContainsPoint(hitTect, point)) {
        return self;
    }
    return nil;
}

@end
