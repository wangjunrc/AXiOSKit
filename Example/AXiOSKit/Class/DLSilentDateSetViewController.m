//
//  DLSilentDateSetViewController.m
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/11/5.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import "DLSilentDateSetViewController.h"
#import "DLSilentDateSetView.h"
#import <Masonry/Masonry.h>
@interface DLSilentDateSetViewController ()
@property(nonatomic,strong)DLSilentDateSetView *setView;

@end

@implementation DLSilentDateSetViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.setView];
    [self.setView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        
    }];
    
//    UIView *view =[UIView.alloc init];
//    view.backgroundColor = UIColor.orangeColor;
//    [self.view addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.height.equalTo(self.view).multipliedBy(0.7);
//    }];
    
}

- (DLSilentDateSetView *)setView {
    if (!_setView) {
        _setView = [DLSilentDateSetView.alloc init];
    }
    return _setView;
}


@end
