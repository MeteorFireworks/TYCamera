//
//  FWPhotosLayout.m
//  FWLifeApp
//
//  Created by Forrest Woo on 16/9/25.
//  Copyright © 2016年 ForrstWoo. All rights reserved.
//

#import "TYPhotosLayout.h"

@interface TYPhotosLayout ()
@property NSInteger countOfRow;
@end

@implementation TYPhotosLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.countOfRow = ceilf([self.collectionView numberOfItemsInSection:0] / 4.0);
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger currentRow = indexPath.item / 4;
    
    CGRect frame = CGRectMake( (indexPath.item % 4) * ([self cellWidth] + 5),currentRow * ([self cellWidth] + 65), [self cellWidth], [self cellWidth]);
    attris.frame = frame;
    attris.zIndex = 1;
    
    return attris;
}

- (CGFloat)cellWidth
{
    return (KMainScreenWidth - 3 * 5) / 4;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(KMainScreenWidth, self.countOfRow * ([self cellWidth] + 5) + 44);
}
@end
