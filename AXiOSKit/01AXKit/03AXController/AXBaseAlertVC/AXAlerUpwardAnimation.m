//
//  AXAlerUpwardAnimation.m
//  AXiOSKitDemo
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 AX. All rights reserved.
//

#import "AXAlerUpwardAnimation.h"

@implementation AXAlerUpwardAnimation

- (NSTimeInterval)transitionDuration:
    (id<UIViewControllerContextTransitioning>)transitionContext
{

    UIViewController* toVC = [transitionContext
        viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromVC = [transitionContext
        viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (toVC.isBeingPresented) {
        return 0.3;
    } else if (fromVC.isBeingDismissed) {
        return 0.1;
    }else{
        return 0.3;
    }

   
}

- (void)animateTransition:
    (id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toVC = [transitionContext
        viewControllerForKey:UITransitionContextToViewControllerKey];

    UIViewController* fromVC = [transitionContext
        viewControllerForKey:UITransitionContextFromViewControllerKey];

    if (!toVC || !fromVC) {
        return;
    }
    UIView* containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (toVC.isBeingPresented) {

        // 遮罩view,显示直接有背景色的,避免动画色差
        UIView* coverView = [[UIView alloc] initWithFrame:containerView.bounds];
        coverView.backgroundColor =
            [[UIColor blackColor] colorWithAlphaComponent:0.5];

        // 控制器对应的view
        UIView* toView =
            [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.frame = containerView.bounds;
        toView.center = CGPointMake(containerView.center.x, containerView.bounds.size.height);
        toView.backgroundColor = [UIColor clearColor];

        [containerView addSubview:coverView];
        [coverView addSubview:toView];

        [UIView animateWithDuration:duration
            animations:^{
                toView.center = containerView.center;
            }
            completion:^(BOOL finished) {
                [transitionContext
                    completeTransition:![transitionContext transitionWasCancelled]];
            }];

    } else if (fromVC.isBeingDismissed) {

        [UIView animateWithDuration:duration
            animations:^{
                fromVC.view.alpha = 0.0;
            }
            completion:^(BOOL finished) {
                [transitionContext
                    completeTransition:![transitionContext transitionWasCancelled]];
            }];

    } else {
    }
}


@end
