//
//  NSObject+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (AXTool)
/**
 *  得到一个类所有属性
 */
+ (NSArray *)ax_getProperties;

/**
 *  获得实例对象的属性及属性值
 *
 *  @return 字典
 */
- (NSDictionary *)ax_getProperties_aps;

/**
 * 把另外对象的属性值,赋值给自己
 */
-(void)ax_getValueFromObj:(NSObject *)otherObj;


/**
 * 更换方法
 */
+ (void)ax_replaceMethodWithOriginal:(SEL)originalSEL newSelector:(SEL)newSEL;


@end
