//
//  AAViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AAViewController.h"
#import "AXiOSTools.h"
#import "ACViewController.h"
#import "Student.h"
#import "UITextField+AXTool.h"

#import "UITextField+AXAction.h"

@interface AAViewController ()
@property(nonatomic,strong)Student *sutdent;
@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    [self.view addSubview:tf];
    tf.backgroundColor = [UIColor redColor];
    
     tf.axDelegateHandler.didBeginBlock = ^(UITextField *textField) {
       
    };
    
    tf.axDelegateHandler.didEndBlock = ^(UITextField *textField) {
        NSLog(@">>> %@",textField.text);
    };
    
    MBProgressHUD * hud  = [MBProgressHUD ax_showProgressMessage:@"AAA"];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ACViewController *vc =[ACViewController ax_init];
//    vc.vc = self;
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)dealloc{
    axLong_dealloc;
}
@end
