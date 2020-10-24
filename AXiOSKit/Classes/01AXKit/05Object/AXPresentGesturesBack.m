//
//  AXPresentGesturesBack.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/24.
//

#import "AXPresentGesturesBack.h"
#import <objc/runtime.h>

@interface MADismissAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@end
@interface MADismissInteractor : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, readonly) BOOL interactive;

- (instancetype)initWithViewController:(UIViewController *)viewController;

@end

@interface UIViewController (Transition)

@property (nonatomic, strong) AXPresentGesturesBack *transition;

@end

#pragma mark -
#pragma mark - implementation
@implementation MADismissAnimator

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    ///获取转场动画进行的视图
    UIView *containerView = transitionContext.containerView;
    ///获取控制器
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ///获取视图
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    ///获取frame
    CGRect fromControllerFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toControllerFrame = [transitionContext finalFrameForViewController:toViewController];
    ///判断转场情况 toViewController.presentingViewController == fromViewController;
    ///只考虑dismiss
    ///dismiss时，toView.superview == nil
    ///fromView.superview == containerView
    toView.frame = toControllerFrame;
    [containerView insertSubview:toView belowSubview:fromView];
    ///添加遮罩
    UIView *maskView = [[UIView alloc]initWithFrame:containerView.bounds];
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [containerView insertSubview:maskView aboveSubview:toView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectOffset(fromControllerFrame, 0, fromControllerFrame.size.height);
        maskView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [maskView removeFromSuperview];
        BOOL cancelled = [transitionContext transitionWasCancelled];
        if (cancelled) {
            [toView removeFromSuperview];
        }
        [transitionContext completeTransition:!cancelled];
    }];

}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

@end



@interface MADismissInteractor ()

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, assign, readwrite) BOOL interactive;

@end

@implementation MADismissInteractor

- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (self = [super init]) {
        ///flag
        _interactive = NO;
        ///触发器，
        _viewController = viewController;
        ///手势
        UIScreenEdgePanGestureRecognizer *transitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureDrivenInteractiveTransition:)];
        transitionRecognizer.edges = UIRectEdgeLeft;
        [_viewController.view addGestureRecognizer:transitionRecognizer];
    }
    return self;
}

- (void)gestureDrivenInteractiveTransition:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.viewController.view].x / (self.viewController.view.bounds.size.width * 1.0);
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            _interactive = YES;
            [_viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
            _interactive = NO;
            CGPoint velocity = [recognizer velocityInView:self.viewController.view];
            if (velocity.x > 600.0) {
                self.completionSpeed = 0.35;
                [self finishInteractiveTransition];
            } else {
                if (progress > 0.5) {
                    self.completionSpeed = 0.35;
                    [self finishInteractiveTransition];
                } else {
                    [self cancelInteractiveTransition];
                }
            }
            break;
        case UIGestureRecognizerStateCancelled:
            _interactive = NO;
            [self cancelInteractiveTransition];
            break;
        default:
            break;
    }
    
}

@end



@interface AXPresentGesturesBack ()

@property (nonatomic, strong) MADismissInteractor *dismissInteractor;

@end

@implementation AXPresentGesturesBack

///MARK:为控制器注入一个dismiss的转场动画

+ (void)injectDismissTransitionForViewController:(UIViewController*)controller; {
    
    AXPresentGesturesBack *dismissTransition = [[AXPresentGesturesBack alloc]init];
    dismissTransition.dismissInteractor = [[MADismissInteractor alloc] initWithViewController:controller];
    controller.transitioningDelegate = dismissTransition;
    controller.transition = dismissTransition;
}

////MARK:UIViewControllerTransitioningDelegate
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source; {
//    return nil;
//}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed; {
    return [[MADismissAnimator alloc]init];
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator; {
//    return nil;
//}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator; {
    if (self.dismissInteractor.interactive) {
        return self.dismissInteractor;
    } else {
        return nil;
    }

}

@end

@implementation UIViewController (Transition)

- (AXPresentGesturesBack *)transition {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTransition:(AXPresentGesturesBack *)transition {
    objc_setAssociatedObject(self, @selector(transition), transition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
