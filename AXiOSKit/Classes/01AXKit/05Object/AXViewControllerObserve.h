//
//  AXViewControllerObserve.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/3.
//

#import <UIKit/UIKit.h>
#import "AXMediaConfig.h"
#import "AXMediaResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXViewControllerObserve : NSObject


@property(nonatomic, weak,readonly) UIViewController *viewController;

- (instancetype)initWithObserve:(UIViewController *)viewController;

/// 直接被push,有导航
@property(nonatomic, copy, readonly) AXViewControllerObserve *(^isPushed)(void(^)(void));

/// 直接被Present,没有导航 除非是Presented 导航的
@property(nonatomic, copy, readonly) AXViewControllerObserve *(^isPresented)(void(^)(void));

/// 是否隐藏导航栏。默认NO。需要放在push代码后
/**
 配合 KMNavigationBarTransition 使用
 /// 假如内容为 scrollView ,在viewController中需要偏移一下
 - (void)viewDidAppear:(BOOL)animated {
     [super viewDidAppear:animated];
     if (@available(iOS 11.0, *)){
         if (self.navigationController.isNavigationBarHidden) {
             self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
         }
     }
 }
 */
@property (nonatomic, assign,getter=isHiddenNavigationBar) BOOL hiddenNavigationBar;



/// 选择照片(相册或者拍照)
/// @param config 配置
/// @param block 回调
- (void)showCameraWithConfig:(AXMediaConfig *)config
                       block:(void(^)(AXMediaResult *result))block;


@end

NS_ASSUME_NONNULL_END
