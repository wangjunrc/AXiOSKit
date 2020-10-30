//
//  AXViewControllerListener.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXViewControllerListener : NSObject

@property(nonatomic, weak,readonly) UIViewController *viewController;

- (instancetype)initWithObserve:(UIViewController *)viewController;

/// 直接被push,有导航 
@property(nonatomic, copy, readonly) AXViewControllerListener *(^isPushed)(void(^)(void));

/// 直接被Present,没有导航
@property(nonatomic, copy, readonly) AXViewControllerListener *(^isPresented)(void(^)(void));


@end

NS_ASSUME_NONNULL_END
