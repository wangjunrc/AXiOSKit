//
//  NSObject+AXSafe.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/25.
//

#import <Foundation/Foundation.h>

#pragma mark - id objc

///  是否 nil 或者 空,如 obj=nil; string.length=0; arrar.count=0;
/// @param obj obj
FOUNDATION_EXPORT BOOL ax_objc_is_empty(id obj);

///  是否不为 nil 或者 空
/// @param obj obj
FOUNDATION_EXPORT BOOL ax_objc_is_not_empty(id obj);

///  是否 nil
/// @param obj obj
FOUNDATION_EXPORT BOOL ax_objc_is_nil(id obj);

///  是否 不为nil
/// @param obj obj
FOUNDATION_EXPORT BOOL ax_objc_is_not_nil(id obj);

/// obj 是否为指定Class
/// @param aClass aClass
/// @param obj obj
FOUNDATION_EXPORT BOOL ax_objc_is_class_nil(id obj,
                                            Class aClass);

/// obj 是否为指定Class,并返回默认值
/// @param aClass 指定Class
/// @param obj obj
/// @param value 默认值
FOUNDATION_EXPORT id ax_objc_class_nil_value(id obj,
                                             Class aClass,
                                             id value);

/// obj 是否为指定Class 若nil,反正 Class 初始化值
/// @param obj obj
/// @param aClass 指定Class
FOUNDATION_EXPORT id ax_objc_class_nil_defaults(id obj,
                                                Class aClass);

/// 是否 nil,如未nil,返回默认值
/// @param obj obj
/// @param value 为nil 返回值
FOUNDATION_EXPORT id ax_objc_nil_defaults(id obj,
                                          id value);

#pragma mark - NSString

/// 当obj 可以取得指定类型值时，返回指定类型值，
/// @param obj obj
/// @param value 指定类型值
FOUNDATION_EXPORT NSString* ax_string_nil_value(id obj,
                                                NSString* value);


#pragma mark - NSArray
/// 判断数组是否越界,[index]元素是否为指定类型,返回默认值
/// @param array array
/// @param index index
/// @param aClass 指定Class
/// @param value 默认值
FOUNDATION_EXPORT id ax_objc_in_arrar_class_nil_value(NSArray *array,
                                                      NSUInteger index,
                                                      Class aClass,
                                                      id value);

/// 判断数组是否越界,[index]元素是否为指定类型,若不满足条件返回Class初始化值
/// @param array array
/// @param index index
/// @param aClass 指定Class
FOUNDATION_EXPORT id ax_objc_in_arrar_class_nil_defaults(NSArray *array,
                                                         NSUInteger index,
                                                         Class aClass);
