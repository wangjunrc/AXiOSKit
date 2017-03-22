//
//  NSObject+AXTool.h
//  AXTools
//
//  Created by Mole Developer on 16/4/6.
//  Copyright © 2016年 mole. All rights reserved.
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
 * 用自己的方法替换系统的方法
 */
+ (void)ax_swizzlingWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
