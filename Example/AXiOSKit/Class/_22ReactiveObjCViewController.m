//
//  _22ReactiveObjCViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_22ReactiveObjCViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>




@interface NSString (EmailAdditions)


- (BOOL)isValidEmail;
@end


@implementation NSString (EmailAdditions)

- (BOOL)isValidEmail {
    NSString *emailPattern =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emailPattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    return match != nil;
}

@end


@interface _22ReactiveObjCViewController ()


@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong) UIView *containerView;

@end

@implementation _22ReactiveObjCViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ReactiveObjC";
    
    UIScrollView *scrollView = [UIScrollView.alloc init];
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 2.给scrollView添加一个containerView
    UIView *containerView = [UIView.alloc init];
    containerView.backgroundColor = UIColor.orangeColor;
    self.containerView = containerView;
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView); // 需要设置宽度和scrollview宽度一样
    }];
    UIView *topView = containerView;
    topView =  [self _01UITextField:topView];
    topView =  [self _03timer:topView];
    topView =  [self _04arrayMap:topView];
    topView =  [self _05ForSelector:topView];
    topView =  [self _06RACReplaySubject:topView];
    topView =  [self _07UITextFieldButton:topView];
    topView =  [self _08zipWith:topView];
    topView =  [self _08merge:topView];
    topView =  [self _08then:topView];
    topView =  [self _08concat:topView];
    
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom).mas_equalTo(100);// 这里放最后一个view的底部
    }];
    
}

-(UIView *)_00Button:(UIView *)topView title:(NSString *)title handler:(void(^)(void))handler {
    if (title.length==0) {
        title = @"title";
    }
    UIButton *btn = [[UIButton alloc] init];
    [self.containerView addSubview:btn];
    btn.backgroundColor = UIColor.blueColor;
    [btn ax_setTitleStateNormal:title];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).mas_equalTo(20);
        make.left.right.height.equalTo(topView).mas_equalTo(0);
    }];
    /// 按钮事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        if (handler) {
            handler();
        }
    }];
    topView =btn;
    return topView;
}


-(UIView *)_01UITextField:(UIView *)topView {
    
    
    UILabel *label1;
    {
        UILabel *label = [[UILabel alloc] init];
        [self.containerView addSubview:label];
        label.backgroundColor = UIColor.blueColor;
        label.text = @"label1";
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_top).mas_equalTo(ax_status_bar_height());
            make.left.equalTo(topView).mas_equalTo(20);
            make.right.equalTo(topView).mas_equalTo(-20);
            //            make.height.mas_equalTo(all_height);
        }];
        
        
        label1 =label;
        topView =label;
    }
    UITextField *tf;
    {
        UITextField *view = [[UITextField alloc] init];
        [self.containerView addSubview:view];
        view.backgroundColor = UIColor.blueColor;
        view.ax_top = topView.ax_bottom + 10;
        view.ax_left = topView.ax_left;
        view.placeholder = @"tf";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).mas_equalTo(20);
            make.left.right.height.equalTo(topView).mas_equalTo(0);
        }];
        
        tf =view;
        
        topView =view;
    }
    
    UIButton *btn1;
    
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"UITextField 双向绑定"];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).mas_equalTo(20);
            make.left.right.height.equalTo(topView).mas_equalTo(0);
        }];
        
        //        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
        //            label1.text = [NSString stringWithFormat:@"%d",ax_randomZeroToValue(2)];
        //        }];
        /// 按钮事件
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            label1.text = [NSString stringWithFormat:@"%d",ax_randomZeroToValue(3)];
        }];
        
        btn1 = btn;
        topView =btn;
    }
    
    /// UITextField 双向绑定
   /***
    RACChannelTo(label1, text) = tf.rac_newTextChannel;
    
    [[tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
       return [value length] > 5;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"rac_textSignal filter %@", x);
    }];
    
    
    RACSignal *singal = RACObserve(label1, text);
    //    RACSignal *singal =tf.rac_newTextChannel;
    [singal.sequence map:^id _Nullable(id  _Nullable value) {
        NSLog(@"UITextField 双向绑定 value = %@",value);
        return [value isEqualToString:@"2"] ? @"我是2" : value;
    }];
    [singal subscribeNext:^(id  _Nullable x) {
        NSLog(@"UITextField 双向绑定 x = %@",x);
    }];
    [label1.text.rac_sequence.signal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"UITextField 双向绑定2 x = %@",x);
    }];
    */
    
//    RAC(label1, text) = RACObserve(tf, text);
////    RAC(label1, text) = tf.rac_newTextChannel;;
    
    /// map
//    RAC(tf, text) = [RACObserve(label1, text) map:^id(id value) {
////        NSLog(@"%@ %@", value, [value class]);
//
//        return [value isEqualToString:@"2"] ? @"我是2" : value;
//    }];
//    RAC(label1, text) = [tf.rac_newTextChannel map:^id _Nullable(NSString * _Nullable value) {
//        return [value isEqualToString:@"2"] ? @"我是2" : value;
//    }];
    /// filter
    RAC(label1, text) = [tf.rac_newTextChannel filter:^BOOL(NSString * _Nullable value) {
        return value.length>3;
    }];
    RAC(tf, text) = RACObserve(label1, text);
    
    ///
//    RAC(label1, text) = tf.rac_newTextChannel;
//    RAC(tf, text) = [RACObserve(label1, text) map:^id _Nullable(id  _Nullable value) {
//        NSLog(@"value = %@",value);
//        return [value isEqualToString:@"2"] ? @"我是2" : value;
//    }];
    
    
    return topView;
}
/// 定时器
-(UIView *)_03timer:(UIView *)topView {
    
    return [self _00Button:topView title:@"interval 定时器" handler:^{
        __block NSInteger count = 0;
        __block  RACDisposable *signal =   [[RACSignal interval:1.0 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
            NSLog(@"interval = %@", x);
            count++;
            if(count>=5){
                [signal dispose];
            }
        }];
    }];
}


-(UIView *)_04arrayMap:(UIView *)topView {
    
    return [self _00Button:topView title:@"NSArray map" handler:^{
        
        
        NSArray *array = @[@"1", @"2", @"3"];
        
        RACTuple *tuple = RACTuplePack(array);
        NSLog(@"越界取值 = %@", tuple[10]);
        
        [array.rac_sequence.signal subscribeNext:^(id x) {
            NSLog(@"array 遍历 = %@", x);
        }];
        
        [[array.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
            return [value intValue] ==2 ? @"哈哈" : value;
        }] subscribeNext:^(id  _Nullable x) {
            NSLog(@"array map 后遍历 = %@", x);
        }];
        //    NSArray *array2 = [[array.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
        //            return [value intValue] ==2 ? @"哈哈" : value;
        //    }]  toArray];
        NSArray *array2 = [array.rac_sequence map:^id _Nullable(id  _Nullable value) {
            return [value intValue] ==2 ? @"哈哈" : value;
        }].array;
        NSLog(@"array2 map = %@", array2);
        
        NSDictionary *dictionary = @{@"name": @"willing", @"age": @"26"};
        [dictionary.rac_sequence.signal subscribeNext:^(RACTuple *x) {
            // 方式一:
            //        NSString *key = x[0];
            //        NSString *value = x[1];
            //        NSLog(@"%@: %@", key, value);
            
            // 方式二:
            // RACTupleUnpack: 解析元组, 参数是解析出来的变量名, '=' 右边是被解析的元组
            RACTupleUnpack(NSString *key, NSString *value) = x;
            NSLog(@"dictionary = %@: %@", key, value);
        }];
        
    }];
    
}

-(void)_05Selector:(NSString *)name {
    NSLog(@"_05Selector  %@", name);
}
-(UIView *)_05ForSelector:(UIView *)topView {
    
    // 方式二: rac_signalForSelector
    [[self rac_signalForSelector:@selector(_05Selector:)] subscribeNext:^(id  _Nullable x) {
        //        NSLog(@"rac_signalForSelector: %@", x);
        NSString *name = x[0];
        NSLog(@"rac_signalForSelector: name %@", name);
    }];
    
    return [self _00Button:topView title:@"监听方法被调用" handler:^{
        [self _05Selector:@"jim"];
    }];
    
}

-(UIView *)_06RACReplaySubject:(UIView *)topView {
    
    UIButton *btn = [[UIButton alloc] init];
    [self.containerView addSubview:btn];
    btn.backgroundColor = UIColor.blueColor;
    [btn ax_setTitleStateNormal:@"UIButton 2次订阅"];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).mas_equalTo(20);
        make.left.right.height.equalTo(topView).mas_equalTo(0);
    }];
    /// 按钮事件
    RACSignal *signal =  [btn rac_signalForControlEvents:UIControlEventTouchUpInside];
    
    // 2.信号转换成连接类
    //RACMulticastConnection *connection = [signal publish];
    RACMulticastConnection *connection = [signal multicast:[RACReplaySubject subject]];
    
    // 3.订阅连接类的信号
    [connection.signal subscribeNext:^(id x) {
        // subscriber sendNext 时执行此 block
        NSLog(@"订阅者一: %@",x);
    }];
    [connection.signal subscribeNext:^(id x) {
        // subscriber sendNext 时执行此 block
        NSLog(@"订阅者二: %@",x);
    }];
    
    // 4.连接
    [connection connect];
    
    
    //    [signal subscribeNext:^(UIButton *x) {
    //        NSLog(@"2次订阅 x : %@",x);
    //    }];
    topView =btn;
    return topView;
    
}

-(UIView *)_07UITextFieldButton:(UIView *)topView {
    
    UITextField *nameTF;
    {
        UITextField *view = [[UITextField alloc] init];
        [self.containerView addSubview:view];
        view.backgroundColor = UIColor.blueColor;
        view.placeholder = @"请输入账号";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).mas_equalTo(20);
            make.left.right.height.equalTo(topView).mas_equalTo(0);
        }];
        
        nameTF =view;
        
        topView =view;
    }
    UITextField *pswTF;
    {
        UITextField *view = [[UITextField alloc] init];
        [self.containerView addSubview:view];
        view.backgroundColor = UIColor.blueColor;
        view.placeholder = @"请输入密码";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).mas_equalTo(20);
            make.left.right.height.equalTo(topView).mas_equalTo(0);
        }];
        
        pswTF =view;
        topView =view;
    }
    
    UIButton *btn1;
    
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"账号密码UIButton可用"];
        [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
        btn.enabled = NO;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).mas_equalTo(20);
            make.left.right.height.equalTo(topView).mas_equalTo(0);
        }];
        
        
        RACSignal *comineSiganl = [RACSignal combineLatest:@[nameTF.rac_textSignal, pswTF.rac_textSignal]
                                                    reduce:^id _Nullable(NSString *username, NSString *password){
            NSLog(@"username: %@, password: %@", username, password);
            return @(username.length && password.length);
        }];
        // 订阅组合信号
        //    [comineSiganl subscribeNext:^(id x) {
        //        _loginBtn.enabled = [x boolValue];
        //    }];
        RAC(btn, enabled) = comineSiganl;
        
        btn1 = btn;
        topView =btn;
    }
    
    
    
    return topView;
}

-(UIView *)_08zipWith:(UIView *)topView {
    
    
    return [self _00Button:topView title:@"所有请求完成" handler:^{
        
        // 需求: 一个界面有多个请求, 所有请求完成才更新 UI.
        RACSubject *signalA = [RACSubject subject];
        RACSubject *signalB = [RACSubject subject];
        RACSignal *zipSignal = [signalA zipWith:signalB];
        [zipSignal subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"数据A");
            [signalA sendNext:@"数据A"];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"数据B");
            [signalB sendNext:@"数据B"];
        });
        
    }];
    
}

-(UIView *)_08merge:(UIView *)topView {
    
    return [self _00Button:topView title:@"任意信号发送完成,都会回调" handler:^{
        
        // 任意信号发送完成都会调用 nextBlock block.
        RACSubject *signalA = [RACSubject subject];
        RACSubject *signalB = [RACSubject subject];
        RACSignal *mergeSiganl = [signalA merge:signalB];
        [mergeSiganl subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [signalB sendNext:@"数据B"];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [signalA sendNext:@"数据A"];
        });
        
    }];
    
}

-(UIView *)_08then:(UIView *)topView {
    
    return [self _00Button:topView title:@"then: 组合信号, 忽悠掉第一个信号" handler:^{
        
        RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"发送A请求");
            [subscriber sendNext:@"数据A"];
            [subscriber sendCompleted];
            return nil;
        }];
        
        RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"发送B请求");
            [subscriber sendNext:@"数据B"];
            return nil;
        }];
        
        // then: 组合信号, 忽悠掉第一个信号.
        RACSignal *thenSiganl = [siganlA then:^RACSignal *{
            return siganlB; // 需要组合的信号
        }];
        
        [thenSiganl subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
        
    }];
    
}
-(UIView *)_08concat:(UIView *)topView {
    
    return [self _00Button:topView title:@"concat: 顺序链接组合信号" handler:^{
        
        RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"发送A请求");
            [subscriber sendNext:@"数据A"];
            [subscriber sendCompleted];
            return nil;
        }];
        
        RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"发送B请求");
            [subscriber sendNext:@"数据B"];
            return nil;
        }];
        
        // concat: 顺序链接组合信号
        // 注意: concat 方法的 第一个信号必须要调用 sendCompleted.
        RACSignal *concatSignal = [siganlA concat:siganlB];
        
        [concatSignal subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
        
    }];
    
}
-(void)_RACChannelTo{
    
    UIView *topView = self.view;
    CGFloat all_width = 150;
    CGFloat all_height = 50;
    
    
    UIButton *btn1;
    
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"Normal"];
        [btn ax_setTitleStateDisabled:@"Disabled"];
        btn.ax_top = topView.top + ax_status_bar_height();
        btn.ax_left = topView.ax_left+50;
        
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
            
        }];
        btn1 = btn;
        topView =btn;
    }
    UIButton *btn2;
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"Normal-2"];
        [btn ax_setTitleStateDisabled:@"Disabled-2"];
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
        
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
            
        }];
        btn2 = btn;
        topView =btn;
    }
    UILabel *label1;
    {
        UILabel *label = [[UILabel alloc] init];
        [self.containerView addSubview:label];
        label.frame = CGRectMake(0, 0, all_width, all_height);
        label.backgroundColor = UIColor.blueColor;
        label.ax_top = topView.ax_bottom + 10;
        label.ax_left = topView.ax_left;
        label.text = @"label1";
        label1 =label;
        topView =label;
    }
    UITextField *tf;
    {
        UITextField *view = [[UITextField alloc] init];
        [self.containerView addSubview:view];
        view.frame = CGRectMake(0, 0, all_width, all_height);
        view.backgroundColor = UIColor.blueColor;
        view.ax_top = topView.ax_bottom + 10;
        view.ax_left = topView.ax_left;
        view.placeholder = @"tf";
        tf =view;
        topView =view;
    }
    UILabel *label2;
    {
        UILabel *label = [[UILabel alloc] init];
        [self.containerView addSubview:label];
        label.frame = CGRectMake(0, 0, all_width, all_height);
        label.backgroundColor = UIColor.grayColor;
        label.ax_top = topView.ax_bottom + 10;
        label.ax_left = topView.ax_left;
        label.text = @"label2";
        label2 =label;
        topView =label;
    }
    UITextView *textView;
    {
        UITextView *view = [[UITextView alloc] init];
        [self.containerView addSubview:view];
        view.frame = CGRectMake(0, 0, all_width, all_height);
        view.backgroundColor = UIColor.grayColor;
        view.ax_top = topView.ax_bottom + 10;
        view.ax_left = topView.ax_left;
        textView =view;
        topView =view;
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"清空数组"];
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
        
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
            [self.dataArray removeAllObjects];
            btn1.enabled = ! btn1.enabled;
            label1.text = [NSString stringWithFormat:@"%d",ax_randomZeroToValue(100)];
            label2.text = [NSString stringWithFormat:@"%d",ax_randomZeroToValue(50)];
        }];
        
        topView =btn;
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"添加数组"];
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
        
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
            [self.dataArray addObject:@"A"];
            btn2.enabled = ! btn2.enabled;
        }];
        
        topView =btn;
    }
    
    RACChannelTo(btn1, enabled) =  RACChannelTo(btn2, enabled);
    
    //    RACChannelTo(label1, text) =  RACChannelTo(tf, text);
    
    /// https://blog.csdn.net/maolianshuai/article/details/90474652
    
    /// UITextField 双向绑定
    RACChannelTo(label1, text) = tf.rac_newTextChannel;
    
    /// UITextView 双向绑定
    RACChannelTo(label2, text) = RACChannelTo(textView, text);
    [textView.rac_textSignal subscribe:RACChannelTo(label2, text)];
    
    UISwitch  *someSwitch;
    {
        UISwitch *btn = [[UISwitch alloc] init];
        [self.containerView addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
        
        topView =btn;
        someSwitch=btn;
    }
    
    NSLog(@"进入 key = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"someBoolKey"]);
    //    [someSwitch setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"someBoolKey"] forKey:@"on"];
    //    [[RACKVOChannel alloc] initWithTarget:[NSUserDefaults standardUserDefaults]
    //                                      keyPath:@"someBoolKey" nilValue:@(NO)][@"followingTerminal"] = [[RACKVOChannel alloc] initWithTarget:someSwitch keyPath:@"on" nilValue:@(NO)][@"followingTerminal"];
    //
    //    // 上面的不能完全实现双向绑定，因为 UISwitch 的 on 属性是不支持 KVO 的
    //    @weakify(self)
    //    [someSwitch.rac_newOnChannel subscribeNext:^(NSNumber *onValue) {
    //        @strongify(self)
    //
    //        // 下面两句都可以
    //        [someSwitch setValue:onValue forKey:@"on"];
    //        //[[NSUserDefaults standardUserDefaults] setObject:onValue forKey:@"someBoolKey"];
    //        NSLog(@"key = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"someBoolKey"]);
    //    }];
    
    /// UISwitch 双向绑定
    RACChannelTerminal *switchTerminal = someSwitch.rac_newOnChannel;
    RACChannelTerminal *defaultsTerminal = [[NSUserDefaults standardUserDefaults] rac_channelTerminalForKey:@"someBoolKey"];
    [switchTerminal subscribe:defaultsTerminal];
    [defaultsTerminal subscribe:switchTerminal];
    /// 监听变化
    [someSwitch.rac_newOnChannel subscribeNext:^(NSNumber *onValue) {
        // 下面两句都可以
        //            [someSwitch setValue:onValue forKey:@"on"];
        //[[NSUserDefaults standardUserDefaults] setObject:onValue forKey:@"someBoolKey"];
        NSLog(@"isOn = %d  key =%@",someSwitch.isOn,[[NSUserDefaults standardUserDefaults] objectForKey:@"someBoolKey"]);
    }];
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray.alloc init];
    }
    return _dataArray;
}
@end

