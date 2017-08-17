//
//  FWPhotoCollectionViewController.h
//  FWLifeApp
//
//  Created by Forrest Woo on 16/9/23.
//  Copyright © 2016年 ForrstWoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "TYPhotoAlbums.h"

@interface TYPhotoCollectionViewController : UICollectionViewController

@property (nonatomic, strong) TYPhotoAlbums *model;

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout model:(TYPhotoAlbums *)model;

@end
