//
//  TitleMenuView.h
//  TitleMenuView
//
//  Created by luochen on 16/5/20.
//  Copyright © 2016年 luochen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAINWIDTH    [UIScreen mainScreen].bounds.size.width
#define MAINHEIGHT   [UIScreen mainScreen].bounds.size.height
@interface TitleMenuView : UIView<UIScrollViewDelegate>
{
    UIScrollView *btnScrollView;
    UIScrollView *vcScrollView;
    UIView *btnSliderView;
    NSMutableArray *buttonsArray;
    NSMutableArray *loadVcArray;
    NSArray *vcsArray;
    CGFloat btnWidth;
    CGFloat btnSpace;
    CGFloat titleFont;
    NSInteger typeStyle;
}

typedef NS_ENUM(NSInteger, TitleMenuScrollViewStyle)
{
    TitleMenuStyleDefault = 0,
    TitleMenuStylePlayGround = 1,
    TitleMenuStyleLine = 2,
    TitleMenuStyleScreen = 3,
};

//按钮字体的默认颜色
@property (nonatomic, strong) UIColor *btnNormalColor;
//按钮选中时字体的颜色
@property (nonatomic, strong) UIColor *btnSelectedColor;
//标题栏的背景颜色
@property (nonatomic, strong) UIColor *titleMenuBackGroundColor;
//滚动条的颜色
@property (nonatomic, strong) UIColor *sliderColor;
//是否有appear的相关方法
@property (nonatomic, assign) BOOL appearMethodExists;

- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)array WithStyle:(TitleMenuScrollViewStyle)titleMenuStyle WithTitleFont:(CGFloat)font AndTitleInterval:(CGFloat)space;

@end
