//
//  DemoBaseViewController.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/8.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "DemoBaseViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoContainerViewController : DemoBaseViewController


/// demo 内容视图
@property(nonatomic, strong) UIView *containerView;


/// demo 底部约束
@property (nonatomic, strong) MASViewAttribute *bottomAttribute;

-(void)_loadConstraintsWithView:(UIView *)aView;

-(void)_addCenterView:(UIView *)aView
                 size:(CGSize )size;

-(void)_addCenterView:(UIView *)aView
                width:(CGFloat )width;


-(UIButton *)_buttonTitle:(NSString *)title
                  handler:(void(^)(UIButton *btn))handler;

/// demo label
/// @param title 内容
-(UILabel *)_titlelabel:(NSString *)title;


/// 分割线
/// @param title 文字
-(UILabel *)_dividerLabel:(NSString *)title;

/// 子约束最后调用一下
-(void)_lastLoadBottomAttribute;

@end

NS_ASSUME_NONNULL_END
