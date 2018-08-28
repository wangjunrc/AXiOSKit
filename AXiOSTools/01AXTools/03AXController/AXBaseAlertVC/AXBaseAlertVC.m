//
//  AXBaseAlertVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/10/12.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXBaseAlertVC.h"
#import "AXAlertAlertTransitioning.h"
#import "AXAlertSheetTransitioning.h"

@interface AXBaseAlertVC ()<UIViewControllerTransitioningDelegate>

@end

@implementation AXBaseAlertVC


- (instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        self.axTouchesBeganDismiss = YES;
    }
    return self;
}


- (AXAlertControllerStyle )axAlertControllerStyle{
    
    return AXAlertControllerStyleActionSheet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (self.axTouchesBeganDismiss && touch.view == self.view) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 专场动画 UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    switch (self.axAlertControllerStyle) {
        case AXAlertControllerStyleAlert:
            return [[AXAlertAlertTransitioning alloc] init];
            break;
            
        case AXAlertControllerStyleActionSheet:
            return [[AXAlertSheetTransitioning alloc] init];
            break;
            
        default:
            break;
    }
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    switch (self.axAlertControllerStyle) {
        case AXAlertControllerStyleAlert:
            return [[AXAlertAlertTransitioning alloc] init];
            break;
            
        case AXAlertControllerStyleActionSheet:
            return [[AXAlertSheetTransitioning alloc] init];
            break;
            
        default:
            break;
    }
}

@end
