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

/**
 RACCommand与RACSubject的区别
 RACCommand 用来做事情,比如 增删改查数据源,然后调用刷新RACSubject
 RACSubject 用来监听事情, 比如 刷新RACSubject
 RACCommand通常来处理有多种状态的信号的类
 https://www.jianshu.com/p/76a926e031f4
 RACSubject
 
 是什么
 
 定义
 
 信号提供者，既能发送信号，又能订阅信号
 
 使用场景
 
 多用于代理，相当于OC里的delegate或者回调block
 
 
 */
@interface _22ReactiveObjCViewController ()

@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation _22ReactiveObjCViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ReactiveObjC";
    
    [self _01UITextField];
    [self _01UITextField_text];
    [self _03timer];
    [self _04arrayMap];
    [self _05ForSelector];
    [self _06RACReplaySubject];
    [self _08zipWith];
    [self _08merge];
    [self _08then];
    [self _08concat];
    [self _09Command];
    
    
    //    [RACObserve(button, enabled) subscribeNext:^(NSNumber  * x) {
    //
    //
    //    }];
    
    
    /// 底部约束
    [self _loadBottomAttribute];
    
}

-(void)_01UITextField_text {
    
    UITextField *tf1;
    {
        UITextField *view = [[UITextField alloc] init];
        [self.containerView addSubview:view];
        view.backgroundColor = UIColor.grayColor;
        view.placeholder = @"输入值";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        
        tf1 =view;
        self.bottomAttribute = view.mas_bottom;
    }
    UITextField *tf2;
    {
        UITextField *view = [[UITextField alloc] init];
        [self.containerView addSubview:view];
        view.backgroundColor = UIColor.grayColor;
        view.placeholder = @"点击赋值";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        
        tf2 =view;
        self.bottomAttribute = view.mas_bottom;
    }
    
    UIButton *btn0;
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.backgroundColor = UIColor.grayColor;
        [btn ax_setTitleStateNormal:@"可用"];
        [btn ax_setTitleStateDisabled:@"不可用"];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            tf1.text = [NSString stringWithFormat:@"%d",ax_randomZeroToValue(3)];
        }];
        btn0 = btn;
        self.bottomAttribute = btn.mas_bottom;
    }
    UIButton *btn1;
    
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.backgroundColor = UIColor.grayColor;
        [btn ax_setTitleStateNormal:@"组合二绑定一,点击给tf赋值"];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        __block int val = 0;
        
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            val++;
            if (val>=3) {
                val = 0;
            }
            if (val == 0) {
                tf2.text = nil;
            }else {
                tf2.text = [NSString stringWithFormat:@"%d",val];
            }
        }];
        
        btn1 = btn;
        self.bottomAttribute = btn.mas_bottom;
    }
    
    /// UITextField 组合 最佳答案, tf变化和赋值都会执行
    ///  ^id _Nullable (NSString *text1, NSString *text2) 后面参数最多相同,可用少
    RACSignal *comineSiganl = [RACSignal combineLatest:@[tf1.rac_textSignal,tf2.rac_textSignal, RACObserve(tf1, text),RACObserve(tf2, text)] reduce:^id _Nullable  {
        NSLog(@"text1 = %@,text2 = %@",tf1.text,tf2.text);
        return @(tf1.text.length && tf2.text.length);
    }];
    
    /// 文字变化,初始化有点问题
    //    RACSignal *comineSiganl = [RACSignal combineLatest:@[tf1.rac_newTextChannel,tf2.rac_newTextChannel, RACObserve(tf2, text)] reduce:^id _Nullable (NSString *text1, NSString *text2, NSString *text22) {
    //        NSLog(@"text1 = %@,text2 = %@,text22 = %@",text1,text2,text22);
    //        return @(tf1.text.length && tf2.text.length);
    //    }];
    //
    
    
    
    //    [RACObserve(tf2, text) subscribeNext:^(id x) {
    //        NSLog(@"点击给 UITextField赋值 = %@",x);
    //    }];
    //
    //    [tf2.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
    //        NSLog(@"点击给 UITextField赋值2 = %@",x);
    //    }];
    //    [tf2.rac_newTextChannel subscribeNext:^(NSString * _Nullable x) {
    //        NSLog(@"点击给 UITextField赋值3 = %@",x);
    //    }];
    
    RAC(btn0, enabled) = comineSiganl;
    [RACObserve(btn0, enabled) subscribeNext:^(id  _Nullable x) {
        btn0.backgroundColor = [x boolValue] ? UIColor.redColor : UIColor.grayColor;
    }];
}
-(void)_01UITextField {
    
    
    UILabel *label1;
    {
        UILabel *label = [[UILabel alloc] init];
        [self.containerView addSubview:label];
        label.backgroundColor = UIColor.grayColor;
        label.text = @"label1";
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        
        
        label1 =label;
        self.bottomAttribute = label.mas_bottom;
    }
    UIButton *btn1;
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.backgroundColor = UIColor.grayColor;
        [btn ax_setTitleStateNormal:@"UITextField 双向绑定,点击label赋值"];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        /// 按钮事件
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            label1.text = [NSString stringWithFormat:@"%d",ax_randomZeroToValue(3)];
        }];
        
        btn1 = btn;
        self.bottomAttribute = btn.mas_bottom;
    }
    UITextField *tf;
    {
        UITextField *view = [[UITextField alloc] init];
        [self.containerView addSubview:view];
        view.backgroundColor = UIColor.grayColor;
        view.placeholder = @"tf";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        
        tf =view;
        
        self.bottomAttribute = view.mas_bottom;
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.containerView addSubview:btn];
        btn.backgroundColor = UIColor.grayColor;
        [btn ax_setTitleStateNormal:@"UITextField 双向绑定,点击tf赋值"];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        /// 按钮事件
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            tf.text = [NSString stringWithFormat:@"%d",ax_randomFromTo(100,103)];
        }];
        
        btn1 = btn;
        self.bottomAttribute = btn.mas_bottom;
    }
    
    RACChannelTo(label1, text) = RACChannelTo(tf, text);
    /// 需要增加一个绑定
    [tf.rac_textSignal subscribe:RACChannelTo(label1, text)];
    
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
    //    RAC(label1, text) = [tf.rac_newTextChannel filter:^BOOL(NSString * _Nullable value) {
    //        return value.length>3;
    //    }];
    //    RAC(tf, text) = RACObserve(label1, text);
    //    RAC(label1, text) = [tf.rac_newTextChannel subscribeNext:^(NSString * _Nullable x) {
    //
    //    }];
    
    
    
    ///
    //    RAC(label1, text) = tf.rac_newTextChannel;
    //    RAC(tf, text) = [RACObserve(label1, text) map:^id _Nullable(id  _Nullable value) {
    //        NSLog(@"value = %@",value);
    //        return [value isEqualToString:@"2"] ? @"我是2" : value;
    //    }];
}
/// 定时器
-(void)_03timer {
    
    
    [self _p00ButtonTitle:@"interval 定时器" handler:^(UIButton * _Nonnull btn) {
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


-(void)_04arrayMap {
    
    [self _p00ButtonTitle:@"NSArray map" handler:^(UIButton * _Nonnull btn) {
        
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
-(void)_05ForSelector {
    
    // 方式二: rac_signalForSelector
    [[self rac_signalForSelector:@selector(_05Selector:)] subscribeNext:^(id  _Nullable x) {
        //        NSLog(@"rac_signalForSelector: %@", x);
        NSString *name = x[0];
        NSLog(@"rac_signalForSelector: name %@", name);
    }];
    
    [self _p00ButtonTitle:@"监听方法被调用" handler:^(UIButton * _Nonnull btn) {
        [self _05Selector:@"jim"];
    }];
    
}

-(void)_06RACReplaySubject {
    
    UIButton *btn = [[UIButton alloc] init];
    [self.containerView addSubview:btn];
    btn.backgroundColor = UIColor.grayColor;
    [btn ax_setTitleStateNormal:@"UIButton 2次订阅"];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.right.mas_equalTo(20);
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
    self.bottomAttribute = btn.mas_bottom;
    
}

-(void)_08zipWith {
    
    
    [self _p00ButtonTitle:@"所有请求完成" handler:^(UIButton * _Nonnull btn) {
        
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

-(void)_08merge {
    
    return [self _p00ButtonTitle:@"任意信号发送完成,都会回调" handler:^(UIButton * _Nonnull btn) {
        
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

-(void)_08then {
    
    return [self _p00ButtonTitle:@"then: 组合信号, 忽悠掉第一个信号" handler:^(UIButton * _Nonnull btn) {
        
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
-(void)_08concat {
    
    return [self _p00ButtonTitle:@"concat: 顺序链接组合信号" handler:^(UIButton * _Nonnull btn) {
        
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

-(void)_09Command  {
    /**
     *  RACCommand使用注意
     *  1、RACCommand内部必须返回RACSignal
     *  2、executionSignals信号中的信号，一开始获取不到内部信号
     *      2.1 使用switchToLatest:获取内部信号
     *      2.2 使用execute:获取内部信号
     *  3、executing判断是否正在执行
     *      3.1 第一次不准确，需要skip:跳过
     *      3.2 一定要记得sendCompleted，否则永远不会执行完成
     *  4、通过执行execute，执行command的block
     */
    
    RACCommand *com = [RACCommand.alloc initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input 接收到execute的参数 = %@",input);
        //        return [RACSignal return:@"AAA"];
        
        //创建信号,用来传递数据
        
        //           return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //               [subscriber sendNext:[NSString stringWithFormat:@"返回值%@",input]];
        //               [subscriber sendCompleted];
        //               return nil;
        //           }];
        
        return [RACSignal return:[NSString stringWithFormat:@"返回值%@+%d",input,ax_randomZeroToValue(10)]];
        
    }];
    
    //    [[com.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
    //            //NSLog(@"x = %@", x);
    //            if (x.boolValue) {
    //                NSLog(@"x = %@ 正在执行", x);
    //            } else {
    //                NSLog(@"x = %@ 执行完成", x);
    //            }
    //        }];
    [com.executing subscribeNext:^(NSNumber * _Nullable x) {
        //NSLog(@"x = %@", x);
        if (x.boolValue) {
            NSLog(@"x = %@ 正在执行", x);
        } else {
            NSLog(@"x = %@ 执行完成 \n", x);
        }
    }];
    
    /// RACCommand中的executionSignals属性是一个包裹着信号的信号
    [[com executionSignals]
     subscribeNext:^(RACSignal *x) {
        [x subscribeNext:^(id x) {
            NSLog(@"信号处理 包裹着信号 = %@",x);
        }];
    }];
    /// 如果你嫌订阅两个事件麻烦的话，可以使用函数switchToLatest进行转换：
    [com.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号处理 switchToLatest = %@",x);
    }];
    
    [[[com.executionSignals.switchToLatest filter:^BOOL(id  _Nullable value) {
        NSLog(@"filter = %@",value);
        return YES;
    }]map:^id _Nullable(id  _Nullable value) {
        NSLog(@"map = %@",value);
        return value;
    }]subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext = %@",x);
    }];
    
    
    //
    //    [com.executing subscribeNext:^(id x){
    //      //信号处理
    //        NSLog(@"信号处理 = %@",x);
    //    }];
    //
    //
    //
    //
    //    [[[com.executing  filter:^BOOL(id  _Nullable value) {
    //        NSLog(@"filter = %@",value);
    //        return YES;
    //    }]map:^id _Nullable(id  _Nullable value) {
    //        NSLog(@"map = %@",value);
    //        return value;
    //    }]subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"subscribeNext = %@",x);
    //    }];
    //
    
    //    RACCommand *com2 = [RACCommand.alloc initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    //        NSLog(@"input = %@",input);
    //        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    //            [subscriber sendNext:@"tom"];
    //            /// 没有的话只能执行一次
    //            [subscriber sendCompleted];
    //
    ////            return [RACDisposable disposableWithBlock:^{
    ////
    ////            }];
    ////
    //            //一般都返回nil
    //            return nil;
    //        }];
    //    }];
    
    [self _p00ButtonTitle:@"执行execute" handler:^(UIButton * _Nonnull btn) {
        [com execute:@"jim"];
    }];
    
    //    [self _p00ButtonTitle:@"执行execute" handler:^(UIButton * _Nonnull btn) {
    //        [[com execute:@"jim"]subscribeNext:^(id  _Nullable x) {
    //            NSLog(@"返回值 = %@",x);
    //        }];
    //    }];
    
    //    [self _p00ButtonTitle:@"执行execute,过滤" handler:^(UIButton * _Nonnull btn) {
    //
    //        [[[[com execute:@"jim"] filter:^BOOL(id  _Nullable value) {
    //            NSLog(@"filter = %@",value);
    //            return YES;
    //        }]map:^id _Nullable(id  _Nullable value) {
    //            NSLog(@"map = %@",value);
    //            return value;
    //        }]subscribeNext:^(id  _Nullable x) {
    //            NSLog(@"subscribeNext = %@",x);
    //        }];
    //    }];
    
    //    [self _p00ButtonTitle:@"sendCompleted,没有的话只能执行一次" handler:^(UIButton * _Nonnull btn) {
    //        [[com2 execute:@"jim"]subscribeNext:^(id  _Nullable x) {
    //            NSLog(@"返回值 = %@",x);
    //        }];
    //    }];
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
        btn.backgroundColor = UIColor.grayColor;
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
        btn.backgroundColor = UIColor.grayColor;
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
        label.backgroundColor = UIColor.grayColor;
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
        view.backgroundColor = UIColor.grayColor;
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
        btn.backgroundColor = UIColor.grayColor;
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
        btn.backgroundColor = UIColor.grayColor;
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
        btn.backgroundColor = UIColor.grayColor;
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

