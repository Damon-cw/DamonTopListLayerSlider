//
//  UIView+Frame.h
//  DreamTown
//
//  Created by Damon on 15/6/30.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

- (void)setCircleType;
- (void)setlayerBorderColor:(UIColor *)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)cornerRadius;

- (void)showImageWithOrigin;

- (void)ImageResetRotate;

- (void)imageRotate;

- (CGPoint)getViewPointInView:(id)view;

- (void)removeAllSubviews;
@end
