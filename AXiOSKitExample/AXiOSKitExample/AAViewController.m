//
//  AAViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AAViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import "FBKVOController.h"

@interface AAViewController ()

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;

    __weak typeof(self) weakSelf = self;
    [self ax_addFBKVOKeyPath:FBKVOKeyPath(weakSelf.view.backgroundColor) block:^(NSString * _Nullable keyPath, id  _Nullable oldValue, id  _Nullable newValue) {
        NSLog(@"newValue>> %@",newValue);
        
    }];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     self.view.backgroundColor = [UIColor ax_randomColor];
}

- (void)dealloc
{
    axLong_dealloc;
}
@end
