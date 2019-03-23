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
    
    self.leftView = [[UIView alloc]init];
    self.leftView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:self.leftView];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.view);
         make.top.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    

    
   
}



- (void)dealloc{
    axLong_dealloc;
}
@end
