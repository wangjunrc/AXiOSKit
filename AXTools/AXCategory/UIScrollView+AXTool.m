//
//  UIScrollView+AXTool.m
//  ZBP2P
//
//  Created by Mole Developer on 2016/12/2.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "UIScrollView+AXTool.h"

@implementation UIScrollView (AXTool)

/**
 * 没有内容背景文字
 */
-(AXNoMessageView *)noMessageWithTitle:(NSString *)title{
    AXNoMessageView *bg = [[AXNoMessageView alloc]initWithFrame:self.bounds];
    if (title) {
        bg.titleLabel.text = title;
    }
    return bg;
}

/**
 * 没有内容背景文字(含有一个消息的图片)
 */
-(AXNoContentView *)noContentWithTitle:(NSString *)title{
    
    AXNoContentView *bg = [[AXNoContentView alloc]initWithFrame:self.bounds];
    if (title) {
        bg.titleLabel.text = title;
    }
    return bg;
}


/**
 * 初始化刷新
 */
-(void)ax_setupRefreshHeader:(void(^)())header foot:(void(^)())foot{
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
        self.mj_footer.automaticallyHidden = YES;
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
