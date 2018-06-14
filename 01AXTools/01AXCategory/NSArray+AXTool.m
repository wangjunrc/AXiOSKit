//
//  NSArray+AXTool.m
//  
//
//  Created by liuweixing on 15/11/18.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "NSArray+AXTool.h"

@implementation NSArray (AXTool)

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

/**
 倒数 内容

 @param count 个数
 @return 内容
 */
-(NSArray *)ax_lastObjetCount:(NSInteger )count{
    
    if (count>self.count) {
        count = self.count;
    }
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.count-count, count)];
    
    NSArray *temp = [self objectsAtIndexes:set];
    //倒序
    temp = [[temp reverseObjectEnumerator] allObjects];
    return temp;
}



@end
