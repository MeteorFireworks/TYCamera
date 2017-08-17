//
//  UINavigationController+ModifyStatusBarStyle.h
//  Test
//
//  Created by anzheng on 2017/4/5.
//  Copyright © 2017年 anzheng. All rights reserved.
//

/**
 **  修改状态栏(UIStatusBar)
 **  UINavigationController的扩展，覆盖其默认实现
 **  返回最上面的ViewController的preferredStatusBarStyle
 **/


#import <UIKit/UIKit.h>

@interface UINavigationController (ModifyStatusBarStyle)
- (UIStatusBarStyle)preferredStatusBarStyle;
@end
