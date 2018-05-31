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

@property (nonatomic, copy)AX_backBlock ax_backBlock;

/**
 * AFN 中的 pageIndex
 */
@property(nonatomic, assign)NSInteger ax_pageIndex;

/**
 封装 alloc]init]
 */
+(instancetype)ax_init;

@end
