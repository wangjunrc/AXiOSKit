//
//  UIViewController+AXMedia.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/9/23.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXMediaConfig.h"
#import "AXMediaResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AXMedia)


/// 选择照片(相册或者拍照)
/// @param config 配置
/// @param block 回调
- (void)ax_showCameraWithConfig:(AXMediaConfig *)config
                           block:(void(^)(AXMediaResult *result))block;

@end

NS_ASSUME_NONNULL_END
