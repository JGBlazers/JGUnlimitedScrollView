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

## ☆☆☆ “四、轮播器头文件暴露在外面的方法属性介绍，想要改变轮播器的相关实现方式，可以参考头文件进行配置” ☆☆☆
## <a id="JGUnlimitedScrollView.h"></a>JGUnlimitedScrollView.h
### *代理方法
```objc
/**
 *  点击banner图片item的时候调用
 *
 *  @param unlimitedScrollView 无限轮播器的对象
 *  @param index               当前图片的item索引
 */
- (void)unlimitedScrollView:(JGUnlimitedScrollView *)unlimitedScrollView didClickItemWithIndex:(NSInteger)index;

/**
 *  轮播器每当切换页数的时候调用，包括点击自带的pageControl切换，拖动切换，自动轮播切换
 *  注意：此方法，可在自定义PageControl的时候，在这个方法中，切换对应的CurrentPage，和方法didClickCustomPageControlWithIndex一起使用
 *  @param unlimitedScrollView 无限轮播器的对象
 *  @param index               切换结束后，当前的banner的item的索引
 */
- (void)unlimitedScrollView:(JGUnlimitedScrollView *)unlimitedScrollView didMoveWithIndex:(NSInteger)index;
```
---------------------------------------------------------------------------------------------------------------

### * 可配置的基本属性
```objc
// 滚动类型
typedef enum {
    JGUnlimitedScrollViewStyleHorizontal,   // 默认水平滚动
    JGUnlimitedScrollViewStyleVertical,     // 垂直滚动
} JGUnlimitedScrollViewStyle;

// 滚动类型
typedef enum {
    JGUnlimitedPageControlStyleOfCenter,   // 默认中心点
    JGUnlimitedPageControlStyleOfLeft,     // 左边
    JGUnlimitedPageControlStyleOfRight,    // 右边
    JGUnlimitedPageControlStyleOfCustom,   // 自定义UIPageControl
} JGUnlimitedPageControlStyle;

/**  代理  */
@property (nonatomic, assign) id <JGScrollViewDelegate> delegate;

/**  轮播器的图片数量  */
@property (nonatomic, strong) NSArray *bannerImages;

/**  占位图，默认为工具类自带的占位图  */
@property (nonatomic, strong) UIImage *placeholder;

/**  图片附带的内容数组  特别注意，内容数组的个数和图片的个数不一致的情况下，也显示不出来  */
@property (nonatomic, strong) NSArray *contentArray;

/**  是否开启自动轮播 默认是自动轮播，但是如果图片的数组个数<2时也不会自动播放  */
@property (nonatomic, assign) BOOL isOpenAutoMove;

/**  定时器的时间间隔 默认是 2s  */
@property (nonatomic, assign) CGFloat timeInteval;

/**  滚动类型  */
@property (nonatomic, assign) JGUnlimitedScrollViewStyle style;

/**  分页标记UIPageControl的位置配置  */
@property (nonatomic, assign) JGUnlimitedPageControlStyle pageControlStyle;


// --------------------------  此为配置UIPageControl的相关属性  -----------------------
/**  当前点的颜色  */
@property (nonatomic, strong) UIColor *currentPageColor;

/**  其他点的颜色  */
@property (nonatomic, strong) UIColor *otherPageColor;

/**  UIPageControl的背景颜色  */
@property (nonatomic, strong) UIColor *pageControlBgColor;

```
---------------------------------------------------------------------------------------------------------------

### * 可配置的函数
```objc
// --------------------------  定时器的操作  -----------------------
/**
 *  开启定时器，开启自动轮播    -> 自动轮播条件，图片的个数必须要大于1个
 */
- (void)autoMoveOfStart;
/**
 *  轮播结束，移除定时器等
 */
- (void)autoMoveOfFinish;
/**
 *  是否要暂停定时器，此方法综合了- (void)autoMoveOfStart;- (void)autoMoveOfFinish;这两个方法的功能，如果在需要的时候调用autoMoveOfFinish，想要开启的时候，调用autoMoveOfStart进行开启，而本方法，如果传YES的时候，移除定时器，关闭自动轮播，YES的时候开启自动轮播
 *
 *  @param isPause 是否暂停
 */
- (void)autoMoveOfPause:(BOOL)isPause;

// --------------------------  自定义PageControl需要调用的方法  -----------------------
/**
 *  此方法，提供外部自定义PageControl的点击，来控制轮播器的切换的功能，
 注意：如果想要用pageController来切换轮播器，就必须要通过这个方法，将对应的currentPage的索引传过来
 *
 *  @param index               要切换到哪个banner
 */
- (void)didClickCustomPageControlWithIndex:(NSInteger)index;

/**
 *  初始化方法
 *
 *  @return 本类实例后的对象
 */
- (instancetype)initWithFrame:(CGRect)frame bannerImages:(NSArray *)banners;
```
---------------------------------------------------------------------------------------------------------------

## ☆☆☆ “五、总结” ☆☆☆
### * 轮播器是现在APP中，极为流行的一种功能之一，本人本着一起学习，相互进步的想法，针对轮播器的基本功能进行封装，上传此1.0版本。如果能更好的帮助到需要的老铁，本人会深感欣慰。
### * 如果正在使用这个demo的老铁，在使用的过程中，如果发现任何问题或者更好的功能拓展和改进方法，可以通过QQ邮箱2044471447@qq.com联系本人，本人也会对此demo长期维护，争取拓展更多常见轮播器相关的功能
### * 谢谢！
