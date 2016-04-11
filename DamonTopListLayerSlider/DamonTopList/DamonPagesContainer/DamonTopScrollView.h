//
//  DamonTopScrollView.h
//  MyDreamTown
//
//  Created by Damon on 15/7/18.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ItemLayoutStyle {
    ItemLayoutStyleUseWidth,
    ItemLayoutStyleAverage,
} ItemLayoutStyle;


@class DamonTopScrollView;
// 协议方法
@protocol DamonTopScrollViewDelegate <NSObject>

- (void)itemAtIndex:(NSUInteger)index didSelectInPagesContainerTopBar:(DamonTopScrollView *)bar;
- (void)isTouchedByBtn:(BOOL)pram;

@end

@interface DamonTopScrollView : UIView
// 顶部的类型 是均等布局 还是按字体的宽度布局
@property (nonatomic, assign) ItemLayoutStyle itemLayoutStyle;
// 标题的颜色
@property (strong, nonatomic) UIColor *itemTitleColor;
// 选中的颜色
@property (nonatomic, strong) UIColor *itemSelectedTitleColor;
// 每个标题的颜色
@property (nonatomic, assign) CGFloat itemSpace;
// 标题数组, 默认标题是传入的视图控制器的title
@property (strong, nonatomic) NSMutableArray *itemTitles;
// 标题的字体大小
@property (strong, nonatomic) UIFont *font;
// 用来保存所有的btnView
@property ( strong, nonatomic) NSArray *itemViews;
// 承载所有的视图, 最底部的滑动容器
@property ( strong, nonatomic) UIScrollView *scrollView;
// 代理
@property (nonatomic, assign) id<DamonTopScrollViewDelegate>delegate;


- (void)setBottomFrame:(UIScrollView *)scrollView;
// 选中的btn的样式
- (void)setButtonSelectStyle:(NSInteger)index;
// 根据传入下方的视图偏移量的比例 来设置底部滑块的滚动位置 实时修改滑块的偏移量
- (void)setContentOffsetRate:(float)rate everyItemWith:(float)width;

@end
