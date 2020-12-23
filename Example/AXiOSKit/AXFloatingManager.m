//
//  AXFloatingManager.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/12/21.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AXFloatingManager.h"
#import <AXiOSKit/AXiOSKit.h>

@interface AXFloatingManager()

@property(strong,nonatomic)UIWindow *window;

@property(strong,nonatomic)UIButton *button;

@end


@implementation AXFloatingManager

axShared_M(Manager)

- (void)start {
    [self startInWindow:nil];
}

- (void)startInWindow:(UIWindow *_Nullable)window {
    self.window = window;
    if (!self.window) {
        self.window = [UIApplication sharedApplication].windows.firstObject;
    }
    [self initAddEventBtn];
}

- (void)resignButton{
    [ax_rootViewController() ax_pushVC:nil];
}


-(void)initAddEventBtn{
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"按钮" forState:UIControlStateNormal];
    self.button.frame = CGRectMake(0,150, 60, 60);
    self.button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.button setBackgroundColor:[UIColor orangeColor]];
    self.button.layer.cornerRadius = 30;
    self.button.layer.masksToBounds = YES;
    [self.button addTarget:self action:@selector(resignButton) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:self.button];
    //放一个拖动手势，用来改变控件的位置
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.button addGestureRecognizer:pan];
    
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
    CGFloat SCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
    CGFloat SCREEN_HEIGHT = [UIScreen mainScreen].bounds.size.height;
    
    
    //移动状态
    UIGestureRecognizerState recState =  recognizer.state;
    
    switch (recState) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.window];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint stopPoint = CGPointMake(0, SCREEN_HEIGHT / 2.0);
            
            if (recognizer.view.center.x < SCREEN_WIDTH / 2.0) {
                if (recognizer.view.center.y <= SCREEN_HEIGHT/2.0) {
                    //左上
                    if (recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, self.button.width/2.0);
                    }else{
                        stopPoint = CGPointMake(self.button.width/2.0, recognizer.view.center.y);
                    }
                }else{
                    //左下
                    if (recognizer.view.center.x  >= SCREEN_HEIGHT - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, SCREEN_HEIGHT - self.button.width/2.0);
                    }else{
                        stopPoint = CGPointMake(self.button.width/2.0, recognizer.view.center.y);
                        //                        stopPoint = CGPointMake(recognizer.view.center.x, SCREEN_HEIGHT - self.button.width/2.0);
                    }
                }
            }else{
                if (recognizer.view.center.y <= SCREEN_HEIGHT/2.0) {
                    //右上
                    if (SCREEN_WIDTH - recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, self.button.width/2.0);
                    }else{
                        stopPoint = CGPointMake(SCREEN_WIDTH - self.button.width/2.0, recognizer.view.center.y);
                    }
                }else{
                    //右下
                    if (SCREEN_WIDTH - recognizer.view.center.x  >= SCREEN_HEIGHT - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, SCREEN_HEIGHT - self.button.width/2.0);
                    }else{
                        stopPoint = CGPointMake(SCREEN_WIDTH - self.button.width/2.0,recognizer.view.center.y);
                    }
                }
            }
            
            //如果按钮超出屏幕边缘
            if (stopPoint.y + self.button.width+40>= SCREEN_HEIGHT) {
                stopPoint = CGPointMake(stopPoint.x, SCREEN_HEIGHT - self.button.width/2.0-49);
                NSLog(@"超出屏幕下方了！！"); //这里注意iphoneX的适配。。X的SCREEN高度算法有变化。
            }
            if (stopPoint.x - self.button.width/2.0 <= 0) {
                stopPoint = CGPointMake(self.button.width/2.0, stopPoint.y);
            }
            if (stopPoint.x + self.button.width/2.0 >= SCREEN_WIDTH) {
                stopPoint = CGPointMake(SCREEN_WIDTH - self.button.width/2.0, stopPoint.y);
            }
            if (stopPoint.y - self.button.width/2.0 <= 0) {
                stopPoint = CGPointMake(stopPoint.x, self.button.width/2.0);
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
            
        default:
            break;
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.window];
}

@end
