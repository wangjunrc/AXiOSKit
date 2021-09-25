//
//  NSObject+AXKVO.m
//  AXiOSKit
//
//  Created by liuweixing on 2016/10/17.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSObject+AXKVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

#pragma mark - 私有实现KVO的真实target类，每一个target对应了一个keyPath和监听该keyPath的所有block，当其KVO方法调用时，需要回调所有的block

@interface _XWBlockTarget : NSObject

/**添加一个KVOBlock*/
- (void)kvo_addBlock:(void(^)(__weak id obj, id oldValue, id newValue))block;
- (void)kvo_addNotificationBlock:(void(^)(NSNotification *notification))block;

- (void)kvo_doNotification:(NSNotification*)notification;

@end

@implementation _XWBlockTarget{
    //保存所有的block
    NSMutableSet *_kvoBlockSet;
    NSMutableSet *_notificationBlockSet;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _kvoBlockSet = [NSMutableSet new];
        _notificationBlockSet = [NSMutableSet new];
    }
    return self;
}

- (void)kvo_addBlock:(void(^)(__weak id obj, id oldValue, id newValue))block{
    [_kvoBlockSet addObject:[block copy]];
}

- (void)kvo_addNotificationBlock:(void(^)(NSNotification *notification))block{
    [_notificationBlockSet addObject:[block copy]];
}

- (void)kvo_doNotification:(NSNotification*)notification{
    if (!_notificationBlockSet.count) return;
    [_notificationBlockSet enumerateObjectsUsingBlock:^(void (^block)(NSNotification *notification), BOOL * _Nonnull stop) {
        block(notification);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (!_kvoBlockSet.count) return;
    BOOL prior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    //只接受值改变时的消息
    if (prior) return;
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    //执行该target下的所有block
    [_kvoBlockSet enumerateObjectsUsingBlock:^(void (^block)(__weak id obj, id oldVal, id newVal), BOOL * _Nonnull stop) {
        block(object, oldVal, newVal);
    }];
}

@end


@implementation NSObject (KVO)
static void *const XWKVOBlockKey = "XWKVOBlockKey";

- (void)ax_addKVOBlockForKeyPath:(NSString*)keyPath block:(void (^)(id obj, id oldVal, id newVal))block {
    if (!keyPath || !block) return;
    //取出存有所有KVOTarget的字典
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWKVOBlockKey);
    if (!allTargets) {
        //没有则创建
        allTargets = [NSMutableDictionary new];
        //绑定在该对象中
        objc_setAssociatedObject(self, XWKVOBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    //获取对应keyPath中的所有target
    _XWBlockTarget *targetForKeyPath = allTargets[keyPath];
    if (!targetForKeyPath) {
        //没有则创建
        targetForKeyPath = [_XWBlockTarget new];
        //保存
        allTargets[keyPath] = targetForKeyPath;
        //如果第一次，则注册对keyPath的KVO监听
        [self addObserver:targetForKeyPath forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    [targetForKeyPath kvo_addBlock:block];
    //对第一次注册KVO的类进行dealloc方法调剂
    [self _kvo_swizzleDealloc];
}
- (void)ax_removeKVOBlockForKeyPath:(NSString *)keyPath{
    if (!keyPath.length) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWKVOBlockKey);
    if (!allTargets) return;
    _XWBlockTarget *target = allTargets[keyPath];
    if (!target) return;
    [self removeObserver:target forKeyPath:keyPath];
    [allTargets removeObjectForKey:keyPath];
}

- (void)ax_removeAllKVOBlocks {
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWKVOBlockKey);
    if (!allTargets) return;
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id key, _XWBlockTarget *target, BOOL *stop) {
        [self removeObserver:target forKeyPath:key];
    }];
    [allTargets removeAllObjects];
}

static void *const XWNotificationBlockKey = "XWNotificationBlockKey";
/**
 *  通过block方式注册通知，通过该方式注册的通知无需手动移除，同样会自动移除
 *
 *  @param name  通知名
 *  @param block 通知的回调Block，notification为回调的通知对象
 */
- (void)ax_addNotificationForName:(NSString *)name block:(void (^)(NSNotification *notification))block {
    if (!name || !block) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWNotificationBlockKey);
    if (!allTargets) {
        allTargets = @{}.mutableCopy;
        objc_setAssociatedObject(self, XWNotificationBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    _XWBlockTarget *target = allTargets[name];
    if (!target) {
        target = [_XWBlockTarget new];
        allTargets[name] = target;
        [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(kvo_doNotification:) name:name object:nil];
    }
    [target kvo_addNotificationBlock:block];
    [self _kvo_swizzleDealloc];
    
}

- (void)ax_removeNotificationForName:(NSString *)name{
    if (!name) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWNotificationBlockKey);
    if (!allTargets.count) return;
    _XWBlockTarget *target = allTargets[name];
    if (!target) return;
    [[NSNotificationCenter defaultCenter] removeObserver:target];
    
}

- (void)ax_removeAllNotification{
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWNotificationBlockKey);
    if (!allTargets.count) return;
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, _XWBlockTarget *target, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:target];
    }];
    [allTargets removeAllObjects];
}

- (void)ax_postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}



static void * deallocHasSwizzledKey = "deallocHasSwizzledKey";

/**
 *  调剂dealloc方法，由于无法直接使用运行时的swizzle方法对dealloc方法进行调剂，所以稍微麻烦一些
 */
- (void)_kvo_swizzleDealloc{
    //我们给每个类绑定上一个值来判断dealloc方法是否被调剂过，如果调剂过了就无需再次调剂了
    BOOL swizzled = [objc_getAssociatedObject(self.class, deallocHasSwizzledKey) boolValue];
    //如果调剂过则直接返回
    if (swizzled) return;
    //开始调剂
    Class swizzleClass = self.class;
    //获取原有的dealloc方法
    SEL deallocSelector = sel_registerName("dealloc");
    //初始化一个函数指针用于保存原有的dealloc方法
    __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
    //实现我们自己的dealloc方法，通过block的方式
    id newDealloc = ^(__unsafe_unretained id objSelf){
        //在这里我们移除所有的KVO
        [objSelf ax_removeAllKVOBlocks];
        //移除所有通知
        [objSelf ax_removeAllNotification];
        //根据原有的dealloc方法是否存在进行判断
        if (originalDealloc == NULL) {//如果不存在，说明本类没有实现dealloc方法，则需要向父类发送dealloc消息(objc_msgSendSuper)
            //构造objc_msgSendSuper所需要的参数，.receiver为方法的实际调用者，即为类本身，.super_class指向其父类
            struct objc_super superInfo = {
                .receiver = objSelf,
                .super_class = class_getSuperclass(swizzleClass)
            };
            //构建objc_msgSendSuper函数
            void (*msgSend_a)(struct objc_super *, SEL) = (__typeof__(msgSend_a))objc_msgSendSuper;
            //向super发送dealloc消息
            msgSend_a(&superInfo, deallocSelector);
        }else{//如果存在，表明该类实现了dealloc方法，则直接调用即可
            //调用原有的dealloc方法
            originalDealloc(objSelf, deallocSelector);
        }
    };
    //根据block构建新的dealloc实现IMP
    IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
    //尝试添加新的dealloc方法，如果该类已经复写的dealloc方法则不能添加成功，反之则能够添加成功
    if (!class_addMethod(swizzleClass, deallocSelector, newDeallocIMP, "v@:")) {
        //如果没有添加成功则保存原有的dealloc方法，用于新的dealloc方法中
        Method deallocMethod = class_getInstanceMethod(swizzleClass, deallocSelector);
        originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
        originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
    }
    //标记该类已经调剂过了
    objc_setAssociatedObject(self.class, deallocHasSwizzledKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/** 系统提供的perform系列方法参数个数有限,可以利用NSInvocation实现多参数 */
/// 请求转发 多个参数
/// @param aSelector 方法名
/// @param objects 数组,主要不要传nil
- (id)ax_performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    // 初始化方法签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    // 如果方法不存在
    if (!signature) {
        // 抛出异常
        NSString *reason = [NSString stringWithFormat:@"方法不存在 : %@",NSStringFromSelector(aSelector)];
        @throw [NSException exceptionWithName:@"error" reason:reason userInfo:nil];
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    // 参数个数signature.numberOfArguments 默认有一个_cmd 一个target 所以要-2
    NSInteger paramsCount = signature.numberOfArguments - 2;
    
    // 当objects的个数多于函数的参数的时候,取前面的参数
    // 当objects的个数少于函数的参数的时候,不需要设置,默认为nil
    paramsCount = MIN(paramsCount, objects.count);
    
    for (NSInteger index = 0; index < paramsCount; index++) {
        id object = objects[index];
        // 对参数为nil的处理
        if ([object isKindOfClass:[NSNull class]]) {
            continue;
        }
        [invocation setArgument:&object atIndex:index + 2];
    }
    
    // 调用方法
    [invocation invoke];
    
    //    // 获取返回值
    //    id  returnValue = nil;
    //    //signature.methodReturnLength == 0 说明给方法没有返回值
    //    if (signature.methodReturnLength) {
    //        //获取返回值
    //        [invocation getReturnValue:&returnValue];
    //    }
    //    return returnValue;
    
    // 获取返回值
    //       id __unsafe_unretained returnValue = nil;
    //       //signature.methodReturnLength == 0 说明给方法没有返回值
    //       if (signature.methodReturnLength) {
    //           //获取返回值
    //           [invocation getReturnValue:&returnValue];
    //       }
    //       id value = returnValue;
    // 需要做返回类型判断。比如返回值为常量需要包装成对象，这里仅以最简单的`@`为例
    id returnVal;
    if (strcmp(signature.methodReturnType, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
    //    BOOL returnValue;
    //     [invocation getReturnValue：& returnValue];
    return returnVal;
    
}

@end
