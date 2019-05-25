//
//  NSObject+AXRuntime.h
//  AXiOSKitDemo
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 AX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AXRuntime)

/**
 *  得到一个类所有属性名
 * class_copyPropertyList返回的仅仅是对象类的属性(@property申明的属性)
 *  @return 数组
 */
+ (NSArray *)ax_getPropertiesName;

/**
 得到一个类所有属性名 和 类型
 
 @return NSArray
 */
+ (NSArray *)ax_getPropertiesNameAndType;

/**
 *  获得实例对象的属性及属性值
 *
 *  @return 字典
 */
- (NSDictionary *)ax_getPropertiesNameAndValue;

/**
 * 把另外对象的属性值,赋值给自己
 */
- (void)ax_getValueFromObj:(NSObject *)otherObj;

/**
 *  替换 实例 方法 Instance
 * 如 newSEL 方法内调用 [self newSEL] 会重新父方法 即执行originalSEL
 */
+ (void)ax_replaceInstanceMethodWithOriginal:(SEL)originalSEL
                                 newSelector:(SEL)newSEL;

/**
 * 更换 类 方法
 * 如 newSEL 方法内调用 [self newSEL] 会重新父方法 即执行originalSEL
 */
+ (void)ax_replaceClassMethodWithOriginal:(SEL)originalSEL
                              newSelector:(SEL)newSEL;

@end
