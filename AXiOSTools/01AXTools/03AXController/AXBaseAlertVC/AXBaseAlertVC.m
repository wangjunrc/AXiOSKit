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
    }
    return self;
}


- (AXAlertControllerStyle )alertControllerStyle{
    
    return AXAlertControllerStyleActionSheet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.axTouchesBeganDismiss = YES;
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.axTouchesBeganDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 专场动画 UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    switch (self.alertControllerStyle) {
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
    
    switch (self.alertControllerStyle) {
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
