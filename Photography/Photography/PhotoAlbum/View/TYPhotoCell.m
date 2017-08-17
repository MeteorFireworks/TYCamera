//
//  FWPhotoCell.m
//  FWLifeApp
//
//  Created by Forrest Woo on 16/9/23.
//  Copyright © 2016年 ForrstWoo. All rights reserved.
//


#import "TYPhotoCell.h"

@interface TYPhotoCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TYPhotoCell


- (void)setImage:(UIImage *)image
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (KMainScreenWidth - 3 * 5)/4, (KMainScreenWidth - 3 * 5)/4)];
    self.imageView.image = image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
    [self.contentView addSubview:self.imageView];
}
@end
