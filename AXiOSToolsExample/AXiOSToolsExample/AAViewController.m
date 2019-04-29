//
//  AAViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AAViewController.h"
#import "AXiOSTools.h"
#import "UITextField+AXTool.h"

#import "UITextField+AXAction.h"


@interface AAViewController ()

@property(nonatomic, strong) UIView *leftView;

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
  
    
  
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.didNameBlock()) {
        NSString *name = self.didNameBlock();
        NSLog(@"name >> %@",name);
    }
    
}


- (void)dealloc{
    axLong_dealloc;
}
@end
