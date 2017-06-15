//
//  JGTestCustomPageControl.h
//  JGUnlimitedScrollView
//
//  Created by FCG on 2017/6/1.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGTestCustomPageControl : UIView

/**  page的数量  */
@property (nonatomic, assign) NSInteger pageNum;

/**  page的点击  */
@property (nonatomic, strong) void(^clickBlock)(NSInteger currentPage);

/**  当前的点  */
@property (nonatomic, assign) NSInteger currentPage;

@end
