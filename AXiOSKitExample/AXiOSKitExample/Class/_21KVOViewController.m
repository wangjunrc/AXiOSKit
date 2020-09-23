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
#import <KVOController/KVOController.h>



@interface _21KVOViewController ()


@property (strong,nonatomic)NSMutableArray *dataArray;


@property(nonatomic,strong)NSTimer *timer;

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
    
    
//    [self ax_addFBKVOKeyPath:@ax_keypath(self, dataArray) result:^(AXKVOResultModel * _Nonnull resultModel) {
//        NSLog(@"resultModel %@",self.dataArray);
//    }];
    
    __weak typeof(self) weakSelf = self;
    [self ax_addFBKVOKeyPath:AX_FBKVOKeyPath(self.dataArray) result:^(AXKVOResultModel * _Nonnull resultModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"resultModel %@",strongSelf.dataArray);
    }];
//
    
//    [self.KVOControllerNonRetaining observe:self keyPath:AX_FBKVOKeyPath(self.dataArray) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
//
//        NSLog(@"resultModel %@",self.dataArray);
//    }];
    
    
    
//    [self ax_addFBKVOKeyPath:AX_FBKVOClassKeyPath(_21KVOViewController,dataArray) result:^(AXKVOResultModel * _Nonnull resultModel) {
//        NSLog(@"resultModel %@",self.dataArray);
//    }];
    
    
}


- (IBAction)add1:(id)sender {
    
    
    [self.dataArray addObject:@"2"];
    self.dataArray = [NSMutableArray arrayWithArray:self.dataArray];
}
- (IBAction)add2:(id)sender {
    
}
- (IBAction)add3:(id)sender {
    
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
