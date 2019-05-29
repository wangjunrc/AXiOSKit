//
//  AAAViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/5/6.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AAAViewController.h"
#import "BViewController.h"
#import <Masonry/Masonry.h>
@interface AAAViewController ()

@end

@implementation AAAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    BViewController *bvc = [[BViewController alloc]init];
//
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:bvc];
//
//    [self.contentView addSubview:nav.view];
//    [nav.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.contentView);
//         make.left.equalTo(self.contentView);
//         make.right.equalTo(self.contentView);
//        make.top.equalTo(self.contentView);
//
//    }];
//    [self addChildViewController:nav];
    
    
    BViewController *vc = [[BViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self.view addSubview:nav.view];
    [self addChildViewController:nav];
    
        [nav.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
             make.left.equalTo(self.view);
             make.right.equalTo(self.view);
            make.height.mas_equalTo(216);
    
        }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"AAAViewController");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (AXAlertControllerStyle)axAlertControllerStyle
{
    
    return AXAlertControllerStyleUpward;
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
