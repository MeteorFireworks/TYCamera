//
//  UINavigationController+ModifyStatusBarStyle.m
//  Test
//
//  Created by anzheng on 2017/4/5.
//  Copyright © 2017年 anzheng. All rights reserved.
//

#import "UINavigationController+ModifyStatusBarStyle.h"

@implementation UINavigationController (ModifyStatusBarStyle)
- (UIStatusBarStyle)preferredStatusBarStyle{
    return [[self topViewController] preferredStatusBarStyle];
}
@end
