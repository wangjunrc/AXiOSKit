//
//  NSObject+AXAssociated.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AXAssociated)


/**
 retain strong nonatomic 属性添加值
 */
-(void)ax_setStrongValue:(id )value;

/**
 copy nonatomic 属性添加值
 */
-(void) ax_setCopyValue:(id )value;

/**
 assign nonatomic 属性添加值
 */
-(void) ax_setAssignValue:(id )value;

/**
 Retain Strong Copy Assign 对象获取值
 Assign 需要转型
 */
-(instancetype)ax_getAssignValue:(const void * _Nonnull)key;

@end

NS_ASSUME_NONNULL_END
