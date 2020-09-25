//
//  NSObject+MethodSwizzling.h
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/3/3.
//  Copyright © 2020 liu.weixing. All rights reserved.
//




#import <Foundation/Foundation.h>


@interface NSObject (MethodSwizzling)

/** 交换两个类方法的实现
 * @param originalSelector  原始方法的 SEL
 * @param swizzledSelector  交换方法的 SEL
 * @param targetClass  类
 */
+ (void)yscDefenderSwizzlingClassMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass;

/** 交换两个对象方法的实现
 * @param originalSelector  原始方法的 SEL
 * @param swizzledSelector 交换方法的 SEL
 * @param targetClass  类
 */
+ (void)yscDefenderSwizzlingInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass;

@end
