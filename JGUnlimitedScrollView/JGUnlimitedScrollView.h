//
//  JGUnlimitedScrollView.h
//  无限轮播器
//
//  Created by FCG on 2017/5/27.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@class JGUnlimitedScrollView;
@protocol JGScrollViewDelegate <NSObject>
@optional

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

@end

@interface JGUnlimitedScrollView : UIView

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

@end
