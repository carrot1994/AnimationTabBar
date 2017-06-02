//
//  NSString+FontSize.h
//  WoTV
//
//  Created by 周恩慧 on 2017/2/25.
//  Copyright © 2017年 zhanglinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (FontSize)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW maxH:(CGFloat)maxH;
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;


@end
