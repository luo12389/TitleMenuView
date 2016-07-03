//
//  TitleMenuView.m
//  TitleMenuView
//
//  Created by luochen on 16/5/20.
//  Copyright © 2016年 luochen. All rights reserved.
//

#import "TitleMenuView.h"

@implementation TitleMenuView

- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)array WithStyle:(TitleMenuScrollViewStyle)titleMenuStyle WithTitleFont:(CGFloat)font AndTitleInterval:(CGFloat)space
{
    if (self = [super initWithFrame:frame])
    {
        vcsArray = array;
        
        btnSpace = space;
        
        titleFont = font;
        
        self.viewStyle = titleMenuStyle;
        
        self.btnNormalColor = [UIColor lightGrayColor];
        
        self.btnSelectedColor = [UIColor blackColor];
        
        self.sliderColor = [UIColor blackColor];
        
        [self creatTitleMenuScrollView];
        
        [self creatVCScrollView];
    }
    
    return  self;
}

-  (void)creatTitleMenuScrollView
{
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAINWIDTH, 30)];
    
    mainScrollView.showsVerticalScrollIndicator = NO;
    
    mainScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:mainScrollView];
    
    CGFloat contentSizeX = 0;
    
    buttonsArray = [NSMutableArray array];
    
    for (int i = 0; i < vcsArray.count; i++)
    {
        UIButton *btn = [[UIButton alloc]init];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:titleFont];
        
        btn.tag = i;
        
        NSDictionary *dic = vcsArray[i];
        
        NSString *title = [dic allKeys][0];
        
        btnWidth = titleFont*title.length+btnSpace/2;
        
        if(self.viewStyle == TitleMenuStyleScreen)
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
        [btn  setTitle:title forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == 0)
        {
            [btn setTitleColor:self.btnSelectedColor forState:UIControlStateNormal];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
            
            if (self.viewStyle == TitleMenuStyleLine || self.viewStyle == TitleMenuStyleScreen)
            {
                btnSliderView = [[UIView alloc]initWithFrame:CGRectMake(btn.frame.origin.x, 28, btn.frame.size.width, 2)];
                
                [mainScrollView addSubview:btnSliderView];
                
                btnSliderView.backgroundColor = self.sliderColor;
            }
            else if (self.viewStyle == TitleMenuStylePlayGround)
            {
                btnSliderView = [[UIView alloc]initWithFrame:btn.frame];
                
                [mainScrollView addSubview:btnSliderView];
                
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
        
        [mainScrollView addSubview:btn];
    }
    
    mainScrollView.contentSize = CGSizeMake(contentSizeX+vcsArray.count*btnSpace, 0);
}

- (void)creatVCScrollView
{
    vcScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, mainScrollView.frame.origin.y+mainScrollView.frame.size.height, MAINWIDTH, MAINHEIGHT-94)];
    
    [self addSubview:vcScrollView];
    
    vcScrollView.delegate = self;
    
    for (int i = 0;  i < vcsArray.count; i++)
    {
        NSDictionary *dic = vcsArray[i];
        
        UIViewController *vc = [dic valueForKey:[dic allKeys][0]];
        
        vc.view.frame = CGRectMake(i*MAINWIDTH, 0, MAINWIDTH, vcScrollView.frame.size.height);
        
        vc.view.backgroundColor = [UIColor grayColor];
        
        [vcScrollView addSubview:vc.view];
    }
    
    vcScrollView.contentSize = CGSizeMake(MAINWIDTH*vcsArray.count, 0);
    
    vcScrollView.pagingEnabled = YES;
    
    vcScrollView.bounces = NO;
    
    vcScrollView.showsVerticalScrollIndicator = NO;
    
    vcScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float num = vcScrollView.contentOffset.x/MAINWIDTH;
    
    CGRect frame = btnSliderView.frame;
    
    frame.origin.x =btnSpace*(num+0.5)+btnWidth*num;
    
    if(self.viewStyle == TitleMenuStyleScreen)
    {
        frame.origin.x = num*btnWidth;
    }
    
    btnSliderView.frame = frame;
}

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
    
    if(self.viewStyle != TitleMenuStyleScreen)
    {
        [self offset:pageNum];
    }
}

- (void)offset:(NSInteger)page;
{
    UIButton *btn = buttonsArray[page];

    CGFloat offset = btn.center.x - MAINWIDTH*0.5;

    if (offset < 0)
    {
        offset = 0;
    }

    CGFloat maxOffset = mainScrollView.contentSize.width - MAINWIDTH;

    if (offset > maxOffset)
    {
        offset = maxOffset;
    }

    [mainScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}


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
    
    //    [self offset:btnSender.tag];
}

- (void)setTitleMenuBackGroundColor:(UIColor *)titleMenuBackGroundColor
{
    _titleMenuBackGroundColor = titleMenuBackGroundColor;
    
    mainScrollView.backgroundColor = _titleMenuBackGroundColor;
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
