//
//  JGUnlimitedScrollView.m
//  无限轮播器
//
//  Created by FCG on 2017/5/27.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import "JGUnlimitedScrollView.h"
#import "JGUnlimtedScrollViewItem.h"

@interface JGUnlimitedScrollView ()<UICollectionViewDataSource, UICollectionViewDelegate>

/**  使用UICollectionView来做无限滚动的容器  */
@property (nonatomic, strong) UICollectionView *collectionView;

/**  图层  */
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

/**  容器内图片的个数  */
@property (nonatomic, strong) NSMutableArray <UIImageView *> *showImgViewArray;

/**  当前页的标志  */
@property (nonatomic, strong) UIPageControl *pageControl;

/**  定时器  */
@property (nonatomic, strong) NSTimer *timer;

/**  占位图片  */
@property (nonatomic, strong) UIImageView *placeHolderImgView;

/**  占位标题  */
@property (nonatomic, strong) UILabel *placeHolderLabel;

/**  保留用户传递过来的是否开启自动轮播的属性isOpenAutoMove，方便在停止和开启的过程中，保留着用户原有配置的效果  */
@property (nonatomic, assign) BOOL isOpenAutoMoveRetain;

@end

@implementation JGUnlimitedScrollView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self autoMoveOfFinish];
    }
}

- (void)didMoveToSuperview {
    [self viewController].automaticallyAdjustsScrollViewInsets = NO;
}

/**
 *  返回当前视图的控制器
 */
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/**
 *  初始化方法
 *
 *  @return 本类实例后的对象
 */
- (instancetype)initWithFrame:(CGRect)frame bannerImages:(NSArray *)banners {
    if (self = [super initWithFrame:frame]) {
        
        _bannerImages = banners;
        
        _isOpenAutoMove = banners.count > 1;
        
        self.isOpenAutoMoveRetain = _isOpenAutoMove;
        
        _timeInteval = 2;
        
        _style = JGUnlimitedScrollViewStyleHorizontal;
        
        _pageControlStyle = JGUnlimitedPageControlStyleOfCenter;
        
        _currentPageColor = [UIColor orangeColor];
        _otherPageColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = self.bounds.size;
        _flowLayout = flowLayout;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        [collectionView registerClass:[JGUnlimtedScrollViewItem class] forCellWithReuseIdentifier:@"BANNER_CELL"];
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.currentPageIndicatorTintColor = _currentPageColor;
        pageControl.pageIndicatorTintColor = _otherPageColor;
        pageControl.numberOfPages = banners.count;
        [pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        /**  占位图片  */
        UIImageView *placeHolderImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jg_imageview_placeholder"]];
        [self addSubview:placeHolderImgView];
        self.placeHolderImgView = placeHolderImgView;
        
        /**  占位标题  */
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"暂无图片";
        placeHolderLabel.textAlignment = NSTextAlignmentCenter;
        placeHolderLabel.font = [UIFont systemFontOfSize:20];
        placeHolderLabel.textColor = [UIColor blackColor];
        [placeHolderImgView addSubview:placeHolderLabel];
        self.placeHolderLabel = placeHolderLabel;
        
        // 滚动到第二组的第一个图片上
        [self scrollViewToFirstBanner];
        
        self.collectionView.hidden = banners.count == 0;
        self.placeHolderImgView.hidden = !self.collectionView.hidden;
        
        if (banners.count > 1) {
            [self moveToStart];
        }
    }
    return self;
}

#pragma - mark      ---------- 滚动到第二组的第一个图片上 ----------
- (void)scrollViewToFirstBanner {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.bannerImages.count > 0 && self.delegate && [self.delegate respondsToSelector:@selector(unlimitedScrollView:didMoveWithIndex:)]) {
            [self.delegate unlimitedScrollView:self didMoveWithIndex:0];
        }
        
        if (self.bannerImages.count < 2) {
            return;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.bannerImages.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.pageControl.currentPage = 0;
    });
}

#pragma - mark      ---------- 拦截属性的setter方法 ----------
- (void)setPlaceholder:(UIImage *)placeholder {
    
    if (!placeholder) placeholder = [UIImage imageNamed:@"jg_imageview_placeholder"];
    
    _placeholder = placeholder;
    
    self.placeHolderImgView.image = placeholder;
}

- (void)setTimeInteval:(CGFloat)timeInteval {
    _timeInteval = timeInteval;
    [self moveHandle];
}

- (void)setBannerImages:(NSArray *)bannerImages {
    _bannerImages = bannerImages;
    [self.collectionView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self moveHandle];
    });
    
    self.collectionView.hidden = bannerImages.count == 0;
    self.placeHolderImgView.hidden = !self.collectionView.hidden;
    
    self.pageControl.numberOfPages = bannerImages.count;
    
    // 滚动到第二组的第一个图片上
    [self scrollViewToFirstBanner];
    
    // 界面重新布局
    [self layoutSubviews];
}

- (void)setContentArray:(NSArray *)contentArray {
    if (contentArray == nil) {
        return;
    }
    _contentArray = contentArray;
    [self.collectionView reloadData];
}

- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    _currentPageColor = currentPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}

- (void)setOtherPageColor:(UIColor *)otherPageColor {
    _otherPageColor = otherPageColor;
    self.pageControl.pageIndicatorTintColor = otherPageColor;
}

- (void)setPageControlBgColor:(UIColor *)pageControlBgColor {
    _pageControlBgColor = pageControlBgColor;
    self.pageControl.backgroundColor = pageControlBgColor;
}

- (void)setIsOpenAutoMove:(BOOL)isOpenAutoMove {
    _isOpenAutoMove = isOpenAutoMove;
    self.isOpenAutoMoveRetain = isOpenAutoMove;
    
    [self moveHandle];
}

- (void)setStyle:(JGUnlimitedScrollViewStyle)style {
    _style = style;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self moveHandle];
        
        self.flowLayout.scrollDirection = style == JGUnlimitedScrollViewStyleHorizontal ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
        
        if (self.bannerImages.count) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    });
}

- (void)setPageControlStyle:(JGUnlimitedPageControlStyle)pageControlStyle {
    _pageControlStyle = pageControlStyle;
    [self layoutSubviews];
    if (pageControlStyle == JGUnlimitedPageControlStyleOfCustom) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
}

#pragma - mark      ---------- 定时器相关 ----------
/**
 *  开启定时器
 */
- (void)moveToStart {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInteval target:self selector:@selector(move) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)autoMoveOfStart {
    _isOpenAutoMove = YES;
    [self moveToStart];
}

/**
 *  关闭定时器
 */
- (void)autoMoveOfFinish {
    if (self.timer) {
        _isOpenAutoMove = self.isOpenAutoMoveRetain;
        [self.timer invalidate];
        self.timer = nil;
    }
}

/**
 *  是否要暂停定时器，此方法综合了- (void)autoMoveOfStart;- (void)autoMoveOfFinish;这两个方法的功能，如果在需要的时候调用autoMoveOfFinish，想要开启的时候，调用autoMoveOfStart进行开启，而本方法，如果传YES的时候，移除定时器，关闭自动轮播，YES的时候开启自动轮播
 *
 *  @param isPause 是否暂停
 */
- (void)autoMoveOfPause:(BOOL)isPause {
    if (isPause) {
        [self autoMoveOfFinish];
    } else {
        [self autoMoveOfStart];
    }
}

/**
 *  定时器的方法
 */
- (void)move {
    
    __block NSInteger pageNum = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width + 1;
    if (self.style == JGUnlimitedScrollViewStyleVertical) {
        pageNum = self.collectionView.contentOffset.y / self.collectionView.bounds.size.height + 1;
    }
    
    self.pageControl.currentPage = pageNum % self.bannerImages.count;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:pageNum inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(unlimitedScrollView:didMoveWithIndex:)]) {
            [self.delegate unlimitedScrollView:self didMoveWithIndex:self.pageControl.currentPage];
        }
    });
    
    if (pageNum >= self.bannerImages.count) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.pageControl.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        });
        return;
    }
}

#pragma - mark      ---------- UICollectionView DataSourse ----------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bannerImages.count > 1 ? self.bannerImages.count * 2 : self.bannerImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JGUnlimtedScrollViewItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"BANNER_CELL" forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    NSString *content = @"";
    if (self.contentArray != nil && self.contentArray.count == self.bannerImages.count) {
        content = self.contentArray[indexPath.row % self.contentArray.count];
    }
    
    [item setItemWithBannerImage:self.bannerImages[indexPath.row % self.bannerImages.count] content:content placeholder:self.placeHolderImgView.image];
    return item;
}

#pragma - mark      ---------- UICollectionView Delegate ----------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(unlimitedScrollView:didClickItemWithIndex:)]) {
        [self.delegate unlimitedScrollView:self didClickItemWithIndex:indexPath.row % self.bannerImages.count];
    }
}

#pragma - mark      ---------- UIScrollView Delegate ----------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger pageNum = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (self.style == JGUnlimitedScrollViewStyleVertical) {
        pageNum = scrollView.contentOffset.y / scrollView.frame.size.height;
    }
    
    if (pageNum == 0 || pageNum == self.bannerImages.count * 2 - 1) {
        if (pageNum == 0) {
            pageNum = self.bannerImages.count;
        } else {
            pageNum = self.bannerImages.count - 1;
        }
        
        scrollView.contentOffset = self.style == JGUnlimitedScrollViewStyleHorizontal ? CGPointMake(pageNum * scrollView.frame.size.width, 0) : CGPointMake(0, pageNum * scrollView.frame.size.height);
    }
    
    self.pageControl.currentPage = pageNum % self.bannerImages.count;
    
    [self moveHandle];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(unlimitedScrollView:didMoveWithIndex:)]) {
        [self.delegate unlimitedScrollView:self didMoveWithIndex:self.pageControl.currentPage];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.collectionView == scrollView) {
        [self autoMoveOfFinish];
    }
}

#pragma - mark      ---------- 控制是否自动轮播 ----------
/**
 *  控制是否自动轮播
 */
- (void)moveHandle {
    
    if (self.isOpenAutoMove && self.bannerImages.count > 1) {
        [self autoMoveOfFinish];
        [self moveToStart];
    } else {
        [self autoMoveOfFinish];
    }
}

#pragma - mark      ---------- 控件排列 ----------
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    
    CGFloat pageControlW = (self.bannerImages.count + 1) * 15;
    CGFloat pageControlX = self.frame.size.width / 2 - pageControlW / 2;
    if (self.pageControlStyle == JGUnlimitedPageControlStyleOfLeft) {
        pageControlX = 0;
    } else if (self.pageControlStyle == JGUnlimitedPageControlStyleOfRight) {
        pageControlX = self.frame.size.width - pageControlW;
    }
    self.pageControl.frame = CGRectMake(pageControlX, self.frame.size.height - 30, pageControlW, 30);
    
    self.placeHolderImgView.frame = self.bounds;
    self.placeHolderLabel.frame = CGRectMake(0, self.placeHolderImgView.frame.size.height - 30, self.placeHolderImgView.frame.size.width, 30);
}

- (void)clickPageControlWithIndex:(NSInteger)index {
    
    [self autoMoveOfFinish];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self moveHandle];
    });
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(unlimitedScrollView:didMoveWithIndex:)]) {
        [self.delegate unlimitedScrollView:self didMoveWithIndex:index];
    }
}

/**
 *  此方法，提供外部自定义PageControl的点击，来控制轮播器的切换的功能，
 注意：如果想要用pageController来切换轮播器，就必须要通过这个方法，将对应的currentPage的索引传过来
 *
 *  @param index               要切换到哪个banner
 */
- (void)didClickCustomPageControlWithIndex:(NSInteger)index {
    [self.pageControl setHidden:YES];
    
    [self clickPageControlWithIndex:index];
}

#pragma - mark      ---------- 监听本类点击事件 ----------
- (void)pageControlClick:(UIPageControl *)page {
    [self clickPageControlWithIndex:page.currentPage];
}

@end
