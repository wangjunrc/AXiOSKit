//
//  _21KVOViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/23.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_21KVOViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
//#import <KVOController/KVOController.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <AXCollectionObserve/AXCollectionObserve.h>
@interface _21KVOViewController ()


@property (strong,nonatomic)NSMutableArray *dataArray;


@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic, strong) RACTuple * tuple;

@property(nonatomic, assign) NSInteger age;

@end

@implementation _21KVOViewController


- (void)addTimer {
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer {
    NSLog(@"%s",__func__);
}




- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addTimer];
    
//    self.tuple = [RACTuple tupleWithObjects:@"2", nil];;
    
//    self.tuple =  [RACTuple tupleWithObjectsFromArray:self.dataArray];
//    [self ax_addFBKVOKeyPath:@ax_keypath(self, dataArray) result:^(AXKVOResultModel * _Nonnull resultModel) {
//        NSLog(@"resultModel %@",self.dataArray);
//    }];
    
//    __weak typeof(self) weakSelf = self;
//    [self ax_addFBKVOKeyPath:AX_FBKVOKeyPath(self.dataArray) result:^(AXKVOResultModel * _Nonnull resultModel) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        NSLog(@"resultModel %@",strongSelf.dataArray);
//    }];
////
    
//    [self.KVOControllerNonRetaining observe:self keyPath:AX_FBKVOKeyPath(self.dataArray) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
//
//        NSLog(@"resultModel %@",self.dataArray);
//    }];
    
    
    
//    [self ax_addFBKVOKeyPath:AX_FBKVOClassKeyPath(_21KVOViewController,dataArray) result:^(AXKVOResultModel * _Nonnull resultModel) {
//        NSLog(@"resultModel %@",self.dataArray);
//    }];
    
//    [RACObserve(self.dataArray, count) subscribeNext:^(id x) {
//    NSLog(@"RACObserve = %@", x);
//    }];
    
//        [RACObserve(self, count1) subscribeNext:^(id x) {
//        NSLog(@"RACObserve = %@", x);
//        }];
//
//
//    [RACObserve(self, tuple) subscribeNext:^(id x) {
//    NSLog(@"RACObserve tuple = %@", x);
//    }];
//
//    [RACObserve(self, age) subscribeNext:^(id  _Nullable x) {
//
//        NSLog(@"KVO 监听到 age 内容发生变化 ，变为 %@ , thread = %@",x,[NSThread currentThread]);
//      }];

    
    // 我们来看能不能监听到这个方法调用
//    @weakify(self);
//      [[self.dataArray rac_signalForSelector:@selector(addObject:)] subscribeNext:^(id  _Nullable x) {
//          @strongify(self);
//          NSLog(@"方法调用 %@",self.dataArray);
//      }];
//
//    [[self.dataArray rac_signalForSelector:@selector(insertObject: atIndex:)] subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        NSLog(@"方法调用insertObject %@",self.dataArray);
//    }];
//
//    [[self.dataArray rac_signalForSelector:@selector(insertObject: atIndex:)] subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        NSLog(@"方法调用insertObject %@",self.dataArray);
//    }];
//
//    [[self.dataArray rac_signalForSelector:@selector(replaceObjectAtIndex: withObject: )] subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        NSLog(@"方法调用insertObject %@",self.dataArray);
//    }];
//
//    [[self.dataArray rac_signalForSelector:@selector(setObject:atIndexedSubscript: )] subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        NSLog(@"方法调用setObject %@",self.dataArray);
//    }];
    @weakify(self);
    [self.dataArray ax_valueChangeObserve:^(NSMutableArray * _Nonnull array) {
        @strongify(self);
        NSLog(@"方法调用setObject=AA %@",self.dataArray);
        NSLog(@"方法调用setObject-array %@",array);
    }];
    
    
//    [[self rac_valuesForKeyPath:@"dataArray" observer:self] subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        NSLog(@"方法调用 %@",self.dataArray);
//    }];

}

-(NSInteger )count1 {
    return  self.dataArray.count;
}
- (IBAction)add1:(id)sender {
    
    
    [self.dataArray addObject:@"2"];
//    self.dataArray[0] = @"3";
   
//    self.dataArray = [NSMutableArray arrayWithArray:self.dataArray];
}
- (IBAction)add2:(id)sender {
//    [self.tuple tupleByAddingObject:@"3"];
    
//    [self.dataArray replaceObjectAtIndex:0 withObject:@"3"];
    self.dataArray[0] = @"3";
       
}
- (IBAction)add3:(id)sender {
//    self.age++;
    [self.dataArray removeLastObject];
}


-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)dealloc {
    axLong_dealloc;
}
@end
