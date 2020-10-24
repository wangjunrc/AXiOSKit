//
//  UIScrollView+AXEmptyDataSet.h
//  AXiOSKit
//
//  Created by liuweixing on 2017/2/20.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>
//#if __has_include("UIScrollView+EmptyDataSet.h")
@interface UIScrollView (AXEmptyDataSet)

/**
 设置空集合view
 
 @param reloadBlock 刷新回调
 */
- (void)ax_emptyDataSetWithReloadBlock:(void(^)(void))reloadBlock;

/**
 设置空集合view
 
 @param imageName 占位图片名称
 @param title 占位文字
 @param reloadBlock 刷新回调
 */
- (void)ax_emptyDataWithImage:(UIImage *)image titlte:(NSString *)title reloadBlock:(void(^)(void))reloadBlock;

@end
//#endif