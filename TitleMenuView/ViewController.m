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
    
    NSArray *array = @[@{@"新闻":[[FirstViewController alloc]init]},
                     @{@"娱乐":[[SecondViewController alloc]init]},
                     @{@"体育":[[ThirdViewController alloc]init]},
//                     @{@"军事":[[FourthViewController alloc]init]},
//                     @{@"科技":[[FifthViewController alloc]init]},
//                     @{@"财经":[[SixthViewController alloc]init]},
//                     @{@"头条":[[SevenViewController alloc]init]},
//                     @{@"政治":[[EightViewController alloc]init]},
//                     @{@"你们":[[NineThViewController alloc]init]},
                     @{@"没有":[[TenViewController alloc]init]}];
    
    TitleMenuView *titleMenu = [[TitleMenuView alloc]initWithFrame:CGRectMake(0, 64, MAINWIDTH, MAINHEIGHT-20) WithViewControllers:array WithStyle:TitleMenuStyleScreen WithTitleFont:15 AndTitleInterval:20];
    
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
