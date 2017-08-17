//
//  FWPhotoCollectionViewController.m
//  FWLifeApp
//
//  Created by Forrest Woo on 16/9/23.
//  Copyright © 2016年 ForrstWoo. All rights reserved.
//

#import "TYPhotoCollectionViewController.h"
#import "TYPhotoCell.h"
#import "TYPhotoManager.h"
#import "TYPhotosLayout.h"
#import "TYDisplayBigImageViewController.h"

@interface TYPhotoCollectionViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    NSArray<PHAsset *> *_dataSouce;
}
@property (nonatomic, strong) PHAssetCollection *assetCollection;
@end

@implementation TYPhotoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout model:(TYPhotoAlbums *)model
{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.model = model;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.collectionView.frame;
    frame.origin.y+=44;
    self.collectionView.frame = frame;
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self initSource];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)initSource
{
    [self.collectionView registerClass:[TYPhotoCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.title = self.model.albumName;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.assetCollection = self.model.assetCollection;
    _dataSouce = [[TYPhotoManager sharedManager] getAssetsInAssetCollection:self.assetCollection ascending:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataSouce count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TYPhotosLayout *lay = (TYPhotosLayout *)collectionViewLayout;
    return CGSizeMake([lay cellWidth],[lay cellWidth]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TYPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PHAsset *asset = _dataSouce[indexPath.row];
    __block UIImage *bImage = nil;
    CGSize size = cell.frame.size;
    size.width *= 3;
    size.height *= 3;
    [[TYPhotoManager sharedManager] requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
        bImage = image;
    }];
    
    [cell setImage:bImage];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PHAsset *asset = _dataSouce[indexPath.row];
    
    [[TYPhotoManager sharedManager] requestImageForAsset:asset size:PHImageManagerMaximumSize resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
        TYDisplayBigImageViewController *displayVC = nil;
        for (UIViewController *VC in self.navigationController.viewControllers) {
            if ([VC isKindOfClass:[TYDisplayBigImageViewController class]]) {
                displayVC = (TYDisplayBigImageViewController *)VC;
            }
        }
        if (displayVC == nil) {
            TYDisplayBigImageViewController *vc = [[TYDisplayBigImageViewController alloc] initWithImage:image];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}
#pragma mark <UICollectionViewDelegate>

@end
