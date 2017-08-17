//
//  FWDisplayBigImageViewController.m
//  FWLifeApp
//
//  Created by Forrest Woo on 16/9/13.
//  Copyright © 2016年 ForrstWoo. All rights reserved.
//

#import "TYDisplayBigImageViewController.h"
#import "TYBeautyViewController.h"
#import "MBProgressHUD.h"

@interface TYDisplayBigImageViewController ()
{
    UIScrollView *_scrollView;
    UIToolbar *_toolBar;
    UIImageView *_imageView;
    BOOL _oldBounces;
    MBProgressHUD *_HUD;
}

@end

@implementation TYDisplayBigImageViewController

- (id)initWithImage:(UIImage *)image
{
    if (self = [super init])
    {
        self.image = image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //关闭内嵌模式
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor =[UIColor blackColor];
    
    [self initScrollView];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.tag = 888;
    [_scrollView addSubview:_imageView];
    
    _imageView.image = self.image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGes.numberOfTapsRequired = 1;
    [_imageView addGestureRecognizer:tapGes];
    
    UITapGestureRecognizer* t = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(doubleClicked:)];
    t.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:t];
    
    [self initToolBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)initToolBar
{
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 44)];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(10, 10, 60, 24);
    leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [leftBtn setTitle:@"美化" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(editImage:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(KMainScreenWidth-10-60 , 10, 60, 24);
    [rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:rightBtn];
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, KMainScreenHeight - 44, KMainScreenWidth, 44)];
    _toolBar.hidden = NO;
    [_toolBar addSubview:toolView];

    [self.view addSubview:_toolBar];
}

- (void)editImage:(id)sender
{
    NSLog(@">>>>>>");
//    TYBeautyViewController *beautyVC = [[TYBeautyViewController alloc] initWithImage:self.image];
//    [self.navigationController pushViewController:beautyVC animated:YES];
}

- (void)deleteImage:(id)sender
{ 
    NSLog(@">>>>>>");
//    TYBeautyViewController *beautyVC = [[TYBeautyViewController alloc] initWithImage:self.image];
//    [self.navigationController pushViewController:beautyVC animated:YES];
}

- (void)downloadImage:(id)sender
{
   UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeText;
    if(error != NULL){
        _HUD.label.text = @"保存失败";
    }else{
         _HUD.label.text = @"保存成功";
    }
    [_HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2.0);
    } completionBlock:^{
        [_HUD removeFromSuperview];
    }];
}
- (void)initScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.maximumZoomScale = 3;
    _scrollView.minimumZoomScale = 1;
    _scrollView.bouncesZoom = NO;
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    _oldBounces = scrollView.bounces;
    scrollView.bounces = NO;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    scrollView.bounces =_oldBounces;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:888];
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
    if (self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [UIView animateWithDuration:10.0 animations:^{
            _toolBar.frame = CGRectMake(0, KMainScreenHeight, KMainScreenWidth, 44);
        } completion:^(BOOL finished) {
            _toolBar.frame = CGRectMake(0, KMainScreenHeight - 44, KMainScreenWidth, 44);
        }];
        
    }
    
    else
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
            _toolBar.frame = CGRectMake(0, KMainScreenHeight - 44, KMainScreenWidth, 44);
        } completion:^(BOOL finished) {
            _toolBar.frame = CGRectMake(0, KMainScreenHeight, KMainScreenWidth, 44);
        }];

    }
}

- (void)doubleClicked:(UIGestureRecognizer *)gesture
{
    UIView* v = gesture.view;
    
    UIScrollView* sv = (UIScrollView*)v.superview;
    if (sv.zoomScale < 1) {
        [sv setZoomScale:1 animated:YES];
        CGPoint pt = CGPointMake((v.bounds.size.width - sv.bounds.size.width)/2.0,0);
        [sv setContentOffset:pt animated:NO];
    }
    else if (sv.zoomScale < sv.maximumZoomScale){
        [sv setZoomScale:sv.maximumZoomScale animated:YES];
        CGRect frm=sv.frame;
        frm.size.height+=_toolBar.frame.size.height;
        sv.frame=frm;
        _toolBar.hidden = YES;
    }
    else{
        [sv setZoomScale:sv.minimumZoomScale animated:YES];
        _toolBar.hidden = NO;
        CGRect frm=sv.frame;
        frm.size.height-=_toolBar.frame.size.height;
        sv.frame=frm;
    }

}

@end
