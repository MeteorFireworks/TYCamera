//
//  GuideView.h
//  Photography
//
//  Created by anzheng on 2017/8/8.
//  Copyright © 2017年 anzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideView : UIView
/**
 *  滑动到最后一页，再向右滑直接隐藏引导页
 *
 *  @param imageNames 背景图片数组
 *
 *  @param  launchImgName 启动图片
 *  @return   LaunchIntroductionView对象
 */
+ (instancetype)sharedWithImages:(NSArray *)imageNames andLaunchImgName:(NSString *)launchImgName;
@end
