//
//  UIScrollView+AXRefresh.m
//  Xile
//
//  Created by liuweixing on 2017/3/22.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "UIScrollView+AXRefresh.h"

@implementation UIScrollView (AXRefresh)
/**
 * 初始化刷新
 */
-(void)ax_setupRefreshHeader:(void(^)(void))header foot:(void(^)(void))foot{
    if (header) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            header();
        }];
        [self.mj_header beginRefreshing];
    }
    
    if (foot) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            foot();
        }];
//        self.mj_footer.automaticallyHidden = YES;
    }
}

/**
 * 头开始刷新
 */
-(void)ax_setupHeaderBeginRefreshing{
    [self.mj_header beginRefreshing];
}

/**
 * 尾始刷新
 */
-(void)ax_setupFootBeginRefreshing{
    [self.mj_footer beginRefreshing];
}

/**
 * 结束刷新
 */
-(void)ax_setupEndRefresh{
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer) {
        [self.mj_footer endRefreshing];
    }
}

/**
 * 取消头
 */
-(void)ax_setupHeaderNULL{
    if (self.mj_header) {
        self.mj_header = nil;
    }
}

/**
 * 取消尾
 */
-(void)ax_setupFootNULL{
    if (self.mj_footer) {
        self.mj_footer = nil;
    }
}

@end
