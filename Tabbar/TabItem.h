//
//  TabItem.h
//  Tabbar
//
//  Created by 周恩慧 on 2017/5/17.
//  Copyright © 2017年 周恩慧. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TabItem : UIButton


+ (instancetype)initWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title;


/** 文字未选中颜色*/
@property (nonatomic, strong) UIColor *itemNormalColor;
/** 文字选中颜色*/
@property (nonatomic, strong) UIColor *itemSelectedColor;
/** 文字字体*/
@property (nonatomic, strong) UIFont *itemFont;
/** 文字和图片间距 */
@property (nonatomic, assign) CGFloat titleMargin;
/** 是否展示动画*/
@property (nonatomic, assign) BOOL animated;

@end
