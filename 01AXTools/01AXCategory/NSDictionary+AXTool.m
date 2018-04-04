//
//  NSDictionary+AXTool.m
//  AXTools
//
//  Created by liuweixing on 2016/10/17.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSDictionary+AXTool.h"

@implementation NSDictionary (AXTool)
/**
 NSDictionary转换json字串
 */
-(NSString *)ax_toJson{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return  jsonStr;
}
@end
