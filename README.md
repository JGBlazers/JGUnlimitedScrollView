# ☆☆☆ JGUnlimitedScrollView(无限轮播器) ☆☆☆ 
###
## ☆☆☆ “一、总体功能介绍” ☆☆☆
### * 静态(需手动)滚动banner
### * 自动滚动banner(无限自动滚动)
### * 支持上下滚动
### * 支持图片和文字同时展示
### * 如果现有的UIPageControl不满足需要的情况下，可参考demo，将自己的UIPageControl无缝联结到轮播器中
### * 加载的图片，支持的类型有：jpg、png、UIImage对象、URL、图片的URL地址等

###
## ☆☆☆ “二、轮播器的基本使用和详细功能分析” ☆☆☆
###
### * 普通情况下，一步创建轮播器，实现代码如下：
#### 1、 初始化方法方式一：先通过系统的常规初始化方法，将轮播器初始化，后面再传入对应需要轮播的图片即可
#### 2、 初始化方法方式一：通过方法"- (instancetype)initWithFrame:(CGRect)frame bannerImages:(NSArray *)banners"，在初始化的同时将图片传递过来
#### 3、详细代码参考如下：
``` objc
/**  组装所需要轮播的图片数组  */
NSArray *banners = @[[UIImage imageNamed:@"h1.jpg"],@"h2",@"h3.jpg",@"h4.jpg"];

/**  初始化轮播器方式一  */
JGUnlimitedScrollView *scrollView = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180) bannerImages:banners];
[self.view addSubview:scrollView];

/**  初始化轮播器方式二  */
JGUnlimitedScrollView *scrollView = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180)];
scrollView.bannerImages = banners;
[self.view addSubview:scrollView];
```
---------------------------------------------------------------------------------------------------------------

### * 实现静态(需手动)滚动banner，只需要将"isOpenAutoMove"这个属性设置成NO即可，代码如下：
```objc
/**  组装所需要轮播的图片数组  */
NSArray *banners = @[[UIImage imageNamed:@"h1.jpg"],@"h2",@"h3.jpg",@"h4.jpg"];

/**  初始化轮播器  */
JGUnlimitedScrollView *scrollView = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180) bannerImages:banners];
// 设置成静止的轮播器，滚动是要手动进行
scrollView.isOpenAutoMove = NO;
[self.view addSubview:scrollView];
```
---------------------------------------------------------------------------------------------------------------

