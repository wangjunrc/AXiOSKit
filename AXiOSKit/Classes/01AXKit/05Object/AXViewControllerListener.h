//
//  AXViewControllerListener.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/30.
//

#import <UIKit/UIKit.h>
#import "AXMediaConfig.h"
#import "AXMediaResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXViewControllerListener : NSObject

@property(nonatomic, weak,readonly) UIViewController *viewController;

- (instancetype)initWithObserve:(UIViewController *)viewController;

/// 直接被push,有导航 
@property(nonatomic, copy, readonly) AXViewControllerListener *(^isPushed)(void(^)(void));

/// 直接被Present,没有导航 除非是Presented 导航的
@property(nonatomic, copy, readonly) AXViewControllerListener *(^isPresented)(void(^)(void));

/// 是否隐藏导航栏。默认NO。
@property (nonatomic, assign,getter=isHiddenNavigationBar) BOOL hiddenNavigationBar;



/// 选择照片(相册或者拍照)
/// @param config 配置
/// @param block 回调
- (void)showCameraWithConfig:(AXMediaConfig *)config
                       block:(void(^)(AXMediaResult *result))block;

@end

NS_ASSUME_NONNULL_END
