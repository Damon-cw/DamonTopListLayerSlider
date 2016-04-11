//
//  UIView+Frame.m
//  DreamTown
//
//  Created by Damon on 15/6/30.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}


- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y  = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}


- (void)setCircleType
{
    self.layer.cornerRadius = self.height / 2;
    self.layer.masksToBounds = YES;
}

- (void)setlayerBorderColor:(UIColor *)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)cornerRadius
{
    
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)showImageWithOrigin
{
    if ([self isKindOfClass:[UIImageView class]]) {
        self.clipsToBounds = YES;
        [self setContentScaleFactor:[[UIScreen mainScreen] scale]];
        self.contentMode =  UIViewContentModeScaleAspectFill;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    }
}

- (void)ImageResetRotate
{
    if ([self isKindOfClass:[UIImageView class]]) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        
        self.layer.transform = CATransform3DIdentity;
        [CATransaction commit];

    }
}

- (void)imageRotate
{
    if ([self isKindOfClass:[UIImageView class]]) {
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:1];
        self.layer.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
        
        [CATransaction commit];

        
    }

}


- (CGPoint)getViewPointInView:(id)view
{
        CGPoint position = self.frame.origin;
    
       DTLog(@"%f", position.x);
    DTLog(@"%f", position.y);
        if (![self.superview isEqual:view]) {
            
            if ([self.superview isKindOfClass:[UIScrollView class]]) {
                CGPoint supPosition = [self.superview getViewPointInView:view];
                
                position.x += supPosition.x - ((UIScrollView *)self.superview).contentOffset.x;
                position.y += supPosition.y - ((UIScrollView *)self.superview).contentOffset.y;
                

            } else {
                CGPoint supPosition = [self.superview getViewPointInView:view];
                position.x += supPosition.x;
                position.y += supPosition.y;

                
            }
            return position;
        }else{
            return position;
        }
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end
/*
 
 作者: 崔嵬
 Q Q: 525643907
 邮箱: cuiwei_0408@163.com
 注: 欢迎互相学习与交流.
 
 */