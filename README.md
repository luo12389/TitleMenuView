# TitleMenuView
  仿新闻app的菜单滚动条，适合新手学习，全程小白级代码。
###使用方法
  把压缩文件中的TitleMenuView.h和TitleMenuView.m两个文件放入项目文件夹使用
####初始化方法
``` 
-(instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)array 
WithStyle:(TitleMenuScrollViewStyle) titleMenuStyle WithTitleFont:(CGFloat)font AndTitleInterval:(CGFloat)space;
```
####风格样式
![](https://github.com/luo12389/TitleMenuView/blob/master/gif/default.gif)
![](https://github.com/luo12389/TitleMenuView/blob/master/gif/line.gif)
![](https://github.com/luo12389/TitleMenuView/blob/master/gif/playground.gif)
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
####使用方法
```
//数组如果不是这样的格式，可能会造成标题不显示或报错
NSArray *array = @[@{@"新闻":[[FirstViewController alloc]init]}];
TitleMenuView *titleMenu = [[TitleMenuView alloc]initWithFrame:CGRectMake(0, 64, mainWidth, mainHeight-20) 
WithViewControllers:array WithStyle:TitleMenuStyleDefault WithTitleFont:15 AndTitleInterval:20];
```
提示:如果有navigationcontroller,要加上self.automaticallyAdjustsScrollViewInsets = NO(去掉头部留白);
