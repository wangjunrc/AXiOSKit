//
//  _06RealmVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/24.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_06RealmVC.h"
#import "RLMOrder.h"
#import "RLMOrderService.h"
#import "RLMProduct.h"
#import "RPDataBase.h"

@interface _06RealmVC ()

@end

@implementation _06RealmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    [self _buttonTitle:@"添加RLMOrder" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        [ self testSavaOrder:3];
    }];
    
    [self _buttonTitle:@"添加RLMOrder" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        RLMOrder *order = [RLMOrderService queryOrderWithOrderNumber:@"1"];
        NSLog(@"order=%@",order);
    }];
    
    
    [self _lastLoadBottomAttribute];
}


-(void)testSavaOrder:(NSInteger )orderCount {
    //1、1000订单存储，所有订单一个事务
    NSMutableArray *orders = [NSMutableArray array];
    for ( int i = 0 ; i<orderCount; i++) {
        RLMOrder *order = [[RLMOrder alloc]init];
        /// 主键
        order.orderNumber =[NSString stringWithFormat:@"%d",i];
        int count = (i % 3);
        order.orderStatus = count == 0 ? @"成功":@"待支付";
        int amount = 0;
        for ( int j = 1; j <= count + 1; j++) {
            RLMProduct *p = [[RLMProduct alloc]init];
            p.name = [NSString stringWithFormat:@"煎饼果子-%d-%d",i,j];
            int price = i*j;
            amount+= price;
            p.price = [NSString stringWithFormat:@"%@",@(price)];
            [order.orderItems addObject:p];
        }
        order.orderAmount = [NSString stringWithFormat:@"%@",@(amount)];
        [orders addObject:order];
    }
    BOOL success = [RLMOrderService saveOrders:orders];
    NSLog(@"realm插入数据=%@",success ? @"成功":@"失败");
}
@end
