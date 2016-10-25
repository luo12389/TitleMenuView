//
//  TitleMenuView.m
//  TitleMenuView
//
//  Created by luochen on 16/5/20.
//  Copyright © 2016年 luochen. All rights reserved.
//

#import "TitleMenuView.h"

@implementation TitleMenuView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)array WithStyle:(TitleMenuScrollViewStyle)titleMenuStyle WithTitleFont:(CGFloat)font AndTitleInterval:(CGFloat)space
{
    if (self = [super initWithFrame:frame])
    {
        vcsArray = array;
        
        btnSpace = space;
        
        titleFont = font;
        
        typeStyle = titleMenuStyle;
        
        self.btnNormalColor = [UIColor lightGrayColor];
        
        self.btnSelectedColor = [UIColor blackColor];
        
        self.sliderColor = [UIColor blackColor];
        
        [self creatTitleMenuScrollView];
        
        [self creatVCScrollView];
        
        self.appearMethodExists = NO;
    }
    
    return  self;
}

#pragma mark 创建按钮菜单
-  (void)creatTitleMenuScrollView
{
    btnScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAINWIDTH, 30)];
    
    btnScrollView.showsVerticalScrollIndicator = NO;
    
    btnScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:btnScrollView];
    
    CGFloat contentSizeX = 0;
    
    buttonsArray = [NSMutableArray array];
    
    for (int i = 0; i < vcsArray.count; i++)
    {
        UIButton *btn = [[UIButton alloc]init];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:titleFont];
        
        btn.tag = i;
        
        btnWidth = titleFont*2+btnSpace/2;
        
        if(typeStyle == TitleMenuStyleScreen)
        {
            btnWidth = MAINWIDTH/vcsArray.count;
            
            btn.frame = CGRectMake(btnWidth*i, 5, btnWidth, 20);
        }
        else
        {
            contentSizeX += btnWidth;
            
            if (i == 0)
            {
                btn.frame = CGRectMake(btnSpace/2, 5, btnWidth, 20);
            }
            else
            {
                UIButton *button = buttonsArray[i-1];
                
                btn.frame = CGRectMake(button.frame.origin.x+button.frame.size.width+btnSpace, 5, btnWidth, 20);
            }
        }
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == 0)
        {
            [btn setTitleColor:self.btnSelectedColor forState:UIControlStateNormal];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
            
            if (typeStyle == TitleMenuStyleLine || typeStyle == TitleMenuStyleScreen)
            {
                btnSliderView = [[UIView alloc]initWithFrame:CGRectMake(btn.frame.origin.x, 28, btn.frame.size.width, 2)];
                
                [btnScrollView addSubview:btnSliderView];
                
                btnSliderView.backgroundColor = self.sliderColor;
            }
            else if (typeStyle == TitleMenuStylePlayGround)
            {
                btnSliderView = [[UIView alloc]initWithFrame:btn.frame];
                
                [btnScrollView addSubview:btnSliderView];
                
                btnSliderView.layer.cornerRadius = 10;
                
                btnSliderView.backgroundColor = self.sliderColor;
            }
        }
        else
        {
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            
            [btn setTitleColor:self.btnNormalColor forState:UIControlStateNormal];
        }
        
        [buttonsArray addObject:btn];
        
        [btnScrollView addSubview:btn];
    }
    
    btnScrollView.contentSize = CGSizeMake(contentSizeX+vcsArray.count*btnSpace, 0);
}

#pragma mark 创建控制器sc
- (void)creatVCScrollView
{
    vcScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, btnScrollView.frame.origin.y+btnScrollView.frame.size.height, MAINWIDTH, MAINHEIGHT-94)];
    
    [self addSubview:vcScrollView];
    
    loadVcArray = [NSMutableArray array];
    
    vcScrollView.delegate = self;
    
    for (int i = 0;  i < vcsArray.count; i++)
    {
        UIViewController *vc = vcsArray[i];
        
        vc.view.frame = CGRectMake(i*MAINWIDTH, 0, MAINWIDTH, vcScrollView.frame.size.height);
        
        vc.view.backgroundColor = [UIColor grayColor];
        
        [vcScrollView addSubview:vc.view];
        
        UIButton * btn = buttonsArray[i];
        
        if (i == 0)
        {
            [btn setTitle:vc.title forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitle:vc.title forState:UIControlStateNormal];
        }
        
        [loadVcArray addObject:vc];
    }
    
    vcScrollView.contentSize = CGSizeMake(MAINWIDTH*vcsArray.count, 0);
    
    vcScrollView.pagingEnabled = YES;
    
    vcScrollView.bounces = NO;
    
    vcScrollView.showsVerticalScrollIndicator = NO;
    
    vcScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark 开始滚动的时候
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float num = vcScrollView.contentOffset.x/MAINWIDTH;
    
    CGRect frame = btnSliderView.frame;
    
    frame.origin.x =btnSpace*(num+0.5)+btnWidth*num;
    
    if(typeStyle == TitleMenuStyleScreen)
    {
        frame.origin.x = num*btnWidth;
    }
    
    btnSliderView.frame = frame;
}

#pragma mark 滚动结束后
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNum = vcScrollView.contentOffset.x/MAINWIDTH;
    
    for (UIButton *btn in buttonsArray)
    {
        if (btn.tag == pageNum)
        {
            [btn setTitleColor:self.btnSelectedColor forState:UIControlStateNormal];
            
        }
        else
        {
            [btn setTitleColor:self.btnNormalColor forState:UIControlStateNormal];
        }
    }
    [self offset:pageNum];
    
    if (self.appearMethodExists)
    {
        UIViewController * vc = loadVcArray[pageNum];
        
        [vc viewDidAppear:YES];
    }
}

#pragma mark 偏移量调整
- (void)offset:(NSInteger)page;
{
    if(typeStyle != TitleMenuStyleScreen)
    {
        UIButton *btn = buttonsArray[page];
        
        CGFloat offset = btn.center.x - MAINWIDTH*0.5;
        
        if (offset < 0)
        {
            offset = 0;
        }
        
        CGFloat maxOffset = btnScrollView.contentSize.width - MAINWIDTH;
        
        if (offset > maxOffset)
        {
            offset = maxOffset;
        }
        
        [btnScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    }
}

#pragma mark 按钮点击事件
- (void)buttonClick:(id)sender
{
    UIButton *btnSender = sender;
    
    for (UIButton *btn in buttonsArray)
    {
        if (btn.tag == btnSender.tag)
        {
            [btn setTitleColor:self.btnSelectedColor forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitleColor:self.btnNormalColor forState:UIControlStateNormal];
        }
    }
    
    [vcScrollView setContentOffset:CGPointMake(MAINWIDTH*btnSender.tag, 0) animated:YES];
    
    [self offset:btnSender.tag];
}


#pragma mark - 属性设置
- (void)setTitleMenuBackGroundColor:(UIColor *)titleMenuBackGroundColor
{
    _titleMenuBackGroundColor = titleMenuBackGroundColor;
    
    btnScrollView.backgroundColor = _titleMenuBackGroundColor;
}


- (void)setBtnNormalColor:(UIColor *)btnNormalColor
{
    _btnNormalColor = btnNormalColor;
    
    for (UIButton *btn in buttonsArray)
    {
        if (btn.tag != 0)
        {
            [btn setTitleColor:_btnNormalColor forState:UIControlStateNormal];
        }
    }
}

- (void)setBtnSelectedColor:(UIColor *)btnSelectedColor
{
    _btnSelectedColor = btnSelectedColor;
    
    for (UIButton *btn in buttonsArray)
    {
        if (btn.tag == 0)
        {
            [btn setTitleColor:_btnSelectedColor forState:UIControlStateNormal];
        }
    }
}

- (void)setSliderColor:(UIColor *)sliderColor
{
    _sliderColor = sliderColor;
    
    btnSliderView.backgroundColor = _sliderColor;
}

- (void)setAppearMethodExists:(BOOL)appearMethodExists
{
    _appearMethodExists = appearMethodExists;
    
    if(_appearMethodExists)
    {
        UIViewController *vc = loadVcArray[0];
        
        [vc viewDidAppear:YES];
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
