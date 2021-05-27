//
//  NSObject+AXSafe.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/25.
//

#import "NSObject+AXSafe.h"
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


/// obj 是否为指定Class
/// @param aClass aClass
/// @param obj obj
BOOL ax_objc_is_class_nil(id obj,
                          Class aClass) {
    if (![obj isKindOfClass:aClass]) {
        return YES;
    }
    
    if (obj == nil) {
        return YES;
    }
    
    if ((NSNull*)obj == [NSNull null]) {
        return YES;
    }
    
    return NO;
}

/// obj 是否为指定Class,并返回默认值
/// @param obj obj
/// @param aClass 指定Class
/// @param value 默认值
id ax_objc_class_nil_value(id obj,
                           Class aClass,
                           id value) {
    
    if (ax_objc_is_class_nil(aClass, value)) {
        value = [[aClass alloc]init];
    }
    
    if (ax_objc_is_nil(obj) || ![obj isKindOfClass:aClass]) {
        return value;
    }
    
    return obj;
    
}

/// obj 是否为指定Class 若nil,反正 Class 初始化值
/// @param obj obj
/// @param aClass 指定Class
id ax_objc_class_nil_defaults(id obj,Class aClass){
    id value = [[aClass alloc]init];
    return ax_objc_class_nil_value(obj,aClass,value);
}

/// 是否 nil,如未nil,返回默认值
/// @param obj obj
/// @param value 为nil 返回值
id ax_objc_nil_defaults(id obj,id value) {
    
    if (ax_objc_is_nil(obj)) {
        return value;
    }else {
        return obj;
    }
}



#pragma mark - NSString

NSString* ax_string_nil_value(id obj,
                              NSString* value){
    return ax_objc_class_nil_value(obj,NSString.class,value);
}

/// 判断数组是否越界,[index]元素是否为指定类型,返回默认值
/// @param array array
/// @param index index
/// @param aClass 指定Class
/// @param value 默认值
id ax_objc_in_arrar_class_nil_value(NSArray *array,
                                    NSUInteger index,
                                    Class aClass,
                                    id value) {
    
    if (ax_objc_is_class_nil(aClass, value)) {
        value = [[aClass alloc]init];
    }
    if (!array ||
        ![array isKindOfClass:NSArray.class] ||
        array.count<=index) {
        return value;
    }
    
    id objc = array[index];
    if (![objc isKindOfClass:aClass]) {
        return value;
    }
    
    return objc;
}

/// 判断数组是否越界,[index]元素是否为指定类型,若不满足条件返回Class初始化值
/// @param array array
/// @param index index
/// @param aClass 指定Class
id ax_objc_in_arrar_class_nil_defaults(NSArray *array,
                                       NSUInteger index,
                                       Class aClass) {
    
    id value = [[aClass alloc]init];
    return ax_objc_in_arrar_class_nil_value(array,index,aClass,value);
}
