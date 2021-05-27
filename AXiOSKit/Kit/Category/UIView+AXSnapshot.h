//
//  UIView+AXSnapshot.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/6/26.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AXSnapshot)

/// 截屏 返回image
/// UIView *view = [self.view snapshotViewAfterScreenUpdates:YES]; 返回 view

- (void)ax_snapshot:(void(^)(UIImage *image))block;

@end
