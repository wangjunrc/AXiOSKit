//
//  AView.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/3/9.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "AView.h"
#import <Masonry/Masonry.h>
@implementation AView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)removeFromSuperview {
    [super removeFromSuperview];
    NSLog(@"removeFromSuperview");
}
- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    NSLog(@"didAddSubview");
}
- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    NSLog(@"addSubview");
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    NSLog(@"willMoveToSuperview %p",newSuperview);
}
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.top.equalTo(self.superview).mas_equalTo(300);
        make.left.equalTo(self.superview).mas_equalTo(300);
    }];
    
}
@end
