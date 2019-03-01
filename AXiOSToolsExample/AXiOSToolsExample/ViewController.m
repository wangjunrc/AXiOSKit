//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//




#import "ViewController.h"
#import "AAViewController.h"
#import "Person.h"

@interface ViewController ()

@property(nonatomic,strong)AAViewController *avc;

/**<#description#>*/
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
//    AXQRCodeVC *vc = [[AXQRCodeVC alloc]init];
//    vc.qrCodeBlock = ^(NSError *error, NSString *code) {
//        NSLog(@"%@  %@",error,code);
//        self.label.text = code;
////        [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    AAViewController *vc = [[AAViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)btnAction:(id)sender {
    
    NSLog(@"%@",[Person sharedInstance].student);
    NSLog(@"age> %@",[Person sharedInstance].student.age);
}

- (IBAction)btnAc2:(id)sender {
    
}


@end
