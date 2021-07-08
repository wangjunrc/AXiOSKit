//
//  RunLoopViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/3/6.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "_04RunLoopViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>

@interface _04RunLoopViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIView *containerView;

@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UILabel *textLabel2;


@property(nonatomic,strong) NSTimer *timer1;
@property(nonatomic,strong) NSTimer *timer2;

@end

@implementation _04RunLoopViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = [UIColor greenColor];
    
    
    // 1.把scrollView添加到控制器view
    [self.view addSubview:self.scrollView];
    
    [ self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    self.scrollView.contentSize = self.view.bounds.size;
    
    self.containerView = [[UIView alloc]init];
    self.containerView.backgroundColor = UIColor.orangeColor;

    // 2.给scrollView添加一个containerView
    [self.scrollView addSubview:self.containerView];
    [self.containerView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView); // 需要设置宽度和scrollview宽度一样
    }];
    
    // 3.所有的子控件都放到containerView里面, 在最后一个子控件后设置约束
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.view);
    }];

    [self addConetnt:self.scrollView];
    
}

-(void)addConetnt:(UIView *)containerView{
    
    self.textLabel = [[UILabel alloc]init];
    self.textLabel.backgroundColor = UIColor.grayColor;
    [containerView addSubview:self.textLabel];
    self.textLabel.text = @"0";
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(containerView);
        
        make.top.mas_offset(0);
    }];
    
    NSInteger __block count = 0;
    
    if (@available(iOS 10.0, *)) {
        
        //          weakify(self);
        
        
        ax_weakify(self);
        
        
        self.timer1 = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            //           strongify(self);
            ax_strongify(self);
            
            NSLog(@"NSDefaultRunLoopMode = %@",[NSThread currentThread].name);
            count++;
            self.textLabel.text = [NSString stringWithFormat:@"%ld",count];
            
        }];
        /**
         当实例化NSTimer对象的时候，通常会使用 scheduledTimerWithTimeInterval 方法。该方法会自动为我们实例化的timer添加到当前线程的RunLoop中，并且默认模式是 NSDefaultRunLoopMode。但当前线程是主线程时，某些UI事件，比如ScrollView正在拖动，将会RunLoop切换成 NSEventTrackingRunLoopMode 模式，在这个模式下，默认的 NSDefaultRunLoopMode 模式中注册的事件是不会执行的。也就是说，使用 scheduledTimerWithTimeInterval 方法添加到RunLoop中的Timer就不会执行。
         
         
         即 拖动 时候 定时器不走
         */
        [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSDefaultRunLoopMode];
    } else {
        // Fallback on earlier versions
    }
    
    
    self.textLabel2 = [[UILabel alloc]init];
    self.textLabel2.backgroundColor = UIColor.systemGrayColor;
    [containerView addSubview:self.textLabel2];
    self.textLabel2.text = @"0";
    
    [self.textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(containerView);
        make.top.equalTo(self.textLabel.mas_bottom);
    }];
    
    NSInteger __block count2 = 0;
    if (@available(iOS 10.0, *)) {
        ax_weakify(self);
        self.timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            ax_strongify(self);
            NSLog(@"NSRunLoopCommonModes = %@",[NSThread currentThread].name);
            count2++;
            
            self.textLabel2.text = [NSString stringWithFormat:@"%ld",count2];
        }];
        
        
        /**
         为了设置一个不被UI干扰的Timer，我们需要手动创建一个Timer，然后使用RunLoop的 addTimer:forMode: 方法来把Timer按照指定的模式加入到RunLoop中。这里使用 NSRunLoopCommonModes 模式，这个模式相当于 NSDefaultRunLoopMode 和 NSEventTrackingRunLoopMode 的结合。
         */
        [[NSRunLoop currentRunLoop] addTimer:self.timer2 forMode:NSRunLoopCommonModes];
    } else {
        // Fallback on earlier versions
    }
    
}




- (void)dealloc {
    NSLog(@"dealloc====");
    [self.timer1 invalidate];
    [self.timer2 invalidate];
    
    
    
}

@end
