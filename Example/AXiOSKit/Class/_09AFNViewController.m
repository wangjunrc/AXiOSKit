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
    
    UIButton *btn1 = [[UIButton alloc]init];
    [self.view addSubview:btn1];
    btn1.frame = CGRectMake(0, 0, 100, 50);
    btn1.backgroundColor = UIColor.blueColor;
    [btn1 ax_setTitleStateNormal:@"请求1"];
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        
        NSDictionary *dict = @{@"name":@"jim",@"age":@1};
        
        AXNetworkManager.manager.post(@"http://localhost:8080/test22").parameters(dict).success(^(id  _Nonnull JSONObject) {
            NSLog(@"JSONObject2 = %@",JSONObject);
            
        }).failure(^(NSError * _Nonnull error) {
            NSLog(@"error2 = %@",error.description);
        }).start();
        
    }];
    
    
    UIButton *btn2 = [[UIButton alloc]init];
    [self.view addSubview:btn2];
    btn2.frame = CGRectMake(0, 0, 100, 50);
    btn2.backgroundColor = UIColor.blueColor;
    [btn2 ax_setTitleStateNormal:@"请求2"];
    btn2.ax_top = btn1.ax_bottom+10;
    btn2.ax_left = btn1.ax_left;
    [btn2 ax_addTargetBlock:^(UIButton * _Nullable button) {
        
        NSDictionary *dict = @{@"name":@"jim",@"age":@1};
        
        AXNetworkManager.manager.get(@"http://localhost:8080/test21").parameters(dict).success(^(id  _Nonnull JSONObject) {
            NSLog(@"JSONObject2 = %@",JSONObject);
            
        }).failure(^(NSError * _Nonnull error) {
            NSLog(@"error2 = %@",error.description);
        }).start();
        
        
    }];
    
    UIButton *btn3 = [[UIButton alloc]init];
    [self.view addSubview:btn3];
    btn3.frame = CGRectMake(0, 0, 100, 50);
    btn3.backgroundColor = UIColor.blueColor;
    [btn3 ax_setTitleStateNormal:@"请求3"];
    btn3.ax_top = btn2.ax_bottom+10;
    btn3.ax_left = btn2.ax_left;
    [btn3 ax_addTargetBlock:^(UIButton * _Nullable button) {
        
        NSDictionary *dict = @{@"name":@"jim",@"age":@1};
        
        AXNetworkManager.manager.post(@"http://localhost:8080/test2").headers(@{@"token":@"token1111111111111",@"id":@"id222222222222222"}).parameters(dict).success(^(id  _Nonnull JSONObject) {
            NSLog(@"JSONObject2 = %@",JSONObject);
            
        }).failure(^(NSError * _Nonnull error) {
            NSLog(@"error2 = %@",error.description);
        }).start();
        
        
    }];
    
}


-(void)_putFile{

}
@end
