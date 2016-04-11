//
//  DamonPagesContainer.m
//  MyDreamTown
//
//  Created by Damon on 15/7/18.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import "DamonPagesContainer.h"

#define kFontSize [UIFont systemFontOfSize:12];

@interface DamonPagesContainer ()<UIScrollViewDelegate, DamonTopScrollViewDelegate>

@property (assign, nonatomic) CGFloat scrollWidth;
@property (assign, nonatomic) CGFloat scrollHeight;
@property (nonatomic, assign) BOOL isTouchedByTopView;
@end

@implementation DamonPagesContainer

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

// 初始化所有的属性变量
- (void)setUp
{
    _topBarHeight = 28.;
    self.scrollHeight = 200;
    _topBarBackgroundColor = [UIColor colorWithWhite:0.1 alpha:1.];
    _topBarItemLabelsFont = kFontSize;
    self.pageItemsTitleColor = [UIColor lightGrayColor];
    _viewControllers = [NSMutableArray array];
    _selectedIndex = 0;
    self.topScrollView = [[DamonTopScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, _topBarHeight)];
    self.topScrollView.itemLayoutStyle = ItemLayoutStyleUseWidth;
    self.topScrollView.itemSpace = 40.0 / 2;
    self.topScrollView.delegate = self;
    self.isTouchedByTopView = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.,
                                                                     self.topBarHeight,
                                                                     CGRectGetWidth(self.view.frame),
                                                                     CGRectGetHeight(self.view.frame) - self.topBarHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];

    [self.view addSubview:self.topScrollView];
    
    // Do any additional setup after loading the view.
}

// 把传入的所有视图控制器, 按数组的顺序布局显示
- (void)setViewControllers:(NSArray *)viewControllers
{
    if (_viewControllers != viewControllers) {
        _viewControllers = viewControllers;
        
        self.topScrollView.itemTitles = [viewControllers valueForKey:@"title"];
        for (UIViewController *viewController in viewControllers) {
            [viewController willMoveToParentViewController:self];
            viewController.view.frame = CGRectMake(0., 0., CGRectGetWidth(self.scrollView.frame), self.scrollHeight);
            [self.scrollView addSubview:viewController.view];
            [viewController didMoveToParentViewController:self];
        }
        [self layoutSubviews];
        self.selectedIndex = 0;
        [self setCurrentScrollTotopView];
    }
    
}

// 设置当前显示的视图可以响应点击状态栏 视图置顶
- (void)setCurrentScrollTotopView
{
    for (int i = 0; i<_viewControllers.count; i++) {
        if (i == self.selectedIndex) {
            UIViewController *viewController = [_viewControllers objectAtIndex:i];
            
            for (id obj in viewController.view.subviews) {
                
                if ([obj isKindOfClass:[UIScrollView class]] || [obj isKindOfClass:[UITableView class]]) {
                    
                    ((UIScrollView *)obj).scrollsToTop = YES;
                    
                    break;
                }
                
            }
        } else {
            
            UIViewController *viewController = [_viewControllers objectAtIndex:i];
            
            for (id obj in viewController.view.subviews) {
                
                if ([obj isKindOfClass:[UIScrollView class]] || [obj isKindOfClass:[UITableView class]]) {
                    
                    ((UIScrollView *)obj).scrollsToTop = NO;
                    
                    break;
                }
                
            }

        }
    }

}

// 视图中滚动视图的高度
- (CGFloat)scrollHeight
{
    return CGRectGetHeight(self.view.frame) - self.topBarHeight;
}

// 视图中滚动视图的宽度
- (CGFloat)scrollWidth
{
    return CGRectGetWidth(self.scrollView.frame);
}

// 重写布局方法
- (void)layoutSubviews
{
    if (_topScrollView == nil) {
        self.topScrollView.frame = CGRectMake(0., 0., CGRectGetWidth(self.view.bounds), self.topBarHeight);
    }
    CGFloat x = 0.;
    for (UIViewController *viewController in self.viewControllers) {
        viewController.view.frame = CGRectMake(x, 0, CGRectGetWidth(self.scrollView.frame), self.scrollHeight);
        x += CGRectGetWidth(self.scrollView.frame);
        
    }
    self.scrollView.contentSize = CGSizeMake(x, self.scrollHeight);
    [self.scrollView setContentOffset:CGPointMake(self.selectedIndex * self.scrollWidth, 0.) animated:YES];
    
    
    
    //  self.topScrollView.scrollView.contentOffset = [self.topScrollView contentOffsetForSelectedItemAtIndex:self.selectedIndex];
    self.scrollView.userInteractionEnabled = YES;
    
}

// 给控制视图的控制器中的容器设置滚动页面
- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated
{
  // 滚动视图
    [self.scrollView setContentOffset:CGPointMake(selectedIndex * CGRectGetWidth(self.scrollView.frame), 0) animated:animated];

}

#pragma mark-----顶部菜单的协议方法------
- (void)itemAtIndex:(NSUInteger)index didSelectInPagesContainerTopBar:(DamonTopScrollView *)bar
{
    [self setSelectedIndex:index animated:YES];
    self.selectedIndex = index;
    [self setCurrentScrollTotopView];
}

- (void)isTouchedByBtn:(BOOL)pram
{
    _isTouchedByTopView = pram;
}

#pragma mark-----滚动视图的协议方法------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
   // [self.topScrollView setBottomFrame:scrollView];
    if (self.isTouchedByTopView) {
        return;
    }
    float rate = self.scrollView.contentOffset.x / self.scrollView.width;
    
    // 计算出标记, 当前页面的
   // int index = (int)self.scrollView.contentOffset.x / self.scrollView.width;
    // 重置当前页面的标记
    self.selectedIndex = (int)index;
    [self.topScrollView setContentOffsetRate:rate everyItemWith:self.scrollView.width];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
   // self.scrollView.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //self.scrollView.userInteractionEnabled = YES;
    NSLog(@"停止拖拽");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
   // self.scrollView.userInteractionEnabled = NO;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
   // self.scrollView.userInteractionEnabled = YES;
    // 计算出标记, 当前页面的
    int index = (int)self.scrollView.contentOffset.x / self.scrollView.width;
    // 重置当前页面的标记
    self.selectedIndex = index;
    // 给顶部的滚动滑块定位到当前显示的页面
   /// [self.topScrollView setButtonSelectStyle:index];
    // 这个是可以使其页面响应点击状态栏可以置顶的方法
    [self setCurrentScrollTotopView];
    NSLog(@"结束减速");
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 顶部的滑块更新位置
     //[self.topScrollView setBottomFrame:scrollView];
    if (_isTouchedByTopView) {
        _isTouchedByTopView = NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
