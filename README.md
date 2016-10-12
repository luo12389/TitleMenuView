TitleMenuView
===
- 简单易懂的菜单滚动条。
### 使用方法
  把压缩文件中的TitleMenuView.h和TitleMenuView.m两个文件放入项目文件夹,引入头文件后使用
### 初始化方法
```
-(instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)array 
WithStyle:(TitleMenuScrollViewStyle) titleMenuStyle WithTitleFont:(CGFloat)font AndTitleInterval:(CGFloat)space;
```
### 风格样式
![](https://github.com/luo12389/TitleMenuView/blob/master/gif/default.gif)
![](https://github.com/luo12389/TitleMenuView/blob/master/gif/line.gif)
![](https://github.com/luo12389/TitleMenuView/blob/master/gif/playground.gif)
![](https://github.com/luo12389/TitleMenuView/blob/master/gif/screen.gif)

### 可设置的属性
```
//按钮字体的默认颜色
@property (nonatomic, strong) UIColor *btnNormalColor;
//按钮选中时字体的颜色
@property (nonatomic, strong) UIColor *btnSelectedColor;
//菜单栏的背景颜色
@property (nonatomic, strong) UIColor *titleMenuBackGroundColor;
//滚动条的颜色
@property (nonatomic, strong) UIColor *sliderColor;
//是否有appear的相关方法
@property (nonatomic, assign) BOOL appearMethodExists;
```

### 初始化格式
```
为了方便写代理,建议这样初始化控制器和数组
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

TitleMenuView *titleMenu = [[TitleMenuView alloc]initWithFrame:CGRectMake(0, 64, MAINWIDTH, MAINHEIGHT-20) WithViewControllers:array WithStyle:TitleMenuStyleScreen WithTitleFont:15 AndTitleInterval:25];

titleMenu.btnSelectedColor = [UIColor darkGrayColor];

titleMenu.btnNormalColor = [UIColor blackColor];

titleMenu.sliderColor = [UIColor orangeColor];

[self.view addSubview:titleMenu];

```

### 关于写了appear方法却没有进appear方法的问题
- (void)viewWillAppear:(BOOL)animated;  
- (void)viewDidAppear:(BOOL)animated;     
- (void)viewWillDisappear:(BOOL)animated; 
- (void)viewDidDisappear:(BOOL)animated;

原因请看这个:[关于viewappear不被调用的疑问](http://blog.chinaunix.net/uid-25458681-id-3287785.html)</br>
解决办法:作者在初始化第一个页面的时候,就手动调用第一个页面的viewappear(前提appearMethodExists = YES),当滚动页面结束后,会根据当前页面的下标获取到该页面,然后进行手动调用(作者只写了viewappear的调用,如有需要用到其他3个方法,请在.m文件的219行和319行自行修改)</br>

### 提示
* 如果需要在初始化页面的时候进行网络请求,最好写在viewDidAppear方法里面,因为在初始化titleMenu的时候会逐个初始化多个页面,如果把网络请求写在viewDidLoad里面,会同时进行多个网络请求,会造成卡顿(尤其是网络请求返回的数据中有大量图片)
* 如果UITableBarController,只有修改vcScrollView的高度就好了(初始化控制器的view的高度是根据scrollView的高度设定的)
* 如果有navigationcontroller,要加上self.automaticallyAdjustsScrollViewInsets = NO(去掉头部留白)

如果有任何问题或者好的建议,欢迎联系：Email:<1224631767@qq.com>,qq:1224631767
