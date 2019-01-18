//
//  SPTAutoScrollView.m
//  PPTVSports
//
//  Created by zhugy on 2017/10/26.
//  Copyright © 2017年 PPTV. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PSPageControlPosition) {
    PSPageControlCentet = 0,
    PSPageControlRight,
};

typedef  void(^SelectedBlock)(NSInteger currentPage);

typedef  void(^ScrollEndBlock)(NSInteger currentPage);

@interface SPTAutoScrollView : UIView

@property (nonatomic, strong) NSArray *images;

/**
 *  pageControlType 默认居中显示
 */
@property (nonatomic, assign) PSPageControlPosition pageControlType;

//当前显示视图的宽 = 图片的大小 + 2 * 图片间距1/2
@property (nonatomic, assign) CGSize currentPageSize;

@property (nonatomic, assign) NSInteger currentPageIndex;

//图片间距的1/2  默认为8
@property (nonatomic, assign) NSInteger space;
//是否开启定时循环功能 默认不开启
@property (nonatomic, assign) BOOL isTimer;
//时间间隔 默认3s
@property (nonatomic,assign) CGFloat second;

//点击回调用
@property (nonatomic, copy) SelectedBlock  selectedBlock;
//翻页后回调用
@property (nonatomic, copy) ScrollEndBlock  scrollEndBlock;

@property (nonatomic, strong) UIScrollView *scrollerView;

//要求必须调用
- (void)reloadData;
@end
