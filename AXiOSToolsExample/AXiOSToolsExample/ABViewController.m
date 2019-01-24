//
//  ABViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ABViewController.h"

@interface ABViewController ()

@property(nonatomic,copy)FlutterMethodCallHandler handler;

@end

@implementation ABViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScriptMessageWithName:@"JSUseOCFunctionName_test1" handler:^(NSString *name, id body) {
         NSLog(@"name>> %@ %@",name,body);
    }];
    
    [self addScriptMessageWithName:@"JSUseOCFunctionName_test2" handler:^(NSString *name, id body) {
        NSLog(@"name>> %@ %@",name,body);
    }];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setMethodCallHandler:(FlutterMethodCallHandler _Nullable)handler {
    self.handler = handler;
}

- (void)btnAction {
    
//    NSString *jsStr = [NSString stringWithFormat:@"showAler('%@')",@"AB1"];
//
//    [self evaluateJavaScript:jsStr handler:^(id data, NSError *error) {
//         NSLog(@"evaluateJavaScript>> %@  %@",data,error.localizedDescription);
//    }];
    
    self.handler(@"A", ^(id  _Nullable result) {
        NSLog(@"result>> %@",result);
    });
    
}



@end
