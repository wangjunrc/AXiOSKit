//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//
#import "ViewController.h"
#import "AAViewController.h"
#import "AXiOSTools.h"
#import "WebSocketManager.h"

@interface ViewController ()

@property(nonatomic, strong) AAViewController *avc;

/**<#description#>*/
@property(nonatomic, strong) UIView *leftView;
@property(nonatomic, strong) UIView *rightView;
@property(nonatomic, strong) UILabel *leftLabel;
@property(nonatomic, strong) UILabel *rightLabel;
@property(weak, nonatomic) IBOutlet UILabel *label;
@property(weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController




- (void)viewDidLoad {
  [super viewDidLoad];
    
    
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    
//  AAViewController *vc = [[AAViewController alloc] init];
//  [self.navigationController pushViewController:vc animated:YES];
  
   
    AXWKWebVC *vc = [[AXWKWebVC alloc]init];
    vc.loadHTMLFilePath = [NSBundle.mainBundle pathForResource:@"HTML/home.html" ofType:nil];

     NSLog(@"%@",vc.loadHTMLFilePath);
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnAction:(id)sender {
  NSDictionary *dcit = @{
    @"msg" : self.tf.text,
    @"onlineCount" : @2,
    @"type" : @"SPEAK",
    @"username" : @"tom"
  };

  [WebSocketManager.shared sendDataToServer:[dcit ax_toJSONString]];
}

- (IBAction)btnAc2:(id)sender {
    
    
    
    //创建一个队列，串行并行都可以，主要为了操作信号量
    dispatch_queue_t queue = dispatch_queue_create("com.ax.queue.alert", DISPATCH_QUEUE_SERIAL);
    //创建一个初始为0的信号量
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    // 异步,防止卡死,因为  dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    dispatch_async(queue, ^{
        //等待信号触发，注意，这里是在我们创建的队列中等待
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        //上面的等待到信号触发之后，再创建第二个Alert
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框2" message:@"第二个弹框" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                dispatch_semaphore_signal(sema);
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        });
    });
    
    //同理，创建第三个Alert
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框3" message:@"第三个弹框" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                dispatch_semaphore_signal(sema);
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
        });
    });
    
    // 第一个不用异步,优先执行,不管放在哪里
    //第一个弹框，UI的创建和显示，要在主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框1" message:@"第一个弹框" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            //点击Alert上的按钮，我们发送一次信号。
            dispatch_semaphore_signal(sema);
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //点击Alert上的按钮，我们发送一次信号。
            dispatch_semaphore_signal(sema);
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    });
}

@end
