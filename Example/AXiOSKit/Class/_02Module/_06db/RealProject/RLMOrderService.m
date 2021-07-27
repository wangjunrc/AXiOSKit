//
//  RLMOrderService.m
//  RealmDemo
//
//  Created by xiongan on 2017/7/28.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import "RLMOrderService.h"
#if __has_include(<Realm/Realm.h>)
#import "RPDataBase.h"

@implementation RLMOrderService

+ (BOOL)saveOrder:(RLMOrder *)order {
    RPDataBase *db = [RPDataBase db];
    NSError *err;
    [db beginWriteTransaction];
    [db addObject:order];
    [db commitWriteTransaction:&err];
    return err == nil;
    
}
+ (BOOL)saveOrders:(NSArray *)orders {
    RPDataBase *db = [RPDataBase db];
    NSError *err;
    [db beginWriteTransaction];
    [db addObjects:orders];
    [db commitWriteTransaction:&err];
    if (err) {
        NSLog(@"realm插入数据失败=%@",err);
    }else{
        NSLog(@"realm插入数据成功");
    }
    return err == nil;
}
+ (RLMOrder *)queryOrderWithOrderNumber:(NSString *)orderNumber {
    if (orderNumber.length <= 0) {
        return nil;
    }
    RPDataBase *db = [RPDataBase db];
    return [RLMOrder objectInRealm:db forPrimaryKey:orderNumber];
}

+ (RLMOrder *)queryOrderWhere:(NSString *)where {
    RPDataBase *db = [RPDataBase db];
    return [[RLMOrder objectsInRealm:db where:where] firstObject];

}
@end
#endif
