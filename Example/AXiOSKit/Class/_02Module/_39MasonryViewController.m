//
//  _39MasonryViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/10.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_39MasonryViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
@interface _39MasonryViewController ()

@end

@implementation _39MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"Masonry 布局";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *bgView = UIView.alloc.init;
    bgView.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:bgView];
    
    NSArray *dataArray = @[@"0",@"1"];
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_equalTo(0);
        } else {
            make.top.mas_equalTo(0);
        }
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    NSMutableArray<UIView *> *temp = [NSMutableArray arrayWithCapacity:dataArray.count];

    
    @weakify(temp);
    [dataArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIView *view = UIView.alloc.init;
        view.backgroundColor = UIColor.ax_randomColor;
        
        view.tag = idx;
        @strongify(temp);
        [temp addObject:view];
        view.backgroundColor = [UIColor ax_randomColor];
        [bgView addSubview:view];
    }];
    
    [temp  mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:0 tailSpacing:0];

//    [temp mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:0 leadSpacing:0 tailSpacing:0];

    [temp mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
//        make.width.mas_equalTo(100);
    }];
    
    
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
