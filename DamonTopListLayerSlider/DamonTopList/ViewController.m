//
//  ViewController.m
//  DamonTopList
//
//  Created by Damon on 16/4/7.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#include "DamonPagesContainer.h"
@interface ViewController ()
@property (nonatomic, strong) DamonPagesContainer *pagesContainer;
@property (nonatomic, strong) TestViewController *testVC1;
@property (nonatomic, strong) TestViewController *testVC2;
@property (nonatomic, strong) TestViewController *testVC3;
@property (nonatomic, strong) TestViewController *testVC4;
@property (nonatomic, strong) TestViewController *testVC5;
@property (nonatomic, strong) TestViewController *testVC6;
@property (nonatomic, strong) TestViewController *testVC7;
@property (nonatomic, strong) TestViewController *testVC8;
@property (nonatomic, strong) TestViewController *testVC9;

@property (nonatomic, strong) NSArray *pages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pages = @[[self testVC1], [self testVC2], [self testVC3], [self testVC4], [self testVC5], [self testVC6],[self testVC7], [self testVC8], [self testVC9]];
    
//    self.pages = @[[self testVC1], [self testVC2], [self testVC3], [self testVC4], [self testVC5]];
//    self.pagesContainer.topScrollView.itemLayoutStyle = ItemLayoutStyleAverage;
    
    [self.view addSubview:[self pagesContainer].view];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (DamonPagesContainer *)pagesContainer {
    if (!_pagesContainer) {
        
        DamonPagesContainer *pagesContainer = [[DamonPagesContainer alloc] init];
        pagesContainer.view.frame = CGRectMake(0, 64, SCREENWIDTH,250);
        pagesContainer.viewControllers = self.pages;
        [pagesContainer willMoveToParentViewController:self];
        pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _pagesContainer = pagesContainer;
        
    }
    return _pagesContainer;
}

- (TestViewController *)testVC1
{
    if (!_testVC1) {
        TestViewController *testVC1 = [[TestViewController alloc] init];
        testVC1.view.height = 300;
        testVC1.view.backgroundColor = [UIColor yellowColor];
        testVC1.title = @"资讯";
        _testVC1 = testVC1;
        
    }
    return _testVC1;
}

- (TestViewController *)testVC2
{
    if (!_testVC2) {
        TestViewController *testVC2 = [[TestViewController alloc] init];
        testVC2.view.height = 250;
        testVC2.view.backgroundColor = [UIColor purpleColor];
        testVC2.title = @"娱乐";
        _testVC2 = testVC2;
        
    }
    return _testVC2;
}
- (TestViewController *)testVC3
{
    if (!_testVC3) {
        TestViewController *testVC3 = [[TestViewController alloc] init];
        testVC3.view.height = 250;
        testVC3.view.backgroundColor = [UIColor brownColor];
        testVC3.title = @"体育";
        _testVC3 = testVC3;
        
    }
    return _testVC3;
}
- (TestViewController *)testVC4
{
    if (!_testVC4) {
        TestViewController *testVC4 = [[TestViewController alloc] init];
        testVC4.view.height = 250;
        testVC4.view.backgroundColor = [UIColor greenColor];
        testVC4.title = @"财经";
        _testVC4 = testVC4;
        
    }
    return _testVC4;
}
- (TestViewController *)testVC5
{
    if (!_testVC5) {
        TestViewController *testVC5 = [[TestViewController alloc] init];
        testVC5.view.height = 250;
        testVC5.view.backgroundColor = [UIColor blueColor];

        testVC5.title = @"科技";
        _testVC5 = testVC5;
        
    }
    return _testVC5;
}
- (TestViewController *)testVC6
{
    if (!_testVC6) {
        TestViewController *testVC6 = [[TestViewController alloc] init];
        testVC6.view.height = 250;
        testVC6.view.backgroundColor = [UIColor redColor];
        testVC6.title = @"图片";
        _testVC6 = testVC6;
        
    }
    return _testVC6;
}

- (TestViewController *)testVC7
{
    if (!_testVC7) {
        TestViewController *testVC7 = [[TestViewController alloc] init];
        testVC7.view.height = 250;
        testVC7.view.backgroundColor = [UIColor grayColor];
        testVC7.title = @"汽车";
        _testVC7 = testVC7;
        
    }
    return _testVC7;
}


- (TestViewController *)testVC8
{
    if (!_testVC8) {
        TestViewController *testVC8 = [[TestViewController alloc] init];
        testVC8.view.height = 250;
        testVC8.view.backgroundColor = [UIColor cyanColor];
        testVC8.title = @"段子";
        _testVC8 = testVC8;
        
    }
    return _testVC8;
}

- (TestViewController *)testVC9
{
    if (!_testVC9) {
        TestViewController *testVC9 = [[TestViewController alloc] init];
        testVC9.view.height = 250;
        testVC9.view.backgroundColor = [UIColor magentaColor];
        testVC9.title = @"时尚";
        _testVC9 = testVC9;
        
    }
    return _testVC9;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 
 作者: 崔嵬
 Q Q: 525643907
 邮箱: cuiwei_0408@163.com
 注: 欢迎互相学习与交流.
 
 */

@end
