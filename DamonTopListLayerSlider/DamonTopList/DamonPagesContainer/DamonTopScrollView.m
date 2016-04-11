//
//  DamonTopScrollView.m
//  MyDreamTown
//
//  Created by Damon on 15/7/18.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import "DamonTopScrollView.h"
#import <math.h>

@interface DamonTopScrollView ()
{
}
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIView *bottomScroll;
@property (nonatomic, assign) NSInteger oldIndex;
@property (nonatomic, assign) CGPoint pagesContainerScrollOffSet;
@property (nonatomic, strong) NSMutableArray *allColorLayerArr;
@end

@implementation DamonTopScrollView

- (void)tapClicked:(UITapGestureRecognizer *)tap
{
    
    
    CGPoint touchPoint = [tap locationInView:self.scrollView];
    
    NSLog(@"%.2f", touchPoint.x);
    int i = 0;
    
    for (CAGradientLayer *layer in self.allColorLayerArr) {
        
        if (layer.frame.origin.x <= touchPoint.x && touchPoint.x <=layer.frame.origin.x + layer.frame.size.width) {
            break;
        } else {
            i++;
        }
        
    }
    if (self.oldIndex != i) {
        
        //[self setButtonSelectStyle:i];
        
//        self.oldIndex = i;
        
        [self setContentOffsetRate:(float)i everyItemWith:0];
        
        
        [self.delegate isTouchedByBtn:YES];
        
        
        [self.delegate itemAtIndex:i didSelectInPagesContainerTopBar:self];
        
    }
    
    
    NSLog(@"%d", i);
    
    
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.allColorLayerArr = [NSMutableArray array];
        self.itemLayoutStyle = ItemLayoutStyleAverage;
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tapClicked:)];
        [self.scrollView addGestureRecognizer:tap];
        
        [self addSubview:self.scrollView];
        // self.scrollView.backgroundColor = [UIColor redColor];
        self.font = [UIFont systemFontOfSize:14];
        self.itemTitleColor = RGBFromColor(0x432423);
        self.itemSelectedTitleColor = RGBFromColor(0x43d233);
        self.itemTitles = [NSMutableArray array];
        self.oldIndex = 0;
        self.itemSpace = 10.0;
        self.pagesContainerScrollOffSet = CGPointMake(0, 0);
        self.bottomScroll = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.scrollView.height- DT_SEPARETE_LINE_WIDTH)];
        self.bottomScroll.backgroundColor = RGBFromAlphaColor(0xFFFF00, 0.5);
        [self.scrollView addSubview:self.bottomScroll];
        self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - DT_SEPARETE_LINE_WIDTH, SCREENWIDTH, DT_SEPARETE_LINE_WIDTH)];
        self.bottomLineView.backgroundColor = DTSepareteLineDarkColor;
        [self addSubview:self.bottomLineView];
        
    }
    return self;
}

- (void)setItemTitles:(NSMutableArray *)itemTitles
{
    
    if (_itemTitles != itemTitles) {
        _itemTitles = [NSMutableArray arrayWithArray:itemTitles];
        NSMutableArray *mutableItemViews = [NSMutableArray arrayWithCapacity:itemTitles.count];
        for (NSUInteger i = 0; i < itemTitles.count; i++) {
            UIButton *itemView = [self addItemView];
            [itemView setTitle:itemTitles[i] forState:UIControlStateNormal];
            
            [mutableItemViews addObject:itemView];
        }
        self.itemViews = [NSArray arrayWithArray:mutableItemViews];
        [self layoutSubviews];
        
    }
    
}

#pragma mark - Private

- (UIButton *)addItemView
{
    CGRect frame = CGRectMake(0., 0., 100, CGRectGetHeight(self.frame));
    UIButton *itemView = [[UIButton alloc] initWithFrame:frame];
    itemView.titleLabel.adjustsFontSizeToFitWidth = YES;
    [itemView addTarget:self action:@selector(itemViewTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    itemView.titleLabel.font = self.font;
    
    [itemView setTitleColor:self.itemTitleColor forState:UIControlStateNormal];
    
    [self.scrollView addSubview:itemView];
    
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame = itemView.frame;
    
    // 颜色分配
    colorLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor,
                          (__bridge id)[UIColor redColor].CGColor];
    // 起始点
    colorLayer.startPoint = CGPointMake(0, 0);
    // 结束点
    colorLayer.endPoint = CGPointMake(1, 0);
    [self.scrollView.layer addSublayer:colorLayer];
    [self.allColorLayerArr addObject:colorLayer];
    colorLayer.mask = itemView.layer;
    itemView.frame = colorLayer.bounds;
    //
    CGFloat test2 = - 0.1f;
    test2 = test2 + 0.2f;
    [CATransaction setDisableActions:YES];
    colorLayer.locations  = @[@(test2), @(test2 + 0.000001)];
    
    
    
    return itemView;
}

// 按钮的点击方法
- (void)itemViewTapped:(UIButton *)button
{
    
    if ([self.itemViews indexOfObject:button] != self.oldIndex) {
        
        [button setTitleColor:self.itemSelectedTitleColor forState:UIControlStateNormal];
        
        [[self getOldSelectButton:self.oldIndex] setTitleColor:self.itemTitleColor forState:UIControlStateNormal];
        
        [self layoutBottomScoll:[self.itemViews indexOfObject:button]];
        
        self.oldIndex = [self.itemViews indexOfObject:button];
        
        [self.delegate isTouchedByBtn:YES];
        
        [self.delegate itemAtIndex:[self.itemViews indexOfObject:button] didSelectInPagesContainerTopBar:self];
        //[self.delegate isTouchedByBtn:NO];
    }
}

// 获取当前选中的btn
- (UIButton *)getOldSelectButton:(NSInteger)index
{
    return [self.itemViews objectAtIndex:index];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.itemLayoutStyle == ItemLayoutStyleAverage) {
        
        [self layoutItemViewUseAverage];
        
    } else {
        
        [self layoutItemViewUseWidth];
        
    }
}

- (void)layoutItemViewUseAverage
{
    
    //    if (self.itemSpace) {
    //
    //    }
    
    if (self.itemViews.count <= 5) {
        
        self.itemSpace = (CGFloat)(SCREENWIDTH - [self getAllTextLenth]) / self.itemTitles.count;
        
    } else {
        
        self.itemSpace = (SCREENWIDTH - [self getAllTextLenth]) / 5;
    }
    
    CGFloat btnOoriginX = .0;
    
    for (UIButton *button in self.itemViews) {
        
        NSInteger index = [self.itemViews indexOfObject:button];
        if (self.oldIndex == index) {
            [self layoutBottomScoll:0];
            [button setTitleColor:self.itemSelectedTitleColor forState:UIControlStateNormal];
            
        }
        
        button.frame = CGRectMake(btnOoriginX, 0, self.itemSpace + [self getTextRect:[self.itemTitles objectAtIndex:index] width:100 font:14].width, self.scrollView.height - 2);
        //        button.backgroundColor = [UIColor colorWithRed:arc4random() % 10 / 10. green:(arc4random() % 255) / 255. blue:arc4random() % 255 / 255. alpha:1];
        
        btnOoriginX = btnOoriginX + self.itemSpace + [self getTextRect:[self.itemTitles objectAtIndex:index] width:100 font:14].width;
        
    }
    self.scrollView.contentSize = CGSizeMake(btnOoriginX, self.scrollView.contentSize.height);
}


- (void)layoutItemViewUseWidth
{
    CGFloat btnOoriginX = .0;
    
    for (UIButton *button in self.itemViews) {
        
        NSInteger index = [self.itemViews indexOfObject:button];
        if (self.oldIndex == index) {
            [self layoutBottomScoll:0];
            [button setTitleColor:self.itemSelectedTitleColor forState:UIControlStateNormal];
            
        }
        
        button.frame = CGRectMake(btnOoriginX, 0, self.itemSpace + [self getTextRect:[self.itemTitles objectAtIndex:index] width:100 font:14].width, self.scrollView.height - 2);
        //button.backgroundColor = [UIColor colorWithRed:arc4random() % 10 / 10. green:(arc4random() % 255) / 255. blue:arc4random() % 255 / 255. alpha:1];
        btnOoriginX = btnOoriginX + self.itemSpace+ [self getTextRect:[self.itemTitles objectAtIndex:index] width:100 font:14].width;
        
        
        CAGradientLayer *colorLayer = [self.allColorLayerArr objectAtIndex:index];
        colorLayer.frame = button.frame;
        [CATransaction setDisableActions:YES];

        if (index == 0) {
            
            
            // 颜色分配
            colorLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor];
            
        } else {
            
            // 颜色分配
            colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                                  (__bridge id)[UIColor greenColor].CGColor];
            
        }
        // 起始点
        colorLayer.startPoint = CGPointMake(0, 0);
        // 结束点
        colorLayer.endPoint = CGPointMake(1, 0);
        CGFloat test = 0;
        test = test + 0;
        colorLayer.locations  = @[@(test), @(test + 0.000001)];

        button.frame = colorLayer.bounds;
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake(btnOoriginX < self.width? self.width : btnOoriginX, self.scrollView.contentSize.height);
}

- (void)layoutBottomScoll:(NSInteger)index
{
    CGRect frame = self.bottomScroll.frame;
    
    CAGradientLayer *colorLayer = [self.allColorLayerArr objectAtIndex:index];
    UIButton *button = [self.itemViews objectAtIndex:index];
    frame = CGRectMake(colorLayer.frame.origin.x, frame.origin.y, colorLayer.frame.size.width, frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bottomScroll.frame = frame;
    }];
    
    // 把选中的中心点移动到scollview中心
    [self MoveToCenterWithIndex:(int)index];
    
}
// 获取所有的btn中title的长度
- (CGFloat)getAllTextLenth
{
    
    CGFloat allTextLenth = 0.0;
    
    for (NSString *temStr in self.itemTitles) {
        
        allTextLenth = allTextLenth + [self getTextRect:temStr width:1000 font:14].width;
        
    }
    return allTextLenth;
}

- (void)setBottomFrame:(UIScrollView *)scrollView
{
    
}

// 给当前偏移到的位置的btn设置样式

/**
 *  使选中的按钮位移到scollview的中间
 */
- (void)MoveToCenterWithIndex:(int)index {
    UIButton *btn = [self.itemViews objectAtIndex:index];
    CAGradientLayer *colorLayer = [self.allColorLayerArr objectAtIndex:index];
    CGRect newframe = colorLayer.frame;
    //    NSLog(@"%.2f %.2f %.2f %.2f", btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
    //        NSLog(@"%.2f %.2f %.2f %.2f", colorLayer.frame.origin.x, colorLayer.frame.origin.y, colorLayer.frame.size.width, colorLayer.frame.size.height);
    //    CGRect newframe =  [btn convertRect:self.bounds toView:nil];
    CGFloat distance = newframe.origin.x  - self.center.x;
    CGFloat contenoffsetX = self.scrollView.contentOffset.x;
    int count = (int)self.itemViews.count;
    if (index > count-1) return;
    
    if (self.scrollView.contentOffset.x + newframe.origin.x  > self.center.x) {
        
        if (self.scrollView.contentSize.width - self.scrollView.contentOffset.x - newframe.origin.x - btn.width / 2 < self.center.x) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - self.width, 0) animated:YES];
            return;
        }
        
        [self.scrollView setContentOffset:CGPointMake(contenoffsetX + distance + btn.width / 2, 0) animated:YES];
        
    }else{
        
        [self.scrollView setContentOffset:CGPointMake(0 , 0) animated:YES];
    }
}


- (CGSize)getTextRect:(NSString *)text width:(float)width font:(float)fontSize
{
    CGSize size;
    CGSize constraint = CGSizeMake(width, 20000.0f);
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    size = [text boundingRectWithSize:constraint options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    return size;
}

#pragma mark - Public

- (void)setButtonSelectStyle:(NSInteger)index;
{
    if (self.oldIndex != index) {
        
        UIButton *button = [self.itemViews objectAtIndex:index];
        
        [button setTitleColor:self.itemSelectedTitleColor forState:UIControlStateNormal];
        
        [[self getOldSelectButton:self.oldIndex] setTitleColor:self.itemTitleColor forState:UIControlStateNormal];
        
        [self layoutBottomScoll:[self.itemViews indexOfObject:button]];
        
        self.oldIndex = index;
        // 把选中的中心点移动到scollview中心
        [self MoveToCenterWithIndex:(int)index];
    }
}


// 根据传入下方的视图偏移量的比例 来设置底部滑块的滚动位置 实时修改滑块的偏移量
- (void)setContentOffsetRate:(float)rate everyItemWith:(float)width
{
    CGRect frame = self.bottomScroll.frame;
    
    float movedWidth = (rate - (int)rate) * (self.itemSpace + [self getTextRect:[self.itemTitles objectAtIndex:(int)rate] width:100 font:14].width);
    
    // 这里取的是根据 传入的参数 对滚动率进行取整, 如果向前移动肯定取的是当前的前一个, 如果向后移动就取当前的
    CAGradientLayer *colorLayer = [self.allColorLayerArr objectAtIndex:(int)rate];
    
    frame = CGRectMake(colorLayer.frame.origin.x + movedWidth, frame.origin.y, colorLayer.frame.size.width, frame.size.height);
    
    self.bottomScroll.frame = frame;
    
    NSLog(@"%.4f", rate);
    // 向后移动
    double nextPage = (int)ceil(rate);
    
    double downPage = (int)rate;
    
    NSLog(@"当前页:%f --- 下一页:%f", downPage ,nextPage);
    float temp = 1.0 * self.oldIndex;
    
    self.oldIndex = self.oldIndex <= nextPage? nextPage: downPage;
    
        NSLog(@"当前页:%d", self.oldIndex);
    
    if (nextPage == downPage) {
        
        self.oldIndex = (int)downPage;
        
        if (nextPage != 0) {
            
            [CATransaction setDisableActions:YES];
            // 颜色分配
            colorLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor];
            // 起始点
            colorLayer.startPoint = CGPointMake(0, 0);
            // 结束点
            colorLayer.endPoint = CGPointMake(1, 0);
            
            CGFloat test = 0;
            test = test + 0;
            //            [CATransaction setDisableActions:YES];
            colorLayer.locations  = @[@(test), @(test + 0.000001)];
            
        }
        
        
                    for (int i = 0; i < nextPage; i++) {
        
                        [CATransaction setDisableActions:YES];
        
                        CAGradientLayer *colorLayer = [self.allColorLayerArr objectAtIndex:i];
        
                        // 颜色分配
                        colorLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor,
                                              (__bridge id)[UIColor redColor].CGColor];
                        // 起始点
                        colorLayer.startPoint = CGPointMake(0, 0);
                        // 结束点
                        colorLayer.endPoint = CGPointMake(1, 0);
        
                        CGFloat test = 0;
                        test = test + 1;
                        //            [CATransaction setDisableActions:YES];
                        colorLayer.locations  = @[@(test), @(test + 0.000001)];
        
                    }
        
                    for (int i = (int)self.allColorLayerArr.count - 1; i > nextPage; i--) {
        
                                        CAGradientLayer *colorLayer = [self.allColorLayerArr objectAtIndex:i];
                        [CATransaction setDisableActions:YES];
                        // 颜色分配
                        colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                                              (__bridge id)[UIColor greenColor].CGColor];
                        // 起始点
                        colorLayer.startPoint = CGPointMake(0, 0);
                        // 结束点
                        colorLayer.endPoint = CGPointMake(1, 0);
        
                        CGFloat test = 0;
                        test = test + 0;
                        //            [CATransaction setDisableActions:YES];
                        colorLayer.locations  = @[@(test), @(test + 0.000001)];
        
                        
                        
                        
                    }

        
        
        [self MoveToCenterWithIndex:(int)downPage];
        return;
    }
    
    [self MoveToCenterWithIndex:self.oldIndex];

    // 向前移动
    if (nextPage == self.oldIndex) {
        
        NSLog(@"向前移动");
//        if (self.oldIndex ) {
//            <#statements#>
//        }
        
        CGFloat changeValue = rate - self.oldIndex * 1.0;
         //NSLog(@"%.2f", changeValue);
        CGFloat test = 1;
        test = test + changeValue;
        [CATransaction setDisableActions:YES];
        // 颜色分配
        colorLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor,
                              (__bridge id)[UIColor redColor].CGColor];
        // 起始点
        colorLayer.startPoint = CGPointMake(0, 0);
        // 结束点
        colorLayer.endPoint = CGPointMake(1, 0);

        colorLayer.locations  = @[@(test), @(test + 0.000001)];
        
        CAGradientLayer *colorLayer = [self.allColorLayerArr objectAtIndex:self.oldIndex];
        //colorLayer.frame = itemView.frame;
//        [CATransaction setDisableActions:YES];
        
        // 颜色分配
        colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                              (__bridge id)[UIColor greenColor].CGColor];
        // 起始点
        colorLayer.startPoint = CGPointMake(0, 0);
        // 结束点
        colorLayer.endPoint = CGPointMake(1, 0);
        
                CGFloat test1 = 1;
               test1 = test1 + changeValue;
        colorLayer.locations  = @[@(test1), @(test1 + 0.000001)];
        
       // NSLog(@"当前页:%f --- 下一页:%f", downPage ,nextPage);
        
        
    } else {
        // 向后移动
        
        NSLog(@"向后移动");
        
        CGFloat changeValue = rate - self.oldIndex * 1.0;
        // NSLog(@"%.2f", changeValue);
        CGFloat test = 0;
        test = test + changeValue;
        [CATransaction setDisableActions:YES];
        colorLayer.locations  = @[@(test), @(test + 0.000001)];
        
        CAGradientLayer *colorLayer = [self.allColorLayerArr objectAtIndex:nextPage];
        //colorLayer.frame = itemView.frame;
        [CATransaction setDisableActions:YES];
        
        // 颜色分配
        colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                              (__bridge id)[UIColor greenColor].CGColor];
        // 起始点
        colorLayer.startPoint = CGPointMake(0, 0);
        // 结束点
        colorLayer.endPoint = CGPointMake(1, 0);
        
        //        CGFloat test1 = 0;
        //        test1 = test1 + changeValue;
        colorLayer.locations  = @[@(test), @(test + 0.000001)];
        
    }
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
