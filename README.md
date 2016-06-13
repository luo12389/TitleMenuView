# TitleMenuView
  仿新闻app的菜单滚动条，适合新手学习，全程小白级代码。
###使用方法
  把压缩文件中的TitleMenuView.h和TitleMenuView.m两个文件放入项目文件夹使用
  
####初始化方法
``` 
-(instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)array 
WithStyle:(TitleMenuScrollViewStyle) titleMenuStyle WithTitleFont:(CGFloat)font AndTitleInterval:(CGFloat)space;
```
####可设置的属性
```
//按钮字体的默认颜色
@property (nonatomic, strong) UIColor *btnNormalColor;
//按钮选中时字体的颜色
@property (nonatomic, strong) UIColor *btnSelectedColor;
//标题栏的背景颜色
@property (nonatomic, strong) UIColor *titleMenuBackGroundColor;
//滚动条的颜色
@property (nonatomic, strong) UIColor *sliderColor;
```
####使用发法
```
NSArray *array = @[@{@"新闻":[[FirstViewController alloc]init]}];
TitleMenuView *titleMenu = [[TitleMenuView alloc]initWithFrame:CGRectMake(0, 64, mainWidth, mainHeight-20) 
WithViewControllers:array WithStyle:TitleMenuStyleDefault WithTitleFont:15 AndTitleInterval:20];
```
