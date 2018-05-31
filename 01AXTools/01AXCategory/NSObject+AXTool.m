//
//  NSObject+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSObject+AXTool.h"
#import "AXMacros_runTime.h"

@interface NSObject ()


@end

@implementation NSObject (AXTool)

/**
 封装 alloc]init]
 */
+(instancetype)ax_init{
    return [[self alloc]init];
}


#pragma mark - set and get


- (void)setAx_pageIndex:(NSInteger)ax_pageIndex{
     ax_runtimePropertyAssSet(ax_pageIndex);
}

- (NSInteger)ax_pageIndex{
     return [ax_runtimePropertyAssGet(ax_pageIndex)integerValue];
}


- (void)setAx_backBlock:(AX_backBlock)ax_backBlock{
    ax_runtimePropertyObjSet(ax_backBlock);
}

- (AX_backBlock)ax_backBlock{
    return ax_runtimePropertyObjGet(ax_backBlock);
}

@end
