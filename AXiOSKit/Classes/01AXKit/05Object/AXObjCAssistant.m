//
//  AXObjCAssistant.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/25.
//

#import "AXObjCAssistant.h"
/// 是否 nil 或者 空
/// 不要用分类, 为nil 时,不走分类方法
BOOL ax_objc_is_empty(id obj) {
    if (obj == nil) {
        return YES;
    }
    
    if ((NSNull*)obj == [NSNull null]) {
        return YES;
    }
    
    if ([obj respondsToSelector:@selector(count)]) {
        if ([(id)obj count] == 0) {
            return YES;
        }
    }
    
    if ([obj respondsToSelector:@selector(length)]) {
        if ([(id)obj length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

/// 是否不为 nil 或者 空
BOOL ax_objc_is_not_empty(id obj) {
    return !ax_objc_is_empty(obj);
}

///  是否 nil
/// @param obj obj
BOOL ax_objc_is_nil(id obj) {
    if (obj == nil) {
        return YES;
    }
    
    if ((NSNull*)obj == [NSNull null]) {
        return YES;
    }
    return NO;
}
///  是否 不为nil
/// @param obj obj
BOOL ax_objc_is_not_nil(id obj) {
    return !ax_objc_is_nil(obj);
}

/// 是否 nil,如未nil,返回默认值
/// @param obj obj
/// @param value 为nil 返回值
id ax_objc_is_nil_defaults(id obj,id value) {
    if (ax_objc_is_nil(obj)) {
        return value;
    }else {
        return obj;
    }
}


/// obj 是否为指定Class 一般来判断字典,数组中传值
/// @param aClass 指定Class
/// @param obj obj
/// @param value 默认值
id ax_objc_is_class_nil_defaults(id obj,Class aClass,id value) {
    
    if (![obj isKindOfClass:aClass]) {
        return value;
    }
    return ax_objc_is_nil_defaults(obj,value);
}

/// 判断数组是否越界,[index]元素是否为指定类型,返回默认值
/// @param array array
/// @param index index
/// @param aClass 指定Class
/// @param value 默认值
id ax_arrar_index_is_class_nil_defaults(NSArray *array,NSUInteger index,Class aClass,id value) {
    
    if (!array) {
        return value;
    }
    
    if (![array isKindOfClass:NSArray.class]) {
        return value;
    }
    
    if (array.count<=index) {
        return value;
    }
    
    id objc = array[index];
    if (![objc isKindOfClass:aClass]) {
        return value;
    }
    
    return objc;
}
