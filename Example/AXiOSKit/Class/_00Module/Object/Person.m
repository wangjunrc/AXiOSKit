//
//  Person.m
//  RuntimeDemo
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "Person.h"

void testFun(){
    NSLog(@"拦截了方法 = testFun");
}

@implementation Person

-(void)logShowTest{
    NSLog(@"这是一个人");
}

#pragma mark - 第一步 方法解析
+(BOOL)resolveInstanceMethod:(SEL)sel{
    if ([super resolveInstanceMethod:sel]) {
        return YES;
    }else{
        class_addMethod(self, sel, (IMP)testFun, "v@:");
        return YES;
    }
}

#pragma mark - 第二步快速转发
//-(id)forwardingTargetForSelector:(SEL)aSelector{
//    if ([NSStringFromSelector(aSelector) isEqual:@"testFun"]) {
//        return [SubDog new];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

#pragma mark - 第三步 慢速转发
-(void)showMessage:(NSString*)message{
    NSLog(@"message = %@",message);
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if ([super methodSignatureForSelector:aSelector] == nil) {
        NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        return signature;
    }
    return [super methodSignatureForSelector:aSelector];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = @selector(showMessage:);
    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    anInvocation = [NSInvocation invocationWithMethodSignature:signature];
    [anInvocation setTarget:self];
    [anInvocation setSelector:sel];
    NSString *message = @"在第三步自己实现的方法，改了参数";
    [anInvocation setArgument:&message atIndex:2];
    if ([self respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:self];
    }else{
        [super forwardInvocation:anInvocation];
    }
}

@end
