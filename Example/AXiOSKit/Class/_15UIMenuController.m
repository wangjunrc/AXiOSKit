//
//  _15UIMenuController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/6/14.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_15UIMenuController.h"
#import <Masonry/Masonry.h>
@interface _15UIMenuController ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation _15UIMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.label = UILabel.alloc.init;
    self.label.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(100);
    }];
    self.label.text = @"我是文字";
    //首先要允许label可以跟用户交互
    self.label.userInteractionEnabled = YES;
    //给label添加一个敲击手势
    [self.label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
}

/** 点击label触发的方法 */
- (void)labelClick
{
    //控制器不需要调用这个方法, 但是其他乱七八糟的UI控件就需要调用这个方法 \
    因为控制器默认是第一响应者
    //[self becomeFirstResponder];
    
    //显示menu 从来没有让menu跟控制器有关系 , 因为是第一响应者, 所以会调用第一响应者的方法
    
    //不一定调用控制器的方法, 因为现在控制器是第一响应者
    
    
    
    // 获得菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 设置菜单内容 \
    因为menuItems是数组 官方没有给出需要传入什么对象,但是以经验可以判断出需要传入的是UIMenuItem对象 \
    而且显示是按顺序的
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)]
                       ];
    
    // 菜单最终显示的位置
//    CGRect rect = CGRectMake(0, 0, 100, 100);
    [menu setTargetRect:self.label.bounds  inView:self.label];
    //为什么要设置2个参数  为了通用 \
    一个是矩形框, 一个是在哪个View上面
    //传了矩形框, 要告诉坐标原点在哪, 坐标原点就在view上\
    以tagreView的左上角为坐标原点
    // 苹果设计2个参数 是因为矩形框一旦修改 出现的位置在哪里都是可以的
    
    /*
     targetRect：menuController指向的矩形框
     targetView：targetRect以targetView的左上角为坐标原点
     */
    
    // 显示菜单
    [menu setMenuVisible:YES animated:YES];
    
    /*
     得通过第一响应者，来告诉MenuController它内部应该显示什么内容
     */
}

#pragma mark - 第一响应者 + UIMenuController
/**
 * 说明控制器可以成为第一响应者
 * 因为控制器是因为比较特殊的对象,它找控制器的方法,不找label的方法
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

/**
 * 通过这个方法告诉UIMenuController它内部应该显示什么内容
 * 返回YES，就代表支持action这个操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    //打印, 将一个方法转换成字符串 你就会看到许多方法
//    NSLog(@"%@",NSStringFromSelector(action));
//
//       if (action == @selector(cut:)
//        || action == @selector(copy:)
//        || action == @selector(paste:)) {
//        return YES;
//    }
    
    if (
//        (action == @selector(copy:) && self.label.text) // 需要有文字才能支持复制
//        || (action == @selector(cut:) && self.label.text) // 需要有文字才能支持剪切
//        || action == @selector(paste:)
//
//        ||
        action == @selector(ding:)
        || action == @selector(reply:)
        || action == @selector(warn:)){
        
        return YES;
    }
    
    
    return NO;
}

- (void)ding:(UIMenuController *)menu
{
     NSLog(@"ding=========");
}

- (void)reply:(UIMenuController *)menu
{
    NSLog(@"reply=========");
}

- (void)warn:(UIMenuController *)menu
{
    NSLog(@"warn=========");
}

//监听事情需要对应的方法 冒号之后传入的是UIMenuController
- (void)cut:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

- (void)copy:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

- (void)paste:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

@end
