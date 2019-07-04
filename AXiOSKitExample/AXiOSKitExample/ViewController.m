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
#import <AXiOSKit/NSData+AXKit.h>
#import "AXMultiSelectViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (IBAction)btnAction1:(id)sender {
     [self test];
    
//  @try {
//    // 可能会出现崩溃的代码
//    [self test];
//  } @catch (NSException* exception) {
//    // 捕获到的异常exception
//    NSLog(@"exception>> %@", exception);
//  } @finally {
//    // 结果处理
//    NSLog(@"结果处理");
//  }
}

- (void)test {
  @throw [NSException exceptionWithName:@"error"
                                 reason:@"预览对象不能为空"
                               userInfo:nil];
}

@end
