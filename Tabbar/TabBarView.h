//
//  TabBarView.h
//  Tabbar
//
//  Created by 周恩慧 on 2017/5/17.
//  Copyright © 2017年 周恩慧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@class TabBarView;

@protocol TabarDelegate <NSObject>

- (void)tabBarDidSelect:(TabBarView *)tabbar index:(NSUInteger)index title:(NSString *)title;

@end

@interface TabBarView : UIView

+ (instancetype)initWithNormalImages:(NSArray *)normalImages
                      selectedImages:(NSArray *)selectedImages
                              titles:(NSArray *)titles
                              height:(CGFloat)height;

/** tabbar背景颜色*/
@property (nonatomic, strong) UIColor *backgroundColor;
/** tabbar背景图片*/
@property (nonatomic, strong) UIImage *backgroundImage;
/** 文字未选中颜色*/
@property (nonatomic, strong) UIColor *itemNormalColor;
/** 文字选中颜色*/
@property (nonatomic, strong) UIColor *itemSelectedColor;
/** 文字字体*/
@property (nonatomic, strong) UIFont *itemFont;
/** 文字和图片间距 */
@property (nonatomic, assign) CGFloat titleMargin;
/** tabbarDelegate*/
@property (nonatomic, weak) id <TabarDelegate>delegate;
/** 是否展示动画*/
@property (nonatomic, assign) BOOL animation;
@end
