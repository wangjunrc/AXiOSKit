//
//  ABViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ABViewController.h"

@interface ABViewController ()

@end

@implementation ABViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addScriptMessageHandlerName:@"JSUseOCFunctionName_test1"];
//    self.didReceiveScriptMessage = ^(NSString *name, NSString *body) {
//        NSLog(@"name>> %@ %@",name,body);
//    };
    
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

- (void)btnAction {
    
    NSString *jsStr = [NSString stringWithFormat:@"showAler('%@')",@"AB"];
    [self evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"evaluateJavaScript>> %@  %@",data,error.localizedDescription);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
