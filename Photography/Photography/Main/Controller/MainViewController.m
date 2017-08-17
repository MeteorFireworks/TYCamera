//
//  MainViewController.m
//  Photography
//
//  Created by anzheng on 2017/8/8.
//  Copyright © 2017年 anzheng. All rights reserved.
//

#import "MainViewController.h"
#import "GuideView.h"
#import "TYButton.h"
#import "TYPhotoAlbumTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //取消内嵌机制
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置导航栏返回文字
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    //加载引导页处理
    [self creatGuideView];
    
    //按钮
    [self createBtnView];
}

#pragma mark ---- 引导页
- (void)creatGuideView {
    //引导页实例化
    GuideView *view = [GuideView sharedWithImages:@[@"1",@"2",@"3"] andLaunchImgName:@"4"];
    [self.view addSubview:view];
}

#pragma mark ---- 按钮布局
- (void)createBtnView {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight)];
    imgView.image = [UIImage imageNamed:@"bg_home@2x.jpg"];
    imgView.userInteractionEnabled = YES;
    [self.view insertSubview:imgView atIndex:0];
    
    NSArray *imageViewImageArr = [NSArray arrayWithObjects:
                                  @"icon_home_beauty@2x.png", @"icon_home_cosmesis@2x.png", @"icon_home_meiyan@2x.png",
                                  @"icon_home_camera@2x.png", nil];
    
    NSArray *highLightedBackImageArr = [NSArray arrayWithObjects:
                                        @"home_block_red_b@2x.png", @"home_block_pink_b@2x.png",
                                        @"item_bg_purple_b@2x.png",@"home_block_orange_b@2x.png", nil];
    NSArray *imageViewBackImageArr = [NSArray arrayWithObjects:
                                      @"home_block_red_a@2x.png", @"home_block_pink_a@2x.png", @"item_bg_purple_a@2x.png",
                                      @"home_block_orange_a@2x.png", nil];
    
    NSArray *textArr = [NSArray arrayWithObjects:@"美化图片", @"人像美容", @"美颜相机", @"万能相机", nil];
    
    NSInteger row = textArr.count / 2;
    NSInteger col = textArr.count / 2;
    CGFloat width = 103;
    CGFloat height = 105;
    CGFloat spaceRow = ((KMainScreenWidth - width*2 - 100) > 0) ? (KMainScreenWidth - width*2 - 100) : 5;
    CGFloat spaceCol = ((KMainScreenHeight - height*2 - 300) > 0) ? (KMainScreenHeight - height*2 - 300) : 5;
    
    int k=0;
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            TYButton *btn = [TYButton button];
            btn.frame = CGRectMake(50 + j*width + j*spaceRow, 150+ i*height + i*spaceCol, width, height);
            [btn setTitle:[textArr objectAtIndex:k] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[imageViewImageArr objectAtIndex:k]] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[imageViewBackImageArr objectAtIndex:k]]]];
            [btn setBackgroundColorHighlighted:[UIColor colorWithPatternImage:[UIImage imageNamed:[highLightedBackImageArr objectAtIndex:k]]]];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.topPading = 0.5;
            [imgView addSubview:btn];
            k++;
        }
    }
}
- (void)btnClicked:(id)sender
{
    if ([[(UIButton *)sender titleLabel].text isEqualToString:@"美化图片"]) {
        TYPhotoAlbumTableViewController *vc = [[TYPhotoAlbumTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([[(UIButton *)sender titleLabel].text isEqualToString:@"人像美容"]) {
        NSLog(@"+++++++");
    }
    else if([[(UIButton *)sender titleLabel].text isEqualToString:@"美颜相机"]) {
        
    }
    else if ([[(UIButton *)sender titleLabel].text isEqualToString:@"万能相机"]) {
        NSLog(@"<<<<<<<<<<<<");
    }
}

//设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
