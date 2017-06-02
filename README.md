# AnimationTabBar

AnimationTabBar 高度自定制Tabbar,可自定义bar高度、背景颜色、照片、字号字色、图片与字的间距,并且支持只含图片 点击item有动画


<p><p>


## gif1:默认有图片、文字、动画

![img](https://github.com/carrot1994/AnimationTabBar/blob/master/AnimationTabBar.gif) 

使用标签分页控件，在`ViewController`import`TabBarView.h`,按照以下方法使用
## Usage


1. `` ViewController addChildViewController``
2.  init TabBarView 

``
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


``

<p><p>

## gif2:选择无动画效果、无title
![img](https://github.com/carrot1994/AnimationTabBar/blob/master/AnimationTabBar1.gif)

## Usage



1.`` TabBarView *tabBarView = [TabBarView initWithNormalImages:normalImages selectedImages:selectedImages titles:nil height:height]; ``

2.`` tabBarView.animation = NO; ``





