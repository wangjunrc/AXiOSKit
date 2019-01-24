//
//  NSObject+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSObject+AXTool.h"
#import "AXMacros_runTime.h"
#import "AXMacros_addProperty.h"
#import <UIKit/UIKit.h>

@interface NSObject ()

@end

@implementation NSObject (AXTool)

/**
 NSObject转换json字串
 */
- (NSString *)ax_toJSONString{
    
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
 json字串 转换 NSObject
 */
- (id)ax_JSONObject {
    
    if ([self isKindOfClass:[NSString class]]) {
        return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    } else if ([self isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    return self;
}

/**
 封装 alloc]init]
 */
+ (instancetype)ax_init{
    return [[self alloc]init];
}

/**
 传值
 使用协议必须实现,不好用,使用属性,重写set无值,所以用方法
 
 @param value 值
 */
- (void)ax_setValue:(id)value{
    
}

/**
 是否 DEBUG 模式
 YES ->DEBUG
 NO-> release
 
 @return 结果
 */
+ (BOOL)isDebug{
    
#ifdef DEBUG
    
    return YES;
#else
    return NO;
#endif
    
}

/**
 是否 iPad
 YES ->iPad
 NO-> iPhone
 @return 结果
 */
+ (BOOL)isiPad{
    
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
        return YES;
        
    }else{
        return NO;
    }
    
}
    
#pragma mark - set and get


//- (void)setAx_pageIndex:(NSInteger)ax_pageIndex{
//    ax_setAssignPropertyAssociated(ax_pageIndex);
//}
//
//- (NSInteger)ax_pageIndex{
//    return [ax_getValueAssociated(ax_pageIndex)integerValue];
//}


//- (void)setAx_backBlock:(AX_backBlock)ax_backBlock{
//    ax_setCopyPropertyAssociated(ax_backBlock);
//    
//    
//}
//- (AX_backBlock)ax_backBlock{
//    return ax_getValueAssociated(ax_backBlock);
//}


@end
