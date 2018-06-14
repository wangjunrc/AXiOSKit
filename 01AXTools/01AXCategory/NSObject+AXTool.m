//
//  NSObject+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSObject+AXTool.h"
#import "AXMacros_runTime.h"

@interface NSObject ()


@end

@implementation NSObject (AXTool)

/**
 NSObject转换json字串
 */
-(NSString *)ax_toJson{
    
    if ([self isKindOfClass:[NSString class]]) {
        
        return (NSString *)self;
        
    } else if ([self isKindOfClass:[NSData class]]) {
        
        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return  jsonStr;
}


/**
 封装 alloc]init]
 */
+(instancetype)ax_init{
    return [[self alloc]init];
}

/**
 传值
 使用协议必须实现,不好用,使用属性,重写set无值,所以用方法
 
 @param value 值
 */
-(void)ax_setValue:(id)value{
    
}

#pragma mark - set and get


- (void)setAx_pageIndex:(NSInteger)ax_pageIndex{
     ax_runtimePropertyAssSet(ax_pageIndex);
}

- (NSInteger)ax_pageIndex{
     return [ax_runtimePropertyAssGet(ax_pageIndex)integerValue];
}


- (void)setAx_backBlock:(AX_backBlock)ax_backBlock{
    ax_runtimePropertyObjSet(ax_backBlock);
}

- (AX_backBlock)ax_backBlock{
    return ax_runtimePropertyObjGet(ax_backBlock);
}

- (void)setAx_byValue:(id)ax_byValue{
    ax_runtimePropertyObjSet(ax_byValue);
}

- (id)ax_byValue{
    return ax_runtimePropertyObjGet(ax_byValue);
}



@end
