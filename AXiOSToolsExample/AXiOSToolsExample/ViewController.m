//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "ABViewController.h"
#import "AXiOSTools.h"
#import <StoreKit/StoreKit.h>
#import "UITextField+AXNumberKeyboard.h"

@interface ViewController ()



@end

@implementation ViewController

#define weakify(...) \
try {} @finally {} \
metamacro_foreach_cxt(ext_weakify_,, __weak, __VA_ARGS__)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
   
    
    
    

    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    ABViewController *vc = [[ABViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.loadHTMLFilePath = [[NSBundle ax_currentBundleWithName:@"AXHTML.bundle"]pathForResource:@"index.html" ofType:nil];
    
    [vc setMethodCallHandler:^(NSString *call, void (^FlutterResult)(id  _Nullable result)) {
        FlutterResult(@"B");
    }];
    
    
    
}


@end
