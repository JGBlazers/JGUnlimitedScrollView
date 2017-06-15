//
//  JGTestCustomPageControl.m
//  JGUnlimitedScrollView
//
//  Created by FCG on 2017/6/1.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import "JGTestCustomPageControl.h"

@interface JGTestCustomPageControl ()

/**  当前页的标志  */
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation JGTestCustomPageControl

/**
 *  初始化方法
 *
 *  @return 本类实例后的对象
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.pageIndicatorTintColor = [UIColor brownColor];
        [pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setPageNum:(NSInteger)pageNum {
    _pageNum = pageNum;
    self.pageControl.numberOfPages = pageNum;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    self.pageControl.currentPage = currentPage;
}

#pragma - mark      ---------- 控件排列 ----------
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat pageControlW = (self.pageNum + 1) * 15;
    CGFloat pageControlX = self.frame.size.width / 2 - pageControlW / 2;
    self.pageControl.frame = CGRectMake(pageControlX, 0, pageControlW, self.frame.size.height);
}

#pragma - mark      ---------- 监听本类事件 ----------
- (void)pageControlClick:(UIPageControl *)page {
    if (self.clickBlock) {
        self.clickBlock(page.currentPage);
    }
}

@end
