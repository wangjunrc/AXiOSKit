//
//  AXMacros_addProperty.h
//  AXiOSToolsDemo
//
//  Created by mac on 2018/8/17.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

/*
 分类添加属性 宏
 */
#ifndef AXMacros_addProperty_h
#define AXMacros_addProperty_h

#import <objc/runtime.h>

/*
 
 分类重写set get 方法说明
 
 typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy){
 OBJC_ASSOCIATION_ASSIGN = 0,             //assign
 OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,   //retain,nonatomic(非原子性)
 OBJC_ASSOCIATION_COPY_NONATOMIC = 3,     //copy,nonatomic(非原子性)
 OBJC_ASSOCIATION_RETAIN = 01401,         //retain(原子性)
 OBJC_ASSOCIATION_COPY = 01403,           //copy(原子性)
 };
 
 
 OBJC_ASSOCIATION_ASSIGN;            //assign策略
 OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
 OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
 
 OBJC_ASSOCIATION_RETAIN;
 OBJC_ASSOCIATION_COPY;
 
 objc_getAssociatedObject
 
 * id object 给哪个对象的属性赋值
 const void *key 属性对应的key
 id value  设置属性值为value
 objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
 */




/**
 分类添加  copy  修饰符的 属性
 OBJC_ASSOCIATION_COPY_NONATOMIC
 @param value 属性名
 */
#define ax_setCopyPropertyAssociated(value) objc_setAssociatedObject(self, @selector(value),value, OBJC_ASSOCIATION_COPY_NONATOMIC)



/**
 分类添加  strong  修饰符的 属性
 OBJC_ASSOCIATION_RETAIN_NONATOMIC
 @param value 属性名
 */
#define ax_setStrongPropertyAssociated(value) objc_setAssociatedObject(self, @selector(value),value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)


/**
 分类添加  assign  修饰符的 属性
 OBJC_ASSOCIATION_ASSIGN
 @param value 属性名
 */
#define ax_setAssignPropertyAssociated(value) objc_setAssociatedObject(self, @selector(value),@(value), OBJC_ASSOCIATION_ASSIGN)



/**
 分类添加属性 get方法
 需要初始化值,参照以下方法
 
 - (AXCountDownObject *)downObject{
 
 AXCountDownObject *obj =  ax_getValueAssociated(downObject);
 if (nil == obj) {
 obj = [[AXCountDownObject alloc]init];
 self.downObject = obj;
 }
 return obj;
 
 }
 
 @param value 属性名
 @return 当前属性
 */
#define ax_getValueAssociated(name) objc_getAssociatedObject(self,@selector(name))

#endif /* AXMacros_addProperty_h */
