//
//  SPTStyledPageControl.h
//  News
//
//  Created by zhangwei on 2018/4/28.
//  Copyright © 2018年 Suning Sports. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SPTStyledPageControl : UIView

@property (nonatomic) NSUInteger numberOfPages;      //总页数
@property (nonatomic, strong) UIColor *pageIndicatorColor;  // 普通状态下Indicator颜色
@property (nonatomic, strong) UIColor *currentPageIndicatorColor;    //选中状态下Indicator颜色
@property (nonatomic) NSUInteger currentPage;        //当前页
@property (nonatomic) CGFloat indicatorMargin;      //间距
@property (nonatomic) CGFloat indicatorWidth;       //普通宽度
@property (nonatomic) CGFloat currentIndicatorWidth; //当前宽度
@property (nonatomic) CGFloat indicatorHeight;

- (instancetype)initWithFrame:(CGRect)frame indicatorMargin:(CGFloat)margin indicatorWidth:(CGFloat)indicatorWidth currentIndicatorWidth:(CGFloat)currentIndicatorWidth indicatorHeight:(CGFloat)indicatorHeight;

@end
