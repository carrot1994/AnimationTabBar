//
//  TabBarView.m
//  Tabbar
//
//  Created by 周恩慧 on 2017/5/17.
//  Copyright © 2017年 周恩慧. All rights reserved.
//

#import "TabBarView.h"
#import "TabItem.h"

#define kBackgroundColor                [UIColor whiteColor]
#define kTabWidth  [UIScreen mainScreen].bounds.size.width
#define kTabHeight                      49.0





@interface TabBarView ()


@property (nonatomic, strong) NSMutableArray *itemArray;


/** tabbarItem的文字*/
@property (nonatomic, strong) NSArray *titles;
/** tabbarItem的图片*/
@property (nonatomic, strong) NSArray *normalImages;
/** tabbarItem 选中的图片*/
@property (nonatomic, strong) NSArray *selectedImages;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, assign) NSUInteger beforeIndex;

@end

@implementation TabBarView

- (NSMutableArray *)itemArray {
    
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
        
    }
    return _itemArray;
}

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        UIImageView *backgroundImageView = [[UIImageView alloc]init];
        backgroundImageView.frame = CGRectMake(0, 0, self.width, self.height);
        backgroundImageView.userInteractionEnabled = YES;
        _backgroundImageView = backgroundImageView;
        
    }
    return _backgroundImageView;
}
#pragma mark - initial
+ (instancetype)initWithNormalImages:(NSArray *)normalImages
                      selectedImages:(NSArray *)selectedImages
                              titles:(NSArray *)titles
                              height:(CGFloat)height{
    
    return [[self alloc]initWithNormalImages:normalImages
                              selectedImages:selectedImages
                                      titles:titles
                                      height:height];
    
}


- (instancetype)initWithNormalImages:(NSArray *)normalImages
                      selectedImages:(NSArray *)selectedImages
                              titles:(NSArray *)titles
                              height:(CGFloat)height{
    
    if (self = [super init]) {
        
        self.beforeIndex = 100;
        self.normalImages = normalImages;
        self.selectedImages = selectedImages;
        self.titles = titles;
        self.height = height;
        self.width = kTabWidth;
        [self setSubViews];
    }
    
    return self;
    
}



- (void)setSubViews{
    
    //background
    [self addSubview:self.backgroundImageView];
    
    if (self.normalImages.count !=self.titles.count && self.titles.count) {
        NSAssert(NO, @"请确保文字数量:%lu和图片数量一致 %lu",(unsigned long)self.normalImages.count, self.titles.count);
        
    }
    if (self.itemArray.count) {
        
        return;
    }
    
    NSUInteger count = MAX(self.normalImages.count, self.titles.count);
    

    
    for (NSUInteger i = 0; i < count; i++) {
        
        NSString *normalImage = (self.normalImages.count>i)?[self.normalImages objectAtIndex:i]:nil;
        NSString *selectdImage = (self.selectedImages.count>i)?[self.selectedImages objectAtIndex:i]:nil;
        
        NSString *title = (self.titles.count>i)?[self.titles objectAtIndex:i]:nil;
        
        
        TabItem *item = [TabItem initWithImage:normalImage
                                 selectedImage:selectdImage
                                         title:title];
     
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
        [item addGestureRecognizer:tap];
        
        if (i == 0) {
            item.selected = YES;
        }
       
        
        CGFloat itemW = kTabWidth / count;
        CGFloat itemX = i * itemW;
        item.x = itemX;
        item.width = itemW;
        item.height = self.height;
        
        [self.backgroundImageView addSubview:item];
        
      
//        
//        [item addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.itemArray addObject:item];
       
    }
    
    
   
    
}


#pragma mark - setProperties
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    
    _backgroundColor = backgroundColor;
    
    self.backgroundImageView.backgroundColor = backgroundColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    
    _backgroundImage = backgroundImage;
    self.backgroundImageView.image = backgroundImage;
    
}

- (void)setItemNormalColor:(UIColor *)itemNormalColor {
    
    _itemNormalColor = itemNormalColor;
    
    [self.itemArray enumerateObjectsUsingBlock:^(TabItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.itemNormalColor = itemNormalColor;
    }];
    
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor {
    
    _itemSelectedColor = itemSelectedColor;
    
    [self.itemArray enumerateObjectsUsingBlock:^(TabItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.itemSelectedColor = itemSelectedColor;
        
    }];
    
}

- (void)setTitleMargin:(CGFloat)titleMargin {
    
    _titleMargin = titleMargin;
    
    [self.itemArray enumerateObjectsUsingBlock:^(TabItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.titleMargin = titleMargin;
    }];
}

- (void)setItemFont:(UIFont *)itemFont {
    
    _itemFont = itemFont;
    
    [self.itemArray enumerateObjectsUsingBlock:^(TabItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.itemFont = itemFont;
    }];
}

- (void)setAnimation:(BOOL)animation {
    
    _animation = animation;
    
    [self.itemArray enumerateObjectsUsingBlock:^(TabItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.animated = animation;
    }];
    
}

- (void)setDelegate:(id<TabarDelegate>)delegate {
    
    _delegate = delegate;
    
    TabItem *item = self.itemArray.firstObject;
    
    [self btnAction:item.gestureRecognizers.firstObject];
    
}


#pragma mark - TabItemDelegate
- (void)btnAction:(UITapGestureRecognizer *)reco {
    
    TabItem *item = (TabItem *)reco.view;
    
    __weak TabBarView *weakSelf = self;
    
    //刚刚点的按钮，跟现在点的一致。
    __block BOOL same = NO;
    
    [self.itemArray enumerateObjectsUsingBlock:^(TabItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        if ([item isEqual:obj]) {
            
            if (idx == weakSelf.beforeIndex) {
                same = YES;
                *stop = YES;
            }
            
            item.selected = YES;
            weakSelf.beforeIndex = idx;
            
        }else{
            obj.selected = NO;
        }
        
    }];
    
    
    if (same) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidSelect:index: title:)]) {
        [self.delegate tabBarDidSelect:self index:self.beforeIndex title:self.titles.count?[self.titles objectAtIndex:self.beforeIndex]:@""];
    }
    
    
}


@end
