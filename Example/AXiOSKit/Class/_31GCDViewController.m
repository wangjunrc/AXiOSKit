//
//  _31GCDViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/23.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_31GCDViewController.h"
#import <os/lock.h>
@interface LockPerson : NSObject{
    NSString *_name;
    dispatch_queue_t _queue;
    
    dispatch_queue_t _concurrentQueue;
}
@property (nonatomic, copy) NSString *name;
@end

@implementation LockPerson

-(void)setName:(NSString *)name {
    _name = [name copy];
}
-(NSString *)name {
    return _name;
}

//-(void)setName:(NSString *)name {
//   @synchronized(self) {
//       _name = [name copy];
//   }
//}
//-(NSString *)name {
//   @synchronized(self) {
//       return _name;
//   }
//}

-(instancetype)init {
    if (self = [super init]) {
        _queue = dispatch_queue_create("com.person.syncQueue", DISPATCH_QUEUE_SERIAL);
        _concurrentQueue = dispatch_queue_create("com.person.syncQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}
//-(void)setName:(NSString *)name {
//   dispatch_sync(_queue, ^{
//       _name = [name copy];
//   });
//}
//-(NSString *)name {
//   __block NSString *tempName;
//   dispatch_sync(_queue, ^{
//       tempName = _name;
//   });
//   return tempName;
//}


//-(void)setName:(NSString *)name {
//    __block NSString *__name = _name;
//   dispatch_barrier_async(_concurrentQueue, ^{
//       __name = [name copy];
//   });
//}
//-(NSString *)name {
//   __block NSString *tempName;
//   dispatch_sync(_concurrentQueue, ^{
//       tempName = _name;
//   });
//   return tempName;
//}

@end


@interface _31GCDViewController () {
    
    NSInteger _number;
}

//@property (atomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger number;
@property(nonatomic) dispatch_queue_t concurrentQueue;

@property (nonatomic, assign) NSInteger money;
@property (nonatomic ,assign) os_unfair_lock moneyLock;

// 声明剩余票数
@property (nonatomic, assign) NSInteger subTickets;
// 线程锁
@property (nonatomic, retain) NSLock *lock;


@end

@implementation _31GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多线程";
    
    [self _p13NSBlockOperation];
    [self _p14NSBlockOperation];
    [self _p15NSBlockOperation];
    [self _p16NSBlockOperation];
    [self _p17NSBlockOperation];
    
    // 这里放最后一个view的底部
    [self _lastLoadBottomAttribute];
}

//-(void)setName:(NSString *)name {
//    __block NSString *__name = _name;
//   dispatch_barrier_async(_concurrentQueue, ^{
//       __name = [name copy];
//   });
//}
//-(NSString *)name {
//   __block NSString *tempName;
//   dispatch_sync(_concurrentQueue, ^{
//       tempName = _name;
//   });
//   return tempName;
//}

//-(void)setNumber:(NSInteger)number {
//    __block NSInteger __num = _number;
//    dispatch_barrier_async(_concurrentQueue, ^{
//        __num = number;
//    });
//}
//
//- (NSInteger)number {
//    __block NSInteger tempName;
//    dispatch_sync(_concurrentQueue, ^{
//        tempName = _number;
//    });
//    return tempName;
//}

//-(void)setName:(NSString *)name {
//   @synchronized(self) {
//       _name = [name copy];
//   }
//}
//-(NSString *)name {
//   @synchronized(self) {
//       return _name;
//   }
//}

//- (void)setNumber:(NSInteger)number {
//    @synchronized(self) {
//        _number = number;
//    }
//}
//- (NSInteger)number {
//    @synchronized(self) {
//        return _number;
//    }
//}

- (void)setNumber:(NSInteger)number {
        _number = number;
}
- (NSInteger)number {
        return _number;
}
-(void)_p13NSBlockOperation {
    return [self _buttonTitle:@"存取钱" handler:^(UIButton * _Nonnull btn) {
        
        [self tickets];
    }];
    
}

#pragma mark ----------------买火车票线程锁实现-----------------------
// 买火车票线程锁实现
 
- (void)tickets
{
    
   // 剩余票
   self.subTickets = 10000;
   // 初始化线程锁
   self.lock = [[NSLock alloc] init];
 
     
   // 先创建出两个并行队列
   // 一个队列是火车站
   // 一个队列是12306
   dispatch_queue_t queue1 = dispatch_queue_create("火车站", DISPATCH_QUEUE_CONCURRENT);
   // 给火车站添加一个卖票的任务
    dispatch_async(queue1, ^{
        for (int i = 0; i < 10000; i ++) {
            // 卖票
            [self saleTickets:queue1];
        }
    });
    
   // 创建12306队列
   dispatch_queue_t queue2 = dispatch_queue_create("12306", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue2, ^{
        for (int i = 0; i < 20000; i ++) {
            // 卖票
            [self saleTickets:queue2];
        }
    });
}
 
// 卖票方法
- (void)saleTickets:(dispatch_queue_t)queue
{
    
        // 添加锁
        // 线程锁和自动释放池 使用方法差不多 中间的部分是锁的内容
        [self.lock lock];
   // 循环卖票
   if (self.subTickets > 0) {
         
       // 要知道是哪个队列来卖票
       // 通过队列的标示符 得到
       //dispatch_queue_get_label(queue)得到队列的标示符
       char  *name = (char *)dispatch_queue_get_label(queue);
       NSString *str = [NSString stringWithUTF8String:name];
       //来一回减少一张
       self.subTickets--;
       NSLog(@"%@ 还剩 %ld", str, self.subTickets);
   }else {
       NSLog(@"没有票了 %ld",self.subTickets);
   }
    
  //解锁
  [self.lock unlock];
}

-(void)_p14NSBlockOperation {
    return [self _buttonTitle:@"属性加锁" handler:^(UIButton * _Nonnull btn) {
        
        self.concurrentQueue = dispatch_queue_create("com.person.syncQueue", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        
        dispatch_async(queue, ^{
            for (int i = 0; i < 10000; i ++) {
                self.number = self.number + 1;
                NSLog(@"A-self.number is %ld",self.number);
            }
        });
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i < 10000; i ++) {
                self.number = self.number + 1;
                NSLog(@"B-self.number is %ld",self.number);
            }
        });
    }];
    
}
-(void)_p15NSBlockOperation {
    return [self _buttonTitle:@"NSBlockOperation" handler:^(UIButton * _Nonnull btn) {
        
        //2.NSBlockOperation(最常使用)
        NSBlockOperation * blockOp = [NSBlockOperation blockOperationWithBlock:^{
            //要执行的操作，目前是主线程
            //            NSLog(@"NSBlockOperation 创建，线程：%@",[NSThread currentThread]);
            
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
            }
            
        }];
        //2.1 追加任务，在子线程中执行
        [blockOp addExecutionBlock:^{
            NSLog(@"追加任务一, %@",[NSThread currentThread]);
            
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"追加任务一: %@", [NSThread currentThread]); // 打印当前线程
            }
        }];
        //        [blockOp addExecutionBlock:^{
        //            NSLog(@"追加任务二, %@",[NSThread currentThread]);
        //        }];
        [blockOp start];
        
    }];
}

-(void)_p16NSBlockOperation {
    return [self _buttonTitle:@"NSOperationQueue222" handler:^(UIButton * _Nonnull btn) {
        // 1.创建队列
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        // 2.使用 addOperationWithBlock: 添加操作到队列中
        [queue addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
        [queue addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
        [queue addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
        
    }];
}

-(void)_p17NSBlockOperation {
    return [self _buttonTitle:@"NSBlockOperation 依赖" handler:^(UIButton * _Nonnull btn) {
        //创建队列
        NSOperationQueue *queue=[[NSOperationQueue alloc] init];
        //创建操作
        NSBlockOperation *operation1=[NSBlockOperation blockOperationWithBlock:^(){
            NSLog(@"执行第11111次操作，线程：%@",[NSThread currentThread]);
        }];
        NSBlockOperation *operation2=[NSBlockOperation blockOperationWithBlock:^(){
            NSLog(@"执行第22222次操作，线程：%@",[NSThread currentThread]);
        }];
        NSBlockOperation *operation3=[NSBlockOperation blockOperationWithBlock:^(){
            NSLog(@"执行第33333次操作，线程：%@",[NSThread currentThread]);
        }];
        //添加依赖
        [operation1 addDependency:operation2];
        [operation2 addDependency:operation3];
        //将操作添加到队列中去
        [queue addOperation:operation1];
        [queue addOperation:operation2];
        [queue addOperation:operation3];
    }];
}

@end
