//
//  JGUnlimtedScrollViewItem.h
//  无限轮播器
//
//  Created by FCG on 2017/5/27.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import <UIKit/UIKit.h>

// label最大可以换多少行
#define kLabelMaxLine   2

@interface JGUnlimtedScrollViewItem : UICollectionViewCell

/**  内容背景  */
@property (nonatomic, strong) UIView *contentBgView;

/**  显示的内容标签 如果没有内容就隐藏  */
@property (nonatomic, strong) UILabel *contentLabel;

- (void)setItemWithBannerImage:(id)image content:(NSString *)content placeholder:(UIImage *)placeholder;

@end
