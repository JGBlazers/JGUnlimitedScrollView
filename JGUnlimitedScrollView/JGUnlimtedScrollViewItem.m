//
//  JGUnlimtedScrollViewItem.m
//  无限轮播器
//
//  Created by FCG on 2017/5/27.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import "JGUnlimtedScrollViewItem.h"
#import "JGImageView.h"

@interface JGUnlimtedScrollViewItem ()

/**  图片  */
@property (nonatomic, strong) JGImageView *jg_imgView;

@end

@implementation JGUnlimtedScrollViewItem

/**
 *  初始化方法
 *
 *  @return 本类实例后的对象
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        /**  图片  */
        JGImageView *jg_imgView = [[JGImageView alloc] init];
        [self addSubview:jg_imgView];
        self.jg_imgView = jg_imgView;
        
        /**  内容背景  */
        UIView *contentBgView = [UIView new];
        contentBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [self addSubview:contentBgView];
        self.contentBgView = contentBgView;
        
        /**  显示的内容标签 如果没有内容就隐藏  */
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.textColor = [UIColor whiteColor];
        contentLabel.font = [UIFont systemFontOfSize:14.0];
        contentLabel.numberOfLines = kLabelMaxLine;
        [contentBgView addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
}

- (void)setItemWithBannerImage:(id)image content:(NSString *)content placeholder:(UIImage *)placeholder {
    [self.jg_imgView jg_image:image placeholder:placeholder];
    
    if (content.length == 0 || content == nil) {
        self.contentBgView.hidden = YES;
        self.contentLabel.hidden = YES;
        self.contentLabel.text = @"";
    } else {
        self.contentBgView.hidden = NO;
        self.contentLabel.hidden = NO;
        self.contentLabel.text = content;
        [self layoutSubviews];
    }
}

#pragma - mark      ---------- 控件排列 ----------
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.jg_imgView.frame = self.bounds;
    
    CGFloat labelX = 16;
    CGFloat labelY = 10;
    CGFloat labelMaxW = self.frame.size.width - 2 * labelX;
    
    if (self.contentBgView.hidden == NO) {
        CGSize labelSize = [self.contentLabel.text boundingRectWithSize:CGSizeMake(labelMaxW, self.contentLabel.font.lineHeight * kLabelMaxLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.contentLabel.font} context:nil].size;
        
        self.contentBgView.frame = CGRectMake(0, self.frame.size.height - labelSize.height - labelY, self.frame.size.width, labelSize.height + labelY);
        
        self.contentLabel.frame = CGRectMake(labelX, labelY / 2, self.contentBgView.frame.size.width - 2 * labelX, labelSize.height);
    }
}


@end
