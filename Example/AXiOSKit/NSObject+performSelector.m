//
//  NSObject+performSelector.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/26.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "NSObject+performSelector.h"

@implementation NSObject (performSelector)
/** 系统提供的perform系列方法参数个数有限,可以利用NSInvocation实现多参数 */

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    // 初始化方法签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    // 如果方法不存在
    if (!signature) {
        // 抛出异常
        NSString *reason = [NSString stringWithFormat:@"方法不存在 : %@",NSStringFromSelector(aSelector)];
        @throw [NSException exceptionWithName:@"error" reason:reason userInfo:nil];
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    // 参数个数signature.numberOfArguments 默认有一个_cmd 一个target 所以要-2
    NSInteger paramsCount = signature.numberOfArguments - 2;
    
    // 当objects的个数多于函数的参数的时候,取前面的参数
    // 当objects的个数少于函数的参数的时候,不需要设置,默认为nil
    paramsCount = MIN(paramsCount, objects.count);
    
    for (NSInteger index = 0; index < paramsCount; index++) {
        id object = objects[index];
        // 对参数为nil的处理
        if ([object isKindOfClass:[NSNull class]]) {
            continue;
        }
        [invocation setArgument:&object atIndex:index + 2];
    }
    
    // 调用方法
    [invocation invoke];
    
    //    // 获取返回值
    //    id  returnValue = nil;
    //    //signature.methodReturnLength == 0 说明给方法没有返回值
    //    if (signature.methodReturnLength) {
    //        //获取返回值
    //        [invocation getReturnValue:&returnValue];
    //    }
    //    return returnValue;
    
    // 获取返回值
    //       id __unsafe_unretained returnValue = nil;
    //       //signature.methodReturnLength == 0 说明给方法没有返回值
    //       if (signature.methodReturnLength) {
    //           //获取返回值
    //           [invocation getReturnValue:&returnValue];
    //       }
    //       id value = returnValue;
    // 需要做返回类型判断。比如返回值为常量需要包装成对象，这里仅以最简单的`@`为例
    id returnVal;
    if (strcmp(signature.methodReturnType, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
    //    BOOL returnValue;
    //     [invocation getReturnValue：& returnValue];
    return returnVal;
    
}

@end
