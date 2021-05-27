//
//  AXPresentGesturesBack.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// presentViewController子页面 侧滑返回
@interface AXPresentGesturesBack : NSObject<UIViewControllerTransitioningDelegate>

+ (void)injectDismissTransitionForViewController:(UIViewController*)controller;

@end


NS_ASSUME_NONNULL_END

