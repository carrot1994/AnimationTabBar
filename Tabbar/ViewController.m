//
//  ViewController.m
//  Tabbar
//
//  Created by 周恩慧 on 2017/5/17.
//  Copyright © 2017年 周恩慧. All rights reserved.
//

#import "ViewController.h"
#import "TabBarView.h"
#import "UIView+Extension.h"
@interface ViewController () <TabarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /** 子控制器*/
    [self createViewControllers];
    
    
    /** 选中照片array*/
    NSArray *selectedImages = @[@"icon_tab_home_pre",@"icon_tab_faxian_pre",@"icon_tab_vip_pre",@"icon_tab_me_pre"];
   
    /** 照片array*/
    NSArray *normalImages = @[@"icon_tab_home",@"icon_tab_faxian",@"icon_tab_vip",@"icon_tab_me"];
    
    /** 标题array*/
    NSArray *titles = @[@"首页",@"发现",@"vip",@"我"];
    
    CGFloat height = 60;
    
    
    
    //必须:设置选中图片、normal图片、title
    //可选:tabbar背景图片\背景颜色\字体\字色\图片文字间距\我自己添加了一点点粒子动画
    
    TabBarView *tabBarView = [TabBarView initWithNormalImages:normalImages selectedImages:selectedImages titles:nil height:height];
    tabBarView.y = self.view.height - height;
    tabBarView.delegate = self;
    [self.view insertSubview:tabBarView atIndex:0];
    
    
  
    
    
    
    
}

/** 子控制器*/
- (void)createViewControllers {
    
    UIViewController  *ctr1 = [[UIViewController alloc]init];
    ctr1.view.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [ctr1.view addGestureRecognizer:rec];
    [self.view addSubview:ctr1.view];
    
    
    UIViewController  *ctr2 = [[UIViewController alloc]init];
    ctr2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController  *ctr3 = [[UIViewController alloc]init];
    ctr3.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController  *ctr4 = [[UIViewController alloc]init];
    ctr4.view.backgroundColor = [UIColor blueColor];
    
    
    CGRect rect = CGRectMake(0, 64, self.view.width,self.view.height  - 60 - 64 );
    ctr1.view.frame = rect;
    ctr2.view.frame = rect;
    ctr3.view.frame = rect;
    ctr4.view.frame = rect;
    
    
    
    [self addChildViewController:ctr1];
    [self addChildViewController:ctr2];
    [self addChildViewController:ctr3];
    [self addChildViewController:ctr4];
    
}

- (void)tap {
    
    [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
}



#pragma mark - tabbarDelegate

- (void)tabBarDidSelect:(TabBarView *)tabbar index:(NSUInteger)index title:(NSString *)title{
    
    NSLog(@"---index:%lu",index);
    
    [self.view addSubview:[self.childViewControllers objectAtIndex:index].view];
    self.title = title;
    
}
@end
