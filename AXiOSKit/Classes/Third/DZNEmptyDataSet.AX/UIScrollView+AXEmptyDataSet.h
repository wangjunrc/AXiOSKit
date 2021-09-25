//
//  UIScrollView+AXEmptyDataSet.h
//  AXiOSKit
//
//  Created by liuweixing on 2017/2/20.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>
//#if __has_include("UIScrollView+EmptyDataSet.h")

@interface AXEmptyDataSetConfig : NSObject

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSAttributedString *attributedTitle;
/// 刷新回调
@property(nonatomic, copy)  void(^reload)(void);
@end


@interface UIScrollView (AXEmptyDataSet)

/// 设置空集合view
/// @param config 配置文件
- (void)ax_setEmptyDataWithConfig:(void(^)(AXEmptyDataSetConfig *config)) config;

@end
//#endif
