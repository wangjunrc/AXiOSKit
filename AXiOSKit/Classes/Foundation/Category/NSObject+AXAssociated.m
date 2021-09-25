//
//  NSObject+AXAssociated.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/8.
//

#import "NSObject+AXAssociated.h"
#import <objc/runtime.h>

@implementation NSObject (AXAssociated)


#pragma mark - 添加属性

/**
 retain strong nonatomic 属性添加值
 */
-(void)ax_setStrongValue:(id )value{
    objc_setAssociatedObject(self, @selector(value),value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 copy nonatomic 属性添加值
 */
-(void) ax_setCopyValue:(id )value {
    objc_setAssociatedObject(self, @selector(value),value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 assign nonatomic 属性添加值
 */
-(void) ax_setAssignValue:(id )value {
    objc_setAssociatedObject(self, @selector(value),value, OBJC_ASSOCIATION_ASSIGN);
}

/**
 Retain Strong Copy Assign 对象获取值
 Assign 需要转型
 */
-(instancetype)ax_getAssignValue:(const void * _Nonnull)key {
    return objc_getAssociatedObject(self, key);
}

@end
