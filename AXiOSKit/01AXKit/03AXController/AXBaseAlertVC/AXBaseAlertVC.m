//
//  AXBaseAlertVC.m
//  AXiOSKit
//
//  Created by liuweixing on 16/10/12.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXBaseAlertVC.h"
#import "AXAlertCentreAnimation.h"
#import "AXAlerUpwardAnimation.h"

@interface AXBaseAlertVC () <UIViewControllerTransitioningDelegate>

@end

@implementation AXBaseAlertVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        self.axTouchesBeganDismiss = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
    UITouch* touch = [[event allTouches] anyObject];

    if (self.axTouchesBeganDismiss && touch.view == self.view) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 默认present 方式
- (AXAlertControllerStyle)axAlertControllerStyle
{
    return AXAlertControllerStyleUpward;
}

#pragma mark - 转场动画 UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForPresentedController:(UIViewController*)presented
                     presentingController:(UIViewController*)presenting
                         sourceController:(UIViewController*)source
{
    switch (self.axAlertControllerStyle) {
    case AXAlertControllerStyleCentre:
        return [[AXAlertCentreAnimation alloc] init];
        break;

    case AXAlertControllerStyleUpward:
        return [[AXAlerUpwardAnimation alloc] init];
        break;

    default:
        break;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForDismissedController:(UIViewController*)dismissed
{
    switch (self.axAlertControllerStyle) {
    case AXAlertControllerStyleCentre:
        return [[AXAlertCentreAnimation alloc] init];
        break;

    case AXAlertControllerStyleUpward:
        return [[AXAlerUpwardAnimation alloc] init];
        break;

    default:
        break;
    }
}

@end
