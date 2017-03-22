//
//  UIScrollView+AXTool.h
//  ZBP2P
//
//  Created by Mole Developer on 2016/12/2.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface UIScrollView (AXTool)

/**
 * 没有内容背景文字
 */
-(AXNoContentView *)noContentWithTitle:(NSString *)title;

/**
 * 没有内容背景文字(含有一个消息的图片)
 */
-(AXNoMessageView *)noMessageWithTitle:(NSString *)title;

/**
 * 初始化刷新
 */
-(void)ax_setupRefreshHeader:(void(^)())header foot:(void(^)())foot;
/**
 * 头开始刷新
 */
-(void)ax_setupHeaderBeginRefreshing;
/**
 * 尾始刷新
 */
-(void)ax_setupFootBeginRefreshing;
/**
 * 结束刷新
 */
-(void)ax_setupEndRefresh;

/**
 * 取消头
 */
-(void)ax_setupHeaderNULL;
/**
 * 取消尾
 */
-(void)ax_setupFootNULL;

@end
