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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    NSURL *path =  [NSBundle.mainBundle URLForResource:@"H5.bundle/index" withExtension:@"html"];
    AXWKWebVC *web = [[AXWKWebVC alloc]init];
    web.loadURL =path;
  WebJSHandler *obj =  WebJSHandler.alloc.init;
    NSLog(@"obj  %p",obj);
    [web addScriptDelegate:obj forKey:@"JSUseOCFunctionName_test1"];
//    [web addScriptMessageWithName:@"JSUseOCFunctionName_test1" handler:^(NSString * _Nonnull name, id  _Nonnull body) {
//        AXLog(@"%@",body);
//    }];
    [self.navigationController pushViewController:web animated:YES];
}


@end
