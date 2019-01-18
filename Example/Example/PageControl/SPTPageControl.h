//
//  SPTPageControl.h
//  SportsKit
//
//  Created by JD on 2018/4/27.
//  Copyright © 2018年 Suning Sports. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SPTPageControl : UIView

/*
 * 正常颜色
 */
@property (nonatomic, strong) UIColor *normalColor;

/*
 * 选中颜色
 */
@property (nonatomic, strong) UIColor *selectedColor;

/*
 * 页数
 */
@property (nonatomic, assign) NSUInteger numberOfPages;

/*
 * 当前页
 */
@property (nonatomic, assign) NSUInteger currentPage;

/*
 * 只有一页是否隐藏
 */
@property (nonatomic, assign) BOOL hidesForSinglePage;

@end
