//
//  AXDeviceFunctionDisableViewController.m
//  AXiOSKit
//
//  Created by AXing on 2019/7/13.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXDeviceFunctionDisableViewController.h"
#import "AXDeviceAuthorizationViewController.h"

@interface AXDeviceFunctionDisableViewController ()

@property(nonatomic,assign)AXDeviceFunctionType type;

@property(nonatomic,assign)AXDeviceFunctionDisableType disableType;

@end

@implementation AXDeviceFunctionDisableViewController


-(instancetype)initWithType:(AXDeviceFunctionType )type
                disableType:(AXDeviceFunctionDisableType )disableType {
    
    if (self = [self init]) {
        self.type = type;
        self.disableType = disableType;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    AXDeviceAuthorizationViewController *vc = [[AXDeviceAuthorizationViewController alloc]initWithType:self.type disableType:self.disableType];
    self.viewControllers = @[vc];
    self.topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
}

-(void)cancelAction  {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
