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


/**
 * 0-9 a-z A-Z 集合
 */
+(NSArray *)ax_numbernAndAlphabet{
    
    NSMutableArray *temp = [NSMutableArray array];
    
    //0-9
    for(int index=48; index<=57; index++) {
        unichar ch =index;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        [temp addObject:str];
    }
    
    
    //小写字母
    for(int index=97; index<=122; index++) {
        unichar ch =index;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        [temp addObject:str];
    }
    
    //大写字母
    for(int index=65; index<=90; index++) {
        unichar ch =index;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        [temp addObject:str];
    }
    
    return temp.copy;
    
}

@end
