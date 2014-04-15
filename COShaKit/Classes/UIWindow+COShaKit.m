//
//  UIWindow+RageShake.m
//  RageShake
//
//  Created by Jeff Kim on 4/9/14.
//  Copyright (c) 2014 Coursera. All rights reserved.
//

#import "UIWindow+COShakit.h"
#import "COShaKitManager.h"

@interface UIWindow ()
@end

@implementation UIWindow (RageShake)
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [[COShaKitManager sharedManager] showShaKitAlert];
    }
}
@end
