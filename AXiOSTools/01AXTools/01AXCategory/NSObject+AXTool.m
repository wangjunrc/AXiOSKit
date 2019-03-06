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
 Foundation NSObject转换json字串
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
 json字串 转换 Foundation NSObject
 */
- (id)ax_toJSONObject {
    
    if ([self isKindOfClass:[NSString class]]) {
        
        NSData *data = [((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding];
        return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    } else if ([self isKindOfClass:[NSData class]]) {
        
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    return self;
}

/**
 Foundation NSObject转换data
 */
- (NSData *)ax_toData {
    
    if ([self isKindOfClass:[NSString class]]) {
        
       return [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
        
    } else if ([self isKindOfClass:[NSData class]]) {
        return (NSData *)self;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    
    return  data;
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


/**
 代码旋转屏幕

 @param orientation 屏幕方向
 */
-(void)ax_revolveOrientation:(UIInterfaceOrientation )orientation {
    
    //kvc方法
    //    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    //
    //    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    //
    //    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    //
    //    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    //
    
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        
        [invocation setSelector:selector];
        
        [invocation setTarget:[UIDevice currentDevice]];
        
        UIInterfaceOrientation val = orientation;
        /**
         第一个参数需要接收一个指针，也就是传递值的时候需要传递地址
         
         第二个参数：需要给指定方法的第几个参数传值
         
         注意：设置参数的索引时不能从0开始，因为0已经被self(target)占用，1已经被_cmd(selector)占用在NSInvocation的官方文档中已经说明
         
         (_cmd在Objective-C的方法中表示当前方法的selector，正如同self表示当前方法调用的对象实例。
         */
        [invocation setArgument:&val atIndex:2];
        
        [invocation invoke];
        
        
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
