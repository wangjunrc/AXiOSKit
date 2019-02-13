//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "ABViewController.h"
#import "AXiOSTools.h"
#import <StoreKit/StoreKit.h>
#import "UITextField+AXNumberKeyboard.h"
#import <Masonry/Masonry.h>
@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    ABViewController *vc = [[ABViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//    vc.loadHTMLFilePath = [[NSBundle  mainBundle]pathForResource:@"HTML/home.html" ofType:nil];
//
//    [vc setMethodCallHandler:^(NSString *call, void (^FlutterResult)(id  _Nullable result)) {
//        FlutterResult(@"B");
//    }];
    
//  NSArray *arrary = @[@{@"id":@(88),@"userName":@"jim444"},@{@"id":@(89),@"userName":@"jim333"}];
//    [AXNetManager postURL:@"http://10.24.7.57:8080/updateList.do" parameters:arrary success:^(id json) {
//        NSLog(@"%@",json);
//    } failure:^(NSError *error) {
//         NSLog(@"%@",error.localizedDescription);
//    }];
//
    
//    [AXNetManager postURL:@"http://localhost:8080/getIpLog.do" parameters:@{@"id":@(88)} success:^(id json) {
//        NSLog(@"%@",json);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error.localizedDescription);
//    }];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
NSArray *arrary = @[@{@"id":@(88),@"userName":@"jim"},@{@"id":@(89),@"userName":@"jim"}];
    NSDictionary *dict =@{@"name":@"tom123",@"list":arrary};
    
    [manager POST:@"http://localhost:8080/updateList2.do" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
//        id json  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
     NSLog(@"%@",responseObject);
    
        NSLog(@"%@",[[responseObject class]description]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error.localizedDescription);
    }];

    
    
}


@end
