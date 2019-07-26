//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import "AAViewController.h"
#import "AXPayVC.h"
#import "AXDateVC.h"
#import "FBLPromises.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property(nonatomic,strong)CAEmitterLayer *rainLayer;
@property(nonatomic, strong)CALayer *moveLayer;
@property(nonatomic, strong)NSTimer  *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
}

- (IBAction)btnAction1:(id)sender {
    
    [self testAllAndAny];
}

- (void)testAllAndAny {
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:[self work1]];
    [arr addObject:[self work2]];
    
    //All是所有Promise都成功 fulfill才算完成；
    [[[FBLPromise all:arr] then:^id _Nullable(NSArray * _Nullable value) {
        NSLog(@"then, value:%@", value);
        return value;
    }] catch:^(NSError * _Nonnull error) {
        NSLog(@"all error:%@", error);
    }];
    
    //Any是任何一个Promise成功 完成都会执行fulfill；
//    [[[FBLPromise any:arr] then:^id _Nullable(NSArray * _Nullable value) {
//        NSLog(@"then, value:%@", value);
//        return value;
//    }] catch:^(NSError * _Nonnull error) {
//        NSLog(@"any error:%@", error);
//    }];
}

- (FBLPromise<NSString *> *)work1 {
//    return [FBLPromise do:^id _Nullable{
//        BOOL success = arc4random() % 2;
//        return success ? @"work1>> work1 success" : [NSError errorWithDomain:@"work1_error" code:-1 userInfo:nil];
//    }];
//
    return  [FBLPromise onQueue:dispatch_get_main_queue()
                          async:^(FBLPromiseFulfillBlock fulfill,
                                  FBLPromiseRejectBlock reject) {
                              
                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                  BOOL success = arc4random() % 2;
                                  if (success) {
                                      fulfill(@"work1>>> success");
                                  }
                                  else {
                                      reject([NSError errorWithDomain:@"work1_error" code:-1 userInfo:nil]);
                                  }
                              });
                              
                          }];
}

- (FBLPromise<NSString *> *)work2 {
    
//  return  [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
//
//      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//          BOOL success = arc4random() % 2;
//
//          if (success) {
//              fulfill(@"work2>>> success");
//          }
//          else {
//              reject([NSError errorWithDomain:@"work2_error" code:-1 userInfo:nil]);
//          }
//      });
//
//    }];
  return  [FBLPromise onQueue:dispatch_get_main_queue()
                  async:^(FBLPromiseFulfillBlock fulfill,
                          FBLPromiseRejectBlock reject) {

                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          BOOL success = arc4random() % 2;
                          if (success) {
                             fulfill(@"work2>>> success");
                          }
                          else {
                              reject([NSError errorWithDomain:@"work2_error" code:-1 userInfo:nil]);
                          }
                      });

                  }];
}
@end
