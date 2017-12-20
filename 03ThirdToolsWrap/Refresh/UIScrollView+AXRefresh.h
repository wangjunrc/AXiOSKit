//
//  UIScrollView+AXRefresh.h
//  Xile
//
//  Created by Mole Developer on 2017/3/22.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface UIScrollView (AXRefresh)
/**
 * 初始化刷新
 */
-(void)ax_setupRefreshHeader:(void(^)(void))header foot:(void(^)(void))foot;
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
