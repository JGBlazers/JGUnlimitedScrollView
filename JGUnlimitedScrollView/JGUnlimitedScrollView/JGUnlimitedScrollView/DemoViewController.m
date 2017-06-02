//
//  DemoViewController.m
//  JGUnlimitedScrollView
//
//  Created by FCG on 2017/6/1.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import "DemoViewController.h"
#import "JGUnlimitedScrollView.h"

#import "JGTestCustomPageControl.h"

@interface DemoViewController ()<JGScrollViewDelegate>

/**  无限轮播器  */
@property (nonatomic, strong) JGUnlimitedScrollView *scrollView;

/**  自定义的分页表示控件  */
@property (nonatomic, strong) JGTestCustomPageControl *cPageControl;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.layer.contents = (id)[UIImage imageNamed:@"bg.jpg"].CGImage;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma - mark      ---------- 普通自动轮播和手动轮播 ----------
- (void)normalAndManualStatus {
    
    NSArray *banners = @[
                          [UIImage imageNamed:@"h1.jpg"],
                          @"h2",
                          @"h3.jpg",
                          @"h4.jpg"
                          ];
    
    /********** 华丽的分割线 *****  普通方式  ***** 华丽的分割线 **********/
    JGUnlimitedScrollView *scrollView1 = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180) bannerImages:banners];
    scrollView1.delegate = self;
    scrollView1.tag = 1;
    scrollView1.pageControlStyle = JGUnlimitedPageControlStyleOfRight;
    scrollView1.timeInteval = 1;
    scrollView1.placeholder = [UIImage imageNamed:@"jg_imageview_placeholder"];
    [self.view addSubview:scrollView1];
    
    scrollView1.contentArray = @[@"第一个版本正式提交，感谢您的支持！",
                                 @"在使用的过程中",
                                 @"如果代码在使用过程中出现问题",
                                 @"您可以将问题发送到2044471447@qq.com邮箱上，在收到的第一时间会做出处理，再次感谢"
                                 ];
    
    
    
    /********** 华丽的分割线 *****  手动轮播  ***** 华丽的分割线 **********/
    JGUnlimitedScrollView *scrollView2 = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView1.frame) + 30, self.view.frame.size.width, 180) bannerImages:banners];
    scrollView2.isOpenAutoMove = NO;
    scrollView2.delegate = self;
    scrollView2.timeInteval = 1.5;
    scrollView2.tag = 2;
    [self.view addSubview:scrollView2];
}


#pragma - mark      ---------- 加载网络图片和垂直滚动 ----------
- (void)loadImageUrlAndVerticalMove {
    NSArray *banners3 = @[
                          [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496381766424&di=1f05f78810da089a00e69bf0c4591a95&imgtype=0&src=http%3A%2F%2Fp0.qhimg.com%2Ft01560a9e1090710609.jpg"],
                          [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496382033731&di=69c4ee9618d40a1e5a1d2fec6231a134&imgtype=0&src=http%3A%2F%2Fk.zol-img.com.cn%2Fnokia%2F6005%2Fa6004695.jpg"],
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496382048864&di=208e77727c6fc7ef3a0c6aa20e920ce0&imgtype=0&src=http%3A%2F%2Fimage.vlook.cn%2Fstatic%2Fpic%2Fsnap_6%2FhE6k.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496381986380&di=99b229f3e07dd5804f3b0110368e0aab&imgtype=0&src=http%3A%2F%2F5.26923.com%2Fdownload%2Fpic%2F000%2F340%2Fd9bcb080c21e1dcdf5c3752f5910b9c2.jpg"
                          ];
    
    
    
    /********** 华丽的分割线 *****  网络图片加载  ***** 华丽的分割线 **********/
    
    JGUnlimitedScrollView *scrollView3 = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180) bannerImages:banners3];
    scrollView3.delegate = self;
    scrollView3.tag = 3;
    [self.view addSubview:scrollView3];
    
    
    
    /********** 华丽的分割线 *****  垂直滚动加载网络图片  ***** 华丽的分割线 **********/
    
    JGUnlimitedScrollView *scrollView4 = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView3.frame) + 30, self.view.frame.size.width, 180) bannerImages:banners3];
    scrollView4.delegate = self;
    scrollView4.style = JGUnlimitedScrollViewStyleVertical;
    scrollView4.tag = 4;
    [self.view addSubview:scrollView4];
}

#pragma - mark      ---------- 自定义UIPageControl ----------
- (void)customPageControl {
    
    /********** 华丽的分割线 *****  自定义UIPageControl  ***** 华丽的分割线 **********/
    
    NSArray *banners = @[
                         [UIImage imageNamed:@"h1.jpg"],
                         @"h2",
                         @"h3.jpg",
                         @"h4.jpg"
                         ];
    
    __block JGUnlimitedScrollView *scrollView5 = [[JGUnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 180) bannerImages:banners];
    scrollView5.delegate = self;
    scrollView5.tag = 5;
    // 要想自定义pageControl，避免出错，最好要设置这个属性为自定义
    scrollView5.pageControlStyle = JGUnlimitedPageControlStyleOfCustom;
    [self.view addSubview:scrollView5];
    
    JGTestCustomPageControl *cPageControl = [[JGTestCustomPageControl alloc] initWithFrame:CGRectMake(0, scrollView5.frame.size.height - 30, scrollView5.frame.size.width, 30)];
    cPageControl.pageNum = scrollView5.bannerImages.count;
    [scrollView5 addSubview:cPageControl];
    self.cPageControl = cPageControl;
    
    cPageControl.clickBlock = ^(NSInteger currentPage) {
        [scrollView5 didClickCustomPageControlWithIndex:currentPage];
    };

}

#pragma - mark      ---------- JGScrollViewDelegate ----------
/**
 *  点击图片item的时候调用
 *
 *  @param unlimitedScrollView 无限轮播器的对象
 *  @param index               当前图片的item索引
 */
- (void)unlimitedScrollView:(JGUnlimitedScrollView *)unlimitedScrollView didClickItemWithIndex:(NSInteger)index {
    NSLog(@"%zd", index);
}

/**
 *  轮播器每当切换页数的时候调用，包括点击自带的pageControl切换，拖动切换，自动轮播切换
 *  注意：此方法，可在自定义PageControl的时候，在这个方法中，切换对应的CurrentPage，和方法didClickCustomPageControlWithIndex一起使用
 *  @param unlimitedScrollView 无限轮播器的对象
 *  @param index               切换结束后，当前的banner的item的索引
 */

- (void)unlimitedScrollView:(JGUnlimitedScrollView *)unlimitedScrollView didMoveWithIndex:(NSInteger)index {
    if (unlimitedScrollView.tag == 5) {
        self.cPageControl.currentPage = index;
    }
}

- (void)dealloc {
    NSLog(@"class == %@  line == %zd  func == %s", [self class], __LINE__, __FUNCTION__);
}

@end
