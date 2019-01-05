//
//  ViewController.m
//  Example
//
//  Created by AXing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "NSBundle+AXLocal.h"
#import "AXiOSTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:iv];
    iv.backgroundColor = [UIColor redColor];
    iv.image = [UIImage axLocale_imageNamed:@"ax_emptyData"];
 
    
//     [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:(tbl)]
    
//    NSBundle *imageBundle = [NSBundle axLocale_bundle];
//    NSLog(@"NSBundle.axLocale_bundle>> %@",NSBundle.axLocale_bundle);
//    NSLog(@"STRING>> %@",[NSBundle.axLocale_bundle localizedStringForKey:@"ax.cancel" value:@"" table:@"AXToolsLocalizedString"]);
    NSLog(@"imageBundle>> %@",AXToolsLocalizedString(@"ax.cancel"));
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    AXDateVC *vc = [[AXDateVC alloc]init];
//     AXWKWebVC *vc = [[AXWKWebVC alloc]init];
//    vc.loadURLString = @"https://www.baidu.com/";
//    [self.navigationController pushViewController:vc animated:YES];
//    vc.loadHTMLString = @"axwkWebView.html";
//    [self ax_showVC:vc];
    
//    [MBProgressHUD ax_showSuccess:@"A"];
}
@end
