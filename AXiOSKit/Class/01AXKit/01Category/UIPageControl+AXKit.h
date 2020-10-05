//
//  UIPageControl+AXKit.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/5.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 分类
@interface UIPageControl (AXKit)

/// 添加图片
/// iOS14 每次 currentPage 需要再调用一次该方法
-(void)ax_setPageImage:(UIImage *)pageImage currentPageImage:(UIImage *)currentPageImage;

@end

NS_ASSUME_NONNULL_END
