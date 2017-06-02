# ☆☆☆ JGUnlimitedScrollView(无限轮播器) ☆☆☆ 

###
## ☆☆☆ “一、总体功能介绍” ☆☆☆
### * 静态(需手动)滚动banner
### * 自动滚动banner(无限自动滚动)
### * 支持上下滚动
### * 支持图片和文字同时展示
### * 如果现有的UIPageControl不满足需要的情况下，可参考demo，将自己的UIPageControl无缝联结到轮播器中
### * 加载的图片，支持的类型有：jpg、png、UIImage对象、URL、图片的URL地址等
---------------------------------------------------------------------------------------------------------------


###
## ☆☆☆ “二、功能预览图” ☆☆☆
![普通情况和手动轮播预览](https://github.com/fcgIsPioneer/iOS_Demo_Gif_manager/blob/master/无限轮播器(JGUnlimitedScrollView)/普通情况和手动轮播预览.gif)
![网络图片加载和垂直滚动](https://github.com/fcgIsPioneer/iOS_Demo_Gif_manager/blob/master/无限轮播器(JGUnlimitedScrollView)/网络图片加载和垂直滚动.gif)
![自定义UIPageControl](https://github.com/fcgIsPioneer/iOS_Demo_Gif_manager/blob/master/无限轮播器(JGUnlimitedScrollView)/自定义UIPageControl.gif)
---------------------------------------------------------------------------------------------------------------

## ☆☆☆ “三、轮播器的基本使用和详细功能分析” ☆☆☆
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

### * 实现上下滚动，只需要将"style"这个属性设置成 "JGUnlimitedScrollViewStyleVertical" 即可，代码如下：
```objc
/**  组装所需要轮播的图片数组  */
NSArray *banners = @[[UIImage imageNamed:@"h1.jpg"],@"h2",@"h3.jpg",@"h4.jpg"];

/**  初始化轮播器  */
JGUnlimitedScrollView *scrollView = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180) bannerImages:banners];
// 实现上下滚动
scrollView.style = JGUnlimitedScrollViewStyleVertical;
[self.view addSubview:scrollView];
```
---------------------------------------------------------------------------------------------------------------

### * 实现图片和文字同时展示，将对应banner图片的文字组装成数组赋值给"contentArray"即可，代码如下：
```objc
/**  组装所需要轮播的图片数组  */
NSArray *banners = @[[UIImage imageNamed:@"h1.jpg"],@"h2",@"h3.jpg",@"h4.jpg"];

/**  初始化轮播器  */
JGUnlimitedScrollView *scrollView1 = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180) bannerImages:banners];
[self.view addSubview:scrollView1];
// 将对应banner图片的文字组装成数组赋值给contentArray即可
scrollView1.contentArray = @[@"第一个版本正式提交，感谢您的支持！",@"在使用的过程中",@"如果代码在使用过程中出现问题",@"您可以将问题发送到2044471447@qq.com邮箱上，在收到的第一时间会做出处理，再次感谢"];
```
---------------------------------------------------------------------------------------------------------------

### * 自定义UIPageControl
```objc
/**  组装所需要轮播的图片数组  */
NSArray *banners = @[[UIImage imageNamed:@"h1.jpg"],@"h2",@"h3.jpg",@"h4.jpg"];

/**  初始化轮播器  */
__block JGUnlimitedScrollView *scrollView = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180) bannerImages:banners];
scrollView.delegate = self;

// 要想自定义pageControl，避免出错，最好要设置这个属性为自定义
scrollView.pageControlStyle = JGUnlimitedPageControlStyleOfCustom;
[self.view addSubview:scrollView];

/**  自定义UIPageControl  */
JGTestCustomPageControl *cPageControl = [[JGTestCustomPageControl alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180)];
cPageControl.pageNum = scrollView.bannerImages.count;
[scrollView addSubview:cPageControl];
self.cPageControl = cPageControl;

// 在通过pageControl来控制轮播器的滚动的时候，要将对应page的当前页数索引，通过轮播器的方法didClickCustomPageControlWithIndex:传给轮播器
cPageControl.clickBlock = ^(NSInteger currentPage) {
    [scrollView didClickCustomPageControlWithIndex:currentPage];
};

// 要想轮播器的滚动时，PageControl也对应的跳到对应的点上，就要在轮播器的代理方法 "-unlimitedScrollView:didMoveWithIndex:"中，拿到当前的页数赋值给PageControl
/**
 *  轮播器每当切换页数的时候调用，包括点击自带的pageControl切换，拖动切换，自动轮播切换
 *  注意：此方法，可在自定义PageControl的时候，在这个方法中，切换对应的CurrentPage，和方法didClickCustomPageControlWithIndex一起使用
 *  @param unlimitedScrollView 无限轮播器的对象
 *  @param index               切换结束后，当前的banner的item的索引
 */

- (void)unlimitedScrollView:(JGUnlimitedScrollView *)unlimitedScrollView didMoveWithIndex:(NSInteger)index {
    self.cPageControl.currentPage = index;
}
```
---------------------------------------------------------------------------------------------------------------

































