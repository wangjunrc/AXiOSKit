//
//  AXBaseAlertVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/10/12.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXBaseAlertVC.h"
#import "UIView+AXFrame.h"

@interface AXBaseAlertVC ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

//@property (strong, nonatomic) UIView *bgView;

@end

@implementation AXBaseAlertVC

- (instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.axTouchesBeganDismiss = YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.axTouchesBeganDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - 专场动画 UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}


#pragma mark - 专场动画 UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    AXBaseAlertVC *toVC = (AXBaseAlertVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (!toVC || !fromVC) {
        return;
    }
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (toVC.isBeingPresented) {
        
        [containerView addSubview:toVC.view];
        
        toVC.view.frame = containerView.bounds;
        
        toVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
        if (self.alertControllerStyle==UIAlertControllerStyleActionSheet) {
            
            CGAffineTransform oldTransform = toVC.axContentView.transform;
            toVC.axContentView.transform = CGAffineTransformScale(oldTransform, 0.3, 0.3);
            toVC.axContentView.center = containerView.center;
            
            [UIView animateWithDuration:duration animations:^{
                
                toVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
                toVC.axContentView.transform = oldTransform;
                
            } completion:^(BOOL finished) {
                
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
            
        }else{
            
            toVC.axContentView.y = toVC.view.height;
            
            [UIView animateWithDuration:duration animations:^{
                
                toVC.axContentView.y = 10;
                
            } completion:^(BOOL finished) {
                
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
        
        
    }
    else if (fromVC.isBeingDismissed) {
        
        [UIView animateWithDuration:duration animations:^{
            fromVC.view.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end
