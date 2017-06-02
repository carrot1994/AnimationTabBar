//
//  TabItem.m
//  Tabbar
//
//  Created by 周恩慧 on 2017/5/17.
//  Copyright © 2017年 周恩慧. All rights reserved.
//

#import "TabItem.h"
#import "UIView+Extension.h"
#import "NSString+FontSize.h"

#define kTitleMargin                    5
#define kTabFontDefault                 [UIFont systemFontOfSize:12]
#define kTabTextColorDefault            [UIColor blackColor]
#define kTabTextColorSelected           [UIColor orangeColor]

@interface TabItem ()

@property (nonatomic, copy) NSString *selectedImage;
@property (nonatomic, copy) NSString *normalImage;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *textLabel;


@property (strong, nonatomic) CAEmitterLayer *chargeLayer;
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;


@end
@implementation TabItem

#pragma mark - initial
+ (instancetype)initWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title{
    
    return [[self alloc]initWithImage:image selectedImage:selectedImage title:title];
}


- (instancetype)initWithImage:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    if (self = [ super init]) {
        
        self.titleMargin = kTitleMargin;
        self.itemFont = kTabFontDefault;
        self.itemNormalColor = kTabTextColorDefault;
        self.itemSelectedColor = kTabTextColorSelected;
        
        self.selectedImage = selectedImage;
        self.normalImage = image;
        self.title = title;
        
        [self addSubview:self.itemImageView];
        [self addSubview:self.textLabel];
        
        
  
    }
    
    return self;
    
}


#pragma mark - 懒加载
- (UIImageView *)itemImageView {
    
    if (!_itemImageView) {
        
        UIImageView *itemImageView = [[UIImageView alloc]init];
        _itemImageView = itemImageView;
    }
    
    
    return _itemImageView;
}

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.textAlignment = NSTextAlignmentCenter;
        
        _textLabel = textLabel;
    }
    return _textLabel;
}




#pragma mark - properties

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    [self setNeedsLayout];
    
    if (selected && self.animated) {
        [self animation];
    }
    
}

- (void)setItemFont:(UIFont *)itemFont {
    
    _itemFont = itemFont;
    
    [self setNeedsLayout];
}

- (void)setTitleMargin:(CGFloat)titleMargin {
    
    _titleMargin = titleMargin;
    
    [self setNeedsLayout];
}

- (void)setItemNormalColor:(UIColor *)itemNormalColor {
    
    _itemNormalColor = itemNormalColor;
    
    [self setNeedsLayout];
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor {
    
    _itemSelectedColor = itemSelectedColor;
    
    [self setNeedsLayout];
    
}

- (void)setAnimated:(BOOL)animated {
    
    _animated = animated;
    
    if (animated) {
        [self setup];
    }
}


#pragma mark - layout & setProperties
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.selected) {
        
        if(self.selectedImage)  self.itemImageView.image = [UIImage imageNamed:self.selectedImage];
        self.textLabel.textColor = self.itemSelectedColor;
        
    }
    
    if (!self.selected ) {
        if(self.normalImage)  self.itemImageView.image = [UIImage imageNamed:self.normalImage];
        self.textLabel.textColor = self.itemNormalColor;
        
    }
    
    if (self.title) {
        self.textLabel.text = self.title;
    }
    
    CGFloat imageWidth = 0;
    CGFloat imageHeight = 0;
    if (self.normalImage) {
        UIImage *image = [UIImage imageNamed:self.normalImage];
        imageWidth = image.size.width;
        imageHeight = image.size.height;
        
    }
    self.itemImageView.width = imageWidth;
    self.itemImageView.height = imageHeight;
    
    self.textLabel.font = self.itemFont;
    CGFloat textLabelHeight = 0;
    if (self.title) {
        textLabelHeight = [self.title sizeWithFont:self.textLabel.font].height;
    }
    
    CGFloat imageY =  (self.height - (imageHeight + self.titleMargin + textLabelHeight))/2;
    CGFloat imageX = (self.width - imageHeight)/2;
    
    self.itemImageView.x = imageX;
    self.itemImageView.y = imageY;
    
    self.textLabel.width = self.width;
    CGFloat maxItemImageViewY = CGRectGetMaxY(self.itemImageView.frame) + self.titleMargin;
    self.textLabel.y = maxItemImageViewY;
    
    self.textLabel.height = textLabelHeight;
    
    
    //layerPosition
    _chargeLayer.position      = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    _explosionLayer.position      = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
}



/**
 *  配置WclEmitterButton
 */
- (void)setup {
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name           = @"explosion";
    explosionCell.alphaRange     = 0.10;
    explosionCell.alphaSpeed     = -1.0;
    explosionCell.lifetime       = 0.7;
    explosionCell.lifetimeRange  = 0.3;
    explosionCell.birthRate      = 0;
    explosionCell.velocity       = 40.00;
    explosionCell.velocityRange  = 10.00;
    explosionCell.scale          = 0.03;
    explosionCell.scaleRange     = 0.02;
    explosionCell.contents       = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
    
    _explosionLayer               = [CAEmitterLayer layer];
    _explosionLayer.name          = @"emitterLayer";
    _explosionLayer.emitterShape  = kCAEmitterLayerCircle;
    _explosionLayer.emitterMode   = kCAEmitterLayerOutline;
    _explosionLayer.emitterSize   = CGSizeMake(10, 0);
    _explosionLayer.emitterCells  = @[explosionCell];
    _explosionLayer.renderMode    = kCAEmitterLayerOldestFirst;
    _explosionLayer.masksToBounds = NO;
    _explosionLayer.position      = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    _explosionLayer.zPosition     = -1;
    [self.layer addSublayer:_explosionLayer];
    
    CAEmitterCell *chargeCell = [CAEmitterCell emitterCell];
    chargeCell.name           = @"charge";
    chargeCell.alphaRange     = 0.10;
    chargeCell.alphaSpeed     = -1.0;
    chargeCell.lifetime       = 0.3;
    chargeCell.lifetimeRange  = 0.1;
    chargeCell.birthRate      = 0;
    chargeCell.velocity       = -40.0;
    chargeCell.velocityRange  = 0.00;
    chargeCell.scale          = 0.03;
    chargeCell.scaleRange     = 0.02;
    chargeCell.contents       = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
    
    _chargeLayer               = [CAEmitterLayer layer];
    _chargeLayer.name          = @"emitterLayer";
    _chargeLayer.emitterShape  = kCAEmitterLayerCircle;
    _chargeLayer.emitterMode   = kCAEmitterLayerOutline;
    _chargeLayer.emitterSize   = CGSizeMake(20, 0);
    _chargeLayer.emitterCells  = @[chargeCell];
    _chargeLayer.renderMode    = kCAEmitterLayerOldestFirst;
    _chargeLayer.masksToBounds = NO;
    _chargeLayer.position      = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    _chargeLayer.zPosition     = -1;
    [self.layer addSublayer:_chargeLayer];
}

/**
 *  开始动画
 */
- (void)animation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (self.selected) {
        animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
        animation.duration = 0.5;
        [self startAnimate];
    }else
    {
        animation.values = @[@0.8, @1.0];
        animation.duration = 0.4;
    }
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}

/**
 *  开始喷射
 */
- (void)startAnimate {
    //chareLayer开始时间
    self.chargeLayer.beginTime = CACurrentMediaTime();
    //chareLayer每秒喷射的80个
    [self.chargeLayer setValue:@80 forKeyPath:@"emitterCells.charge.birthRate"];
    //进入下一个动作
    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
}

/**
 *  大量喷射
 */
- (void)explode {
    //让chareLayer每秒喷射的个数为0个
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    //explosionLayer开始时间
    self.explosionLayer.beginTime = CACurrentMediaTime();
    //explosionLayer每秒喷射的2500个
    [self.explosionLayer setValue:@2500 forKeyPath:@"emitterCells.explosion.birthRate"];
    //停止喷射
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

/**
 *  停止喷射
 */
- (void)stop {
    //让chareLayer每秒喷射的个数为0个
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    //explosionLayer每秒喷射的0个
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}


@end
