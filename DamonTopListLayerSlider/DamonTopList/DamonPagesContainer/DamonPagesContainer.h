//
//  DamonPagesContainer.h
//  MyDreamTown
//
//  Created by Damon on 15/7/18.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DamonTopScrollView.h"

@interface DamonPagesContainer : UIViewController

@property (nonatomic, strong) DamonTopScrollView *topScrollView;

@property (strong, nonatomic) NSArray *viewControllers;

@property (assign, nonatomic) NSUInteger selectedIndex;

@property (assign, nonatomic) NSUInteger topBarHeight;

@property (strong, nonatomic) UIColor *topBarBackgroundColor;

@property (strong, nonatomic) UIImage *topBarBackgroundImage;

@property (strong, nonatomic) UIFont *topBarItemLabelsFont;

@property (strong, nonatomic) UIColor *pageItemsTitleColor;

@property (nonatomic, strong) UIScrollView *scrollView;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

@end
