//
//  ViewController.m
//  TitleMenuView
//
//  Created by luochen on 16/5/19.
//  Copyright © 2016年 luochen. All rights reserved.
//

#import "ViewController.h"
#import "TitleMenuView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"
#import "SevenViewController.h"
#import "EightViewController.h"
#import "TenViewController.h"
#import "NineThViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *first = [[FirstViewController alloc]init];
    first.title = @"新闻";
    
    SecondViewController *sec = [[SecondViewController alloc]init];
    sec.title = @"娱乐";
    
    ThirdViewController *third = [[ThirdViewController alloc]init];
    third.title =@"军事";
    
    FourthViewController *four = [[FourthViewController alloc]init];
    four.title = @"科技";
    
    FifthViewController * fifth = [[FifthViewController alloc]init];
    fifth.title = @"体育";
    
    SixthViewController *six = [[SixthViewController alloc]init];
    six.title = @"财经";
    
    SevenViewController *seve = [[SevenViewController alloc]init];
    seve.title = @"头条";
    
    NSArray *array = @[first,sec,third,four,fifth,six,seve];
    
    TitleMenuView *titleMenu = [[TitleMenuView alloc]initWithFrame:CGRectMake(0, 64, MAINWIDTH, MAINHEIGHT-20) WithViewControllers:array WithStyle:TitleMenuStyleDefault WithTitleFont:15 AndTitleInterval:25];
    
    titleMenu.appearMethodExists = YES;
    
    titleMenu.btnSelectedColor = [UIColor darkGrayColor];

    titleMenu.btnNormalColor = [UIColor blackColor];
    
    titleMenu.sliderColor = [UIColor orangeColor];
    
    [self.view addSubview:titleMenu];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
