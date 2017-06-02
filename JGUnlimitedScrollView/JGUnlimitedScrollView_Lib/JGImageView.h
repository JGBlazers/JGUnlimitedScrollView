//
//  JGImageView.h
//  无限轮播器
//
//  Created by FCG on 2017/5/27.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import <UIKit/UIKit.h>

// 轮播器中的图片统一用这个相框来展示，为了方便和系统的相框做好区分
@interface JGImageView : UIImageView

/**
 *  设置图片
 *
 *  @param image       将图片传过来，任意类型，可以是图片的url，本地图片，或者是UIImage对象
 *  @param placeholder 占位图
 */
- (void)jg_image:(id)image placeholder:(UIImage *)placeholder;

@end
