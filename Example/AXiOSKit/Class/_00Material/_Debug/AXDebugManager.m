//
//  AXDebugManager.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/22.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AXDebugManager.h"
#import <AXiOSKit/AXiOSKit.h>
#import "AXDebugViewController.h"

@interface AXDebugManager()

@property(nonatomic, strong)UIWindow *window;

@property(nonatomic, strong)UIButton *button;

@property(nonatomic, strong,readwrite)id <AXDebugUIConfigProtocol> config;

@property(nonatomic, copy)id<AXDebugUIConfigProtocol>(^configBlock)(UIViewController *vc);


@end


@implementation AXDebugManager

AX_SINGLETON_IMPL(Manager)


- (AXDebugManager * _Nonnull (^)(id<AXDebugUIConfigProtocol>  _Nonnull (^ _Nonnull)(UIViewController * _Nonnull)))withConfig {
    __weak typeof(self) weakSelf = self;
    return ^AXDebugManager *(id<AXDebugUIConfigProtocol> (^configBlock)(UIViewController *vc)) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (configBlock) {
            AXDebugViewController *vc = [AXDebugViewController.alloc init];
            strongSelf.config = configBlock(vc);
        }
        strongSelf.configBlock = configBlock;
        return strongSelf;
    };
}


- (void (^)(void))start {
    __weak typeof(self) weakSelf = self;
    return ^(void) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        [strongSelf _initView];
    };
}

- (id<AXDebugUIConfigProtocol>)config {
    if (!_config) {
        _config = [AXDebugUIConfig.alloc init];
        AXDebugViewController *vc = [AXDebugViewController.alloc init];
        UINavigationController *nav = [UINavigationController.alloc initWithRootViewController:vc];
        _config.rootViewController = nav;
    }
    return _config;
}

-(void)_initView {
    if (!self.window) {
//        self.window = [UIApplication sharedApplication].windows.firstObject;
        
        /// 这个方法 <UIWindowSceneDelegate> 也能获得
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if (window.isKeyWindow) {
                self.window =  window;
                break;
            }
        }
        
        
    }
    [self initAddEventBtn];
}
- (void)resignButton{
    [ax_rootViewController() presentViewController:self.config.rootViewController animated:YES completion:nil];
}

-(void)initAddEventBtn{
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
   
    self.button.frame = CGRectMake(0,150, 60, 60);
    self.button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    ///ios Symbol Image
    if (@available(iOS 13.0, *)) {
        UIImage *image = [UIImage systemImageNamed:@"ladybug.fill"];
        [self.button setBackgroundImage:image forState:UIControlStateNormal];
        self.button.tintColor = UIColor.orangeColor;
    } else {
        [self.button setTitle:@"按钮" forState:UIControlStateNormal];
        [self.button setBackgroundColor:[UIColor orangeColor]];
        self.button.layer.cornerRadius = 30;
        self.button.layer.masksToBounds = YES;
    }
    
    
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
