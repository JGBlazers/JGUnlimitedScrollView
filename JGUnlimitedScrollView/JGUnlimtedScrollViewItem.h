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

- (void)setItemWithBannerImage:(id)image content:(NSString *)content placeholder:(UIImage *)placeholder;

@end
