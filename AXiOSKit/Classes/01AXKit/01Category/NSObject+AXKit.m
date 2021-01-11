//
//  NSObject+AXKit.m
//  AXiOSKit
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSObject+AXKit.h"

#import "AXMacros_addProperty.h"
#import <UIKit/UIKit.h>

@interface NSObject ()

@end

@implementation NSObject (AXKit)

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
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    } else if ([self isKindOfClass:[NSData class]]) {
        
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:NSJSONReadingMutableContainers error:nil];
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



#pragma mark -  setValue nil 保护

- (void)ax_safe_setNilValueForKey:(NSString *)key {
    // 获取是否有set方法
    Method method = [self hc_getMethodByKey:key];
    const char *typeEncoding = NULL;
    if (method != nil) {
        typeEncoding = method_copyArgumentType(method, 2); // 获取参数的encoding信息，method有2个缺省参数 self _cmd 所以这里是2
    } else if ([self.class accessInstanceVariablesDirectly]) {
        // 获取ivar
        Ivar ivar = [self hc_getIvarByKey:key];
        if (ivar != nil) {
            typeEncoding = ivar_getTypeEncoding(ivar);
        }
    }
    if (typeEncoding == NULL) {
        [self ax_safe_setNilValueForKey:key];
        return;
    }
    // 遍历出所有的number、value类型的encoding，针对性的处理
    // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
    /*
     Printing description of typeEncoding:
     (const char *) typeEncoding = 0x000000010f4c5c7a "{_NSRange=\"location\"Q\"length\"Q}"
     (lldb) po @encode(NSRange)
     "{_NSRange=QQ}"
     */
    switch (typeEncoding[0]) {
            // NSNumber scalar type
        case 'q': // longlong
        case 'Q': // unsigned longlong
        case 'i': // int
        case 'I': // unsigned int
        case 'l': // long
        case 'L': // unsigned long
        case 's': // short
        case 'S': // unsigned short
        case 'd': // double
        case 'f': // float
            [self setValue:@(0) forKey:key];
            break;
        case '{': {
            char* idx = index(typeEncoding, '='); // 获取'='字符串中第一个出现的参数'=' 地址，然后将该字符出现的地址返回
            /*
             eg："0x000000010bac7c7a {_NSRange=\"location\"Q\"length\"Q}" idx则为 0x000000010bac7c83 "=\"location\"Q\"length\"Q}"
             
             Printing description of idx:
             (char *) idx = 0x000000010bac7c83 "=\"location\"Q\"length\"Q}"
             Printing description of typeEncoding:
             (const char *) typeEncoding = 0x000000010bac7c7a "{_NSRange=\"location\"Q\"length\"Q}"
             */
            if (idx == NULL) { // 如果为空则表示没有找到'='，此时走远来的流程
                [self ax_safe_setNilValueForKey:key];
            }
            // 处理NSValue的一些场景：比如NSRange、CGRect、CGPoint、CGSize；也就是NSValue structure type
            /*
             int strncmp(const char *str1, const char *str2, size_t n) 把 str1 和 str2 进行比较，最多比较前 n 个字节
             如果返回值 < 0，则表示 str1 小于 str2。
             如果返回值 > 0，则表示 str2 小于 str1。
             如果返回值 = 0，则表示 str1 等于 str2。
             */
            NSValue *value;
            long cmpLength = idx - typeEncoding;
#define SAME_ENCODE(name) (strncmp(typeEncoding, @encode(name), cmpLength) == 0)
            if (SAME_ENCODE(NSRange)) {
                value = [NSValue valueWithRange:NSMakeRange(0, 0)];
            } else if (SAME_ENCODE(CGPoint)) {
                value = [NSValue valueWithCGPoint:CGPointZero];
            } else if (SAME_ENCODE(CGSize)) {
                value = [NSValue valueWithCGSize:CGSizeZero];
            } else if (SAME_ENCODE(CGRect)) {
                value = [NSValue valueWithCGRect:CGRectZero];
            } else if (SAME_ENCODE(CGVector)) {
                value = [NSValue valueWithCGVector:CGVectorMake(0, 0)];
            } else if (SAME_ENCODE(UIEdgeInsets)) {
                value = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
            } else if (SAME_ENCODE(UIOffset)) {
                value = [NSValue valueWithUIOffset:UIOffsetZero];
            } else if (SAME_ENCODE(CGAffineTransform)) {
                value = [NSValue valueWithCGAffineTransform:CGAffineTransformIdentity];
            }
#ifndef FOUNDATION_HAS_DIRECTIONAL_GEOMETRY
            else if (@available(iOS 11.0, *)) {
                if (SAME_ENCODE(NSDirectionalEdgeInsets)) {
                    value = [NSValue valueWithDirectionalEdgeInsets:NSDirectionalEdgeInsetsZero];
                }
            } else {
                // Fallback on earlier versions
            }
#endif
            if (value != nil) {
                [self setValue:value forKey:key];
            } else {
                [self ax_safe_setNilValueForKey:key];
            }
        }
            break;
        default:
            [self ax_safe_setNilValueForKey:key];
            break;
    }
}

- (nullable Ivar)hc_getIvarByKey:(NSString *)key {
    if (![key isKindOfClass:[NSString class]] || key.length <= 0) {
        return nil;
    }
    // 按照_key _isKey key isKey的方式去获取ivar
    NSString *firstCharacter = [key substringToIndex:1];
    NSString *upperFirstKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.uppercaseString];
    
    NSString *_keyName = [NSString stringWithFormat:@"_%@", key];
    NSString *_isKeyName = [NSString stringWithFormat:@"_is%@", upperFirstKey];
    NSString *keyName = key;
    NSString *isKeyName = [NSString stringWithFormat:@"is%@", upperFirstKey];
    Ivar ivar;
    if ((ivar = [self hc_getIvarByIvarName:_keyName])
        || (ivar = [self hc_getIvarByIvarName:_isKeyName])
        || (ivar = [self hc_getIvarByIvarName:keyName])
        || (ivar = [self hc_getIvarByIvarName:isKeyName])) {
        return ivar;
    }
    return nil;
}

- (nullable Ivar)hc_getIvarByIvarName:(NSString *)ivarNameString {
    const char *ivarName = [ivarNameString cStringUsingEncoding:NSUTF8StringEncoding];
    Ivar ivar = class_getInstanceVariable(self.class, ivarName);
    return ivar;
}

- (nullable Method)hc_getMethodByKey:(NSString *)key {
    if (![key isKindOfClass:[NSString class]] || key.length <= 0) {
        return nil;
    }
    NSString *firstCharacter = [key substringToIndex:1];
    NSString *upperFirstKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.uppercaseString];
    NSString *setKeyName = [NSString stringWithFormat:@"set%@:", upperFirstKey];
    NSString *_setKeyName = [NSString stringWithFormat:@"_set%@:", upperFirstKey];
    NSString *setIsKeyName = [NSString stringWithFormat:@"setIs%@:", upperFirstKey];
    Method method;
#define METHOD_BY_NAME(selName) class_getInstanceMethod(self.class, NSSelectorFromString(selName))
    if ((method = METHOD_BY_NAME(setKeyName))
        || (method = METHOD_BY_NAME(_setKeyName))
        || (method = METHOD_BY_NAME(setIsKeyName))) {
        return method;
    }
    return nil;
}

@end
