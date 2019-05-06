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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
//    NSURL *path =  [NSBundle.mainBundle URLForResource:@"H5.bundle/index" withExtension:@"html"];
//    AXWKWebVC *web = [[AXWKWebVC alloc]init];
//    web.loadURL =path;
//  WebJSHandler *obj =  WebJSHandler.alloc.init;
//    NSLog(@"obj  %p",obj);
//    [web addScriptDelegate:obj forKey:@"JSUseOCFunctionName_test1"];
////    [web addScriptMessageWithName:@"JSUseOCFunctionName_test1" handler:^(NSString * _Nonnull name, id  _Nonnull body) {
////        AXLog(@"%@",body);
////    }];
//    [self.navigationController pushViewController:web animated:YES];
    
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
    
    
    AXChoosePayVC *vc = [[AXChoosePayVC alloc]init];
//    [UIColor clearColor]
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:vc animated:YES completion:nil];
    
    
//    AAAViewController *vc = [[AAAViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];
    
    
}


@end
