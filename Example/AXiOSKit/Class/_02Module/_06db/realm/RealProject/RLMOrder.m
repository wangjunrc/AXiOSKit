//
//  RLMOrder.m
//  RealmDemo
//
//  Created by xiongan on 2017/7/28.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import "RLMOrder.h"

#if __has_include(<Realm/Realm.h>)
@implementation RLMOrder

+(NSString *)primaryKey {
    return @"orderNumber";
}
@end
#endif
