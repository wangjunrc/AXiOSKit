//
//  NSObject+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void(^AX_backBlock)(id obj);


@interface NSObject (AXTool)

/**
 NSObject转换json字串
 */
-(NSString *)ax_toJson;

/**
 封装 alloc]init]
 */
+(instancetype)ax_init;

/**
 回调block
 */
@property (nonatomic, copy)AX_backBlock ax_backBlock;


/**
 * pageIndex
 */
@property(nonatomic, assign)NSInteger ax_pageIndex;

/**
 传值
 使用协议必须实现,不好用,使用属性,重写set无值,所以用方法
 
 @param value 值
 */
-(void)ax_setValue:(id)value;

@end
