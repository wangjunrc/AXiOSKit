//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/4/30.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "AXiOSKit.h"
#import "WebJSHandler.h"
#import "AXChoosePayVC.h"
#import "AXDateVC.h"
#import "AAAViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    self.btn = btn;
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPan:)];
    [btn addGestureRecognizer:leftPan];
    
}
- (void)handleLeftPan:(UIPanGestureRecognizer *)gesture {
    
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
    } else if (gesture.state == UIGestureRecognizerStateChanged ) {
        
        [self commitTranslation:[gesture translationInView:gesture.view]];
        // 这句很重要
        [gesture setTranslation:CGPointZero inView:gesture.view];
    }
}

/** 判断手势方向  */
- (void)commitTranslation:(CGPoint)translation {
    
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    // 设置滑动有效距离
    //    if (MAX(absX, absY) < 10){
    //        return;
    //}
    if (absX > absY ) {
        if (translation.x<0) {//向左滑动
            NSLog(@"向左滑动");
            
            CGPoint translatePoint = translation;
            
            self.btn.x += translatePoint.x;
            self.btn.y += translatePoint.y;
            
            
        }else{//向右滑动
            NSLog(@"向右滑动");
            
            CGPoint translatePoint = translation;
            
            self.btn.x += translatePoint.x;
            self.btn.y += translatePoint.y;
        }
    } else if (absY > absX) {
        if (translation.y<0) {//向上滑动
            NSLog(@"向上滑动");
        }else{ //向下滑动
            NSLog(@"向下滑动");
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
        NSURL *path =  [NSBundle.mainBundle URLForResource:@"H5.bundle/index" withExtension:@"html"];
        AXWKWebVC *web = [[AXWKWebVC alloc]init];
        web.loadURL =path;
    //  WebJSHandler *obj =  WebJSHandler.alloc.init;
    //    NSLog(@"obj  %p",obj);
    //    [web addScriptDelegate:obj forKey:@"JSUseOCFunctionName_test1"];
    ////    [web addScriptMessageWithName:@"JSUseOCFunctionName_test1" handler:^(NSString * _Nonnull name, id  _Nonnull body) {
    ////        AXLog(@"%@",body);
    ////    }];
        [self.navigationController pushViewController:web animated:YES];
    
    //    UISplitViewController *vc = [[UISplitViewController alloc]init];
    //    vc.maximumPrimaryColumnWidth = 30.f;
    //
    //
    //    vc.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    //
    //    UIViewController *subVC1 = [[UIViewController alloc]init];
    //    subVC1.view.backgroundColor = UIColor.orangeColor;
    //
    //    UIViewController *subVC2 = [[UIViewController alloc]init];
    //    subVC2.view.backgroundColor = UIColor.redColor;
    //
    //    vc.viewControllers = @[subVC1,subVC2];
    //
    //    [self presentViewController:vc animated:YES completion:nil];
    
    
    //    AXDateVC *vc = [[AXDateVC alloc]init];
    //    [self presentViewController:vc animated:YES completion:nil];
    
    //
    //    AXChoosePayVC *vc = [[AXChoosePayVC alloc]init];
    ////    [UIColor clearColor]
    ////    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    //    [self presentViewController:vc animated:YES completion:nil];
    
    
    //    AAAViewController *vc = [[AAAViewController alloc]init];
    //    [self presentViewController:vc animated:YES completion:nil];
    
    
}


@end
