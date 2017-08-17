//
//  TYButton.h
//  Photography
//
//  Created by anzheng on 2017/8/9.
//  Copyright © 2017年 anzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYButton : UIButton

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *backgroundColorHighlighted;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *highlightedTextColor;
@property (nonatomic, assign) float topPading;

+ (TYButton *)button;
@end
