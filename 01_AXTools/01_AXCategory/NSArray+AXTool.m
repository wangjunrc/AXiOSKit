//
//  NSArray+AXTool.m
//  Financing118
//
//  Created by Mole Developer on 15/11/18.
//  Copyright © 2015年 MoleDeveloper. All rights reserved.
//

#import "NSArray+AXTool.h"

@implementation NSArray (AXTool)

/**
  NSArray转换json字串
 */
-(NSString *)ax_toJson{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return  jsonStr;
}

@end
