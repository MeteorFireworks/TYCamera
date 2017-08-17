//
//  GuideView.m
//  Photography
//
//  Created by anzheng on 2017/8/8.
//  Copyright © 2017年 anzheng. All rights reserved.
//

#import "GuideView.h"

static NSString *const kAppVersion = @"appVersion";
@interface GuideView ()<UIScrollViewDelegate>
{
    UIScrollView  *launchScrollView;
    UIPageControl *page;
}
@end

@implementation GuideView
NSArray *imageArr;
NSString *launchImageName;
static GuideView *launch = nil;

#pragma mark - 创建对象
+ (instancetype)sharedWithImages:(NSArray *)imageNames andLaunchImgName:(NSString *)launchImgName{
    imageArr = imageNames;
    launchImageName = launchImgName;
    launch = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight)];
    launch.backgroundColor = [UIColor whiteColor];
    return launch;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self launchIntroduction];
    }
    return self;
}

#pragma mark - 引导页处理
- (void)launchIntroduction {
    BOOL result = [self isFirstLauch];//判断是否首次登录
    if (result) {
        //创建引导页滑动
        launchScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight)];
        launchScrollView.showsHorizontalScrollIndicator = NO;
        launchScrollView.bounces = NO;
        launchScrollView.pagingEnabled = YES;
        launchScrollView.delegate = self;
        launchScrollView.contentSize = CGSizeMake(KMainScreenWidth * imageArr.count, KMainScreenHeight);
        [self addSubview:launchScrollView];
        for (int i = 0; i < imageArr.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * KMainScreenWidth, 0, KMainScreenWidth, KMainScreenHeight)];
            imageView.image = [UIImage imageNamed:imageArr[i]];
            [launchScrollView addSubview:imageView];
        }
        page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, KMainScreenHeight - 50, KMainScreenWidth, 30)];
        page.numberOfPages = imageArr.count;
        page.backgroundColor = [UIColor clearColor];
        page.currentPage = 0;
        page.defersCurrentPageDisplay = YES;
        page.currentPageIndicatorTintColor = [UIColor blackColor];
        page.pageIndicatorTintColor = [UIColor grayColor];
        [self addSubview:page];
    }else {
        if (launchImageName != nil) {
            //创建启动页
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight)];
            imgView.image = [UIImage imageNamed:launchImageName];
            [self addSubview:imgView];
            //移除启动页
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0];
        }
    }
}
- (void)delayMethod {
    [self hideGuidView:2.0];
}

#pragma mark - 判断是不是首次登录或者版本更新
- (BOOL)isFirstLauch{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
    //版本升级或首次登录
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:kAppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - scrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    int cuttentIndex = (int)(scrollView.contentOffset.x + KMainScreenWidth/2)/KMainScreenWidth;
    if (cuttentIndex == imageArr.count - 1) {
        if ([self isScrolltoLeft:scrollView]) {
            [self hideGuidView:2.0];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == launchScrollView) {
        int cuttentIndex = (int)(scrollView.contentOffset.x + KMainScreenWidth/2)/KMainScreenWidth;
        page.currentPage = cuttentIndex;
    }
}

#pragma mark - 判断滚动方向
- (BOOL)isScrolltoLeft:(UIScrollView *)scrollView {
    //返回YES为向左反动，NO为右滚动
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 隐藏引导页
- (void)hideGuidView:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}



@end
