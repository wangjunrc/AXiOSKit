//
//  AXObjCAssistant.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/25.
//

#import <Foundation/Foundation.h>

///  是否 nil 或者 空,如 obj=nil; string.length=0; arrar.count=0;
/// @param obj obj
extern BOOL ax_objc_is_empty(id obj);

///  是否不为 nil 或者 空
/// @param obj obj
extern BOOL ax_objc_is_not_empty(id obj);

///  是否 nil
/// @param obj obj
extern BOOL ax_objc_is_nil(id obj);

///  是否 不为nil
/// @param obj obj
extern BOOL ax_objc_is_not_nil(id obj);

/// 是否 nil,如未nil,返回默认值
/// @param obj obj
/// @param value 为nil 返回值
extern id ax_objc_is_nil_defaults(id obj,
                                  id value);

/// obj 是否为指定Class 一般来判断字典,数组中传值
/// @param aClass 指定Class
/// @param obj obj
/// @param value 默认值
id ax_objc_is_class_nil_defaults(id obj,
                                 Class aClass,
                                 id value);;

/// 判断数组是否越界,[index]元素是否为指定类型,返回默认值
/// @param array array
/// @param index index
/// @param aClass 指定Class
/// @param value 默认值
id ax_arrar_index_is_class_nil_defaults(NSArray *array,
                                        NSUInteger index,
                                        Class aClass,
                                        id value);
