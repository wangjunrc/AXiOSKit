//
//  AXViewControllerTransitioningCentre.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/5/24.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXViewControllerTransitioningCentre.h"
#import "AXAlertCentreAnimation.h"

@implementation AXViewControllerTransitioningCentre

#pragma mark - 转场动画 UIViewControllerTransitioningDelegate

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController*)presented presentingController:(UIViewController*)presenting sourceController:(UIViewController*)source
{
    
            return [[AXAlertCentreAnimation alloc] init];
    
}
- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController*)dismissed
{
    
    return [[AXAlertCentreAnimation alloc] init];
    
}


@end
