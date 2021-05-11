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
 RACSubject 继承 RACSignal
 
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
 //获得属性key
 @keypath()
 
 */
/**
 *  bind：
 *
 *  merge：合并，只要任何一个信号发送数据，就能订阅
 *  contact：必须要信号A发送完成，信号B才能订阅
 *  then：拼接，忽略掉上一个信号的值。解决Block嵌套的问题
 *
 *  zipWith：压缩，同时发送数据，才能订阅到。压缩信号数据，变成元祖。
 *  combineLatest：任何一个信号，只要改变就能订阅到（combineLatest、reduce）
 *
 *  combineLatest：合并
 *  reduce：聚合
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
    [self _kvoArray];
    [self _03timer];
    [self _04arrayMap];
    [self _05ForSelector];
    [self _06RACReplaySubject];
    [self _08zipWith];
    [self _08merge];
    [self _08merge_label];
    [self _08then];
    [self _08concat];
    [self _09Command];
    [self _switchBind];
    [self _note];
    [self _note1];
    [self _group];
    /// 底部约束
    [self _lastLoadBottomAttribute];
    
    [self.rac_willDeallocSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"当前控制器消失 rac_willDeallocSignal");
    }];
    [[self rac_signalForSelector:@selector(viewWillDisappear:)] subscribeNext:^(id  _Nullable x) {
        NSLog(@"当前控制器消失,viewWillDisappear");
    }];
}

-(void)_baseUser {
    /// 这几个一般直接用 filter 过滤
    [self _titlelabel:@"几个基础的过滤"];
    [self _buttonTitle:@"过滤" handler:^(UIButton * _Nonnull btn) {
        [self skip];
        [self distinctUntilChanged];
        [self take];
        [self takeLast];
        [self takeUntil];
        [self ignore];
    }];
}
// 跳跃 ： 如下，skip传入2 跳过前面两个值
// 实际用处： 在实际开发中比如 后台返回的数据前面几个没用，我们想跳跃过去，便可以用skip
- (void)skip {
    RACSubject *subject = [RACSubject subject];
    [[subject skip:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
}

//distinctUntilChanged:-- 如果当前的值跟上一次的值一样，就不会被订阅到
- (void)distinctUntilChanged {
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 发送信号
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@2]; // 不会被订阅
}

// take:可以屏蔽一些值,去前面几个值---这里take为2 则只拿到前两个值
- (void)take {
    RACSubject *subject = [RACSubject subject];
    [[subject take:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 发送信号
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
}

//takeLast:和take的用法一样，不过他取的是最后的几个值，如下，则取的是最后两个值
//注意点:takeLast 一定要调用sendCompleted，告诉他发送完成了，这样才能取到最后的几个值
- (void)takeLast {
    RACSubject *subject = [RACSubject subject];
    [[subject takeLast:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 发送信号
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
    [subject sendCompleted];
}

// takeUntil:---给takeUntil传的是哪个信号，那么当这个信号发送信号或sendCompleted，就不能再接受源信号的内容了。
- (void)takeUntil {
    RACSubject *subject = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    [[subject takeUntil:subject2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 发送信号
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject2 sendNext:@3];  // 1
    //    [subject2 sendCompleted]; // 或2
    [subject sendNext:@4];
}

// ignore: 忽略掉一些值
- (void)ignore {
    //ignore:忽略一些值
    //ignoreValues:表示忽略所有的值
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    // 2.忽略一些值
    RACSignal *ignoreSignal = [subject ignore:@2]; // ignoreValues:表示忽略所有的值
    // 3.订阅信号
    [ignoreSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 4.发送数据
    [subject sendNext:@2];
    
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
    RAC(btn0, enabled) = comineSiganl;
    [RACObserve(btn0, enabled) subscribeNext:^(id  _Nullable x) {
        btn0.backgroundColor = [x boolValue] ? UIColor.redColor : UIColor.grayColor;
    }];
    
    [[[tf2.rac_textSignal merge:RACObserve(tf2, text)] bind:^RACSignalBindBlock {
        
        // return 的这个大的block 的作用:表示绑定了一个源信号 - subject
        return ^RACSignal *(id _Nullable value, BOOL *stop) {
            
            // 什么时候调用block: 当源信号有新的值发出, 就会来到这个block
            NSLog(@"subject 发送了新信号: %@", value);
            
            // block作用:做返回值的处理
            NSString *newString = [NSString stringWithFormat:@"do bind: %@", value];
            
            // 做好处理，通过信号返回出去.
            return [RACSignal return:newString];
        };
        
        
    }]subscribeNext:^(id  _Nullable x) {
        NSLog(@"bind = %@", x);
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

-(void)_kvoArray {
    
    [self _titlelabel:@"监听数组"];
    UIView *view = UIView.alloc.init;
    view.backgroundColor = UIColor.redColor;
    [self.containerView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
    self.bottomAttribute = view.mas_bottom;
    //    RAC(view, hidden) = RACObserve(self.dataArray, count);
    //
    //    [[RACObserve(self, dataArray) merge:self.dataArray.rac_sequence.signal] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"数组 = %@",x);
    //    }];
    RAC(view, hidden) = [[RACObserve(self, dataArray) merge:self.dataArray.rac_sequence.signal]  map:^id _Nullable(NSMutableArray *value) {
        NSLog(@"数组 = %@",value);
        return @(!value.count);
    }];
    //    RAC(view, hidden) = [RACObserve(self.dataArray, count) merge:self.dataArray.rac_sequence.signal];
    
    //    [RACObserve(self.dataArray, count) subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"数组 = %@",x);
    //    }];
    [self _buttonTitle:@"添加元素" handler:^(UIButton * _Nonnull btn) {
        [[self mutableArrayValueForKeyPath:@keypath(self,dataArray)] addObject:@"A"];
    }];
    [self _buttonTitle:@"清空元素" handler:^(UIButton * _Nonnull btn) {
        [[self mutableArrayValueForKeyPath:@keypath(self,dataArray)] removeAllObjects];
    }];
    
}

/// 定时器
-(void)_03timer {
    
    
    [self _buttonTitle:@"interval 定时器" handler:^(UIButton * _Nonnull btn) {
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
    
    [self _buttonTitle:@"NSArray map" handler:^(UIButton * _Nonnull btn) {
        
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
    [self _titlelabel:@"监听方法被调用"];
    // 方式二: rac_signalForSelector
    [[self rac_signalForSelector:@selector(_05Selector:)] subscribeNext:^(id  _Nullable x) {
        //        NSLog(@"rac_signalForSelector: %@", x);
        NSString *name = x[0];
        NSLog(@"rac_signalForSelector: name %@", name);
    }];
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"调用方法" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _05Selector:@"jim"];
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
    
    
    [self _buttonTitle:@"所有请求完成" handler:^(UIButton * _Nonnull btn) {
        
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
    
    [self _titlelabel:@"merge 任意信号发送完成"];
    // 任意信号发送完成都会调用 nextBlock block.
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSignal *mergeSiganl = [signalA merge:signalB];
    [mergeSiganl subscribeNext:^(id x) {
        NSLog(@"merge = %@", x);
    }];
    
    [self _buttonTitle:@"任意信号发送完成,都会回调" handler:^(UIButton * _Nonnull btn) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [signalB sendNext:@"数据B"];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [signalA sendNext:@"数据A"];
        });
        
    }];
    
}

-(void)_08merge_label {
    
    [self _titlelabel:@"merge 同时监控UIKit属性"];
    
    UILabel *label1 = UILabel.alloc.init;
    label1.text = @"label1";
    [self.containerView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label1.mas_bottom;
    
    UILabel *label2 = UILabel.alloc.init;
    label2.text = @"label2";
    [self.containerView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label2.mas_bottom;
    
    UILabel *label3 = UILabel.alloc.init;
    label3.text = @"label3";
    [self.containerView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label3.mas_bottom;
    
    RACSignal *signal = [[RACObserve(label1, hidden) merge:RACObserve(label2, hidden)] merge:RACObserve(label3, hidden)];
    
    [signal  subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"同时监控多个隐藏,任意一个 = %@", x);
        NSLog(@"label1= %d,label2= %d,label3= %d,", label1.isHidden,label2.isHidden,label3.isHidden);
        
    }];
    
    [self _buttonTitle:@"label1隐藏" handler:^(UIButton * _Nonnull btn) {
        label1.hidden = YES;
        if (label2.hidden) {
            label2.hidden = NO;
        }
        if (label3.hidden) {
            label2.hidden = NO;
        }
    }];
    [self _buttonTitle:@"label2隐藏" handler:^(UIButton * _Nonnull btn) {
        
        if (label1.hidden) {
            label1.hidden = NO;
        }
        label2.hidden = YES;
        if (label3.hidden) {
            label2.hidden = NO;
        }
    }];
    [self _buttonTitle:@"label3隐藏" handler:^(UIButton * _Nonnull btn) {
        if (label1.hidden) {
            label1.hidden = NO;
        }
        if (label2.hidden) {
            label2.hidden = NO;
        }
        label3.hidden = YES;
    }];
    
}

-(void)_08then {
    
    //    RACSubject *subA = [RACSubject subject];
    //    RACSubject *subB = [RACSubject subject];
    //
    //    [[subA merge:subB] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
    //
    //    [subA sendNext:@"A"];
    //    [subB sendNext:@"B"];
    
    
    
    //    RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    //        NSLog(@"发送A请求");
    //        [subscriber sendNext:@"数据A"];
    //        [subscriber sendCompleted];
    //        return nil;
    //    }];
    //
    //    RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    //        NSLog(@"发送B请求");
    //        [subscriber sendNext:@"数据B"];
    //        return nil;
    //    }];
    //
    //    // then: 组合信号, 忽悠掉第一个信号.
    //    RACSignal *thenSiganl = [siganlA then:^RACSignal *{
    //        return siganlB; // 需要组合的信号
    //    }];
    //
    //    [thenSiganl subscribeNext:^(id x) {
    //        NSLog(@"%@", x);
    //    }];
    
    [self _titlelabel:@"then：拼接，忽略掉上一个信号的值。解决Block嵌套的问题\n subA第一次发送才有结果,subBthen后,subA就被忽略了"];
    // RACSubject 继承 RACSignal
    RACSubject *subA = [RACSubject subject];
    RACSubject *subB = [RACSubject subject];
    [subA subscribeNext:^(id  _Nullable x) {
        NSLog(@"subA  = %@",x);
    }];
    [subB subscribeNext:^(id  _Nullable x) {
        NSLog(@"subB  = %@",x);
    }];
    [[ subA then:^RACSignal * _Nonnull{
        return subB;
    }]subscribeNext:^(id  _Nullable x) {
        NSLog(@"subA then subB = %@",x);
    }];
    
    [self _buttonTitle:@"then:  subA" handler:^(UIButton * _Nonnull btn) {
        
        [subA sendNext:@"A"];
        //         [subA sendCompleted];
        
    }];
    [self _buttonTitle:@"then: subB" handler:^(UIButton * _Nonnull btn) {
        [subB sendNext:@"B"];
        /// 完成,才能出发then
        [subA sendCompleted];
        
        
    }];
    
}
-(void)_08concat {
    
    [self _buttonTitle:@"concat: 顺序链接组合信号" handler:^(UIButton * _Nonnull btn) {
        
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
    
    [self _buttonTitle:@"执行execute" handler:^(UIButton * _Nonnull btn) {
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
-(void)_switchBind {
    [self _titlelabel:@"UISwitch双向绑定"];
    UISwitch  *aSwitch  = [[UISwitch alloc] init];
    [self.containerView addSubview:aSwitch];
    [aSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.centerX.mas_equalTo(0);
    }];
    
    self.bottomAttribute =  aSwitch.mas_bottom;
    
    NSLog(@"进入 key = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"someBoolKey"]);
    /// UISwitch 双向绑定
    RACChannelTerminal *switchTerminal = aSwitch.rac_newOnChannel;
    RACChannelTerminal *defaultsTerminal = [[NSUserDefaults standardUserDefaults] rac_channelTerminalForKey:@"someBoolKey"];
    [switchTerminal subscribe:defaultsTerminal];
    [defaultsTerminal subscribe:switchTerminal];
    /// 监听变化
    [aSwitch.rac_newOnChannel subscribeNext:^(NSNumber *onValue) {
        // 下面两句都可以
        //            [someSwitch setValue:onValue forKey:@"on"];
        //[[NSUserDefaults standardUserDefaults] setObject:onValue forKey:@"someBoolKey"];
        NSLog(@"isOn = %d  key =%@",aSwitch.isOn,[[NSUserDefaults standardUserDefaults] objectForKey:@"someBoolKey"]);
    }];
}

-(void)_note {
    __weak typeof(self) weakSelf = self;
    [self _titlelabel:@"rac通知,无法主动取消"];
   
    /// distinctUntilChanged
    [[[NSNotificationCenter.defaultCenter rac_addObserverForName:@"com.ax.note.rac" object:nil]
      takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"默认初始化 userInfo = %@",x.userInfo);
    }];
    
    [self _buttonTitle:@"多次监听通知" handler:^(UIButton * _Nonnull btn) {
        //        [[NSNotificationCenter.defaultCenter rac_addObserverForName:@"com.ax.note.rac" object:nil] subscribeCompleted:^{
        //            NSLog(@"通知被移除");
        //        }];
        
        NSLog(@"通知被移除");
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [[[NSNotificationCenter.defaultCenter rac_addObserverForName:@"com.ax.note.rac" object:nil]
          takeUntil:strongSelf.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
            NSLog(@"userInfo = %@,object = %@",x.userInfo,x.object);
        }];
    }];
    
    [self _buttonTitle:@"发送通知" handler:^(UIButton * _Nonnull btn) {
        
        [NSNotificationCenter.defaultCenter postNotificationName:@"com.ax.note.rac" object:nil userInfo:@{@"name":@"jim"}];
    }];
}
-(void)_note1 {
    __weak typeof(self) weakSelf = self;
    [self _titlelabel:@"原生通知"];
    NSString *noteName = @"com.ax.note2";
    //   id __block _observer = nil;
    //    [NSNotificationCenter.defaultCenter addObserverForName:noteName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
    //        NSLog(@"原生通知初始化 userInfo = %@",note.userInfo);
    //    }];
    //    @weakify(self);
    [self _buttonTitle:@"多次监听通知" handler:^(UIButton * _Nonnull btn) {
        //        [NSNotificationCenter.defaultCenter removeObserver:_observer];
        //        NSLog(@"移除通知");
        [NSNotificationCenter.defaultCenter addObserverForName:noteName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            NSLog(@"原生通知userInfo = %@,object = %@",note.userInfo,note.object);
        }];
    }];
    
    [self _buttonTitle:@"发送原生通知" handler:^(UIButton * _Nonnull btn) {
        
        [NSNotificationCenter.defaultCenter postNotificationName:noteName object:nil userInfo:@{@"name":@"tom"}];
    }];
}
- (void)_group {
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"异步组" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _groupRac];
    }];
}

-(void)_groupRac {
    
    // rac_liftSelector
    // 类似于dispatch_group 中的组
    // 多线程中的组 等所有的请求都完毕之后 去更新UI
    
    RACSignal *sg1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"网络请求数据1"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    RACSignal *sg2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"网络请求数据2"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    RACSignal *sg3 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [subscriber sendNext:@"网络请求数据3"];
            [subscriber sendError:[NSError ax_errorWithDescription:@"错误"]];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    //    [self rac_liftSelector:@selector(updateUI:str:str:) withSignals:sg1,sg2,sg3, nil];
//    [self rac_liftSelector:@selector(updateUI:str:str:) withSignalsFromArray:@[sg1,sg2,sg3]];
//    [self rac_liftSelector:@selector(updateUI:) withSignalsFromArray:@[sg1,sg2,sg3]];
    RACTuple *tu = [RACTuple tupleWithObjectsFromArray:@[sg1,sg2,sg3]];
//    [self rac_liftSelector:@selector(updateUI:) withSignalOfArguments:];
    
//   [ @[sg1,sg2,sg3].rac_sequence map:^id _Nullable(id  _Nullable value) {
//       NSLog(@"信号组一个参数 = %@",value);
//    }];
    
//    [@[sg1,sg2,sg3].rac_sequence.signal subscribeNext:^(id x) {
//        NSLog(@"array 遍历 = %@", x);
//    }];
    
    [[RACSignal concat:@[sg1,sg2,sg3]] subscribeNext:^(id  _Nullable x) {
        NSLog(@"array 遍历 = %@", x);

    } completed:^{
        NSLog(@"array 遍历 completed");
    }];
//
//    [[RACSignal concat:@[sg1,sg2,sg3]] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"group subscribeNext = %@",x);
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"group error = %@",error);
//    }completed:^{
//        NSLog(@"group = completed");
//    }];
}

-(void)updateUI:(id)str1
{
   
   // 回传过来
   NSLog(@"信号组一个参数 = %@",str1);
   
}

- (void)updateUI:(id)str1 str:(id)str2 str:(id)str3
{
    
    // 回传过来
    NSLog(@"信号组 = %@-%@-%@",str1,str2,str3);
    
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
    
    
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray.alloc init];
    }
    return _dataArray;
}

- (void)dealloc{
    axLong_dealloc;
}

@end

