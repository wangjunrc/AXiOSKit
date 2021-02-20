//
//  _09AFNViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/7/6.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_09AFNViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/AXNetworkManager.h>
#import <AFNetworking/AFNetworking.h>
@interface _09AFNViewController ()

@end

@implementation _09AFNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网络请求";
    
    [self _p00ButtonTitle:@"请求1" handler:^(UIButton * _Nonnull btn) {
        NSDictionary *dict = @{@"name":@"jim",@"age":@1};
        
        AXNetworkManager.manager.post(@"http://localhost:8080/test22").parameters(dict).success(^(id  _Nonnull JSONObject) {
            NSLog(@"JSONObject2 = %@",JSONObject);
            
        }).failure(^(NSError * _Nonnull error) {
            NSLog(@"error2 = %@",error.description);
        }).start();
    }];
    
    
    [self _p00ButtonTitle:@"请求2" handler:^(UIButton * _Nonnull btn) {
        NSDictionary *dict = @{@"name":@"jim",@"age":@1};
        
        AXNetworkManager.manager.get(@"http://localhost:8080/test21").parameters(dict).success(^(id  _Nonnull JSONObject) {
            NSLog(@"JSONObject2 = %@",JSONObject);
            
        }).failure(^(NSError * _Nonnull error) {
            NSLog(@"error2 = %@",error.description);
        }).start();
    }];
    
    [self _p00ButtonTitle:@"请求3" handler:^(UIButton * _Nonnull btn) {
        NSDictionary *dict = @{@"name":@"jim",@"age":@1};
        
        AXNetworkManager.manager.post(@"http://localhost:8080/test2").headers(@{@"token":@"token1111111111111",@"id":@"id222222222222222"}).parameters(dict).success(^(id  _Nonnull JSONObject) {
            NSLog(@"JSONObject2 = %@",JSONObject);
            
        }).failure(^(NSError * _Nonnull error) {
            NSLog(@"error2 = %@",error.description);
        }).start();
    }];
    
    
    [self _p00ButtonTitle:@"请求ax.com" handler:^(UIButton * _Nonnull btn) {
        NSDictionary *dict = @{@"name":@"jim",@"age":@1};
        AXNetworkManager.manager.post(@"http://www.ax.com").headers(@{@"token":@"token1111111111111",@"id":@"id222222222222222"}).parameters(dict).success(^(id  _Nonnull JSONObject) {
            NSLog(@"JSONObject2 = %@",JSONObject);

        }).failure(^(NSError * _Nonnull error) {
            NSLog(@"error2 = %@",error.description);
        }).start();
        
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager GET:@"http://www.ax.com" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable
//        responseObject) {
//            NSArray *data = responseObject;
//            NSLog(@"%@", data);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@", error);
//        }];

    }];
    
    
    
    // 这里放最后一个view的底部
    [self _loadBottomAttribute];
}


@end
