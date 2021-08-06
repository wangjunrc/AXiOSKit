//
//  UIControl+AXKit.m
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/6/5.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UIControl+AXKit.h"
#import <objc/runtime.h>

#import "AXMacros_addProperty.h"

typedef void(^ControlBlock)(UIControl *aControl);

@interface UIControl ()
@property (nonatomic, copy)ControlBlock controlBlock;
@end
@implementation UIControl (AXKit)

/**
 * UIControl addTarget 封装成block
 */
- (void)ax_addTargetEvents:(UIControlEvents)controlEvents block:(void(^_Nullable)(UIControl * _Nullable aControl))block{
    [self addTarget:self action:@selector(controlAction:) forControlEvents:controlEvents];
    self.controlBlock = block;
}

#pragma mark - action
- (void)controlAction:(UIControl *)sender{
    if (self.controlBlock) {
        self.controlBlock(sender);
    }
}


#pragma mark - set and get

- (void)setControlBlock:(ControlBlock)controlBlock{
    ax_setCopyPropertyAssociated(controlBlock);
}

- (ControlBlock)controlBlock{
    return ax_getValueAssociated(controlBlock);
}

//- (void)setAx_hitTestEdgeInsets:(UIEdgeInsets)ax_hitTestEdgeInsets {
//    
//    NSValue *value = [NSValue value:&ax_hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
//    objc_setAssociatedObject(self, @selector(ax_hitTestEdgeInsets),value, OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (UIEdgeInsets)ax_hitTestEdgeInsets {
//    
//    NSValue *value = objc_getAssociatedObject(self, @selector(ax_hitTestEdgeInsets));
//    if(value) {
//        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
//    }else {
//        return UIEdgeInsetsZero;
//    }
//}
//
//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    if(UIEdgeInsetsEqualToEdgeInsets(self.ax_hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
//        return [super pointInside:point withEvent:event];
//    }
//    
//    CGRect relativeFrame = self.bounds;
//    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.ax_hitTestEdgeInsets);
//    
//    return CGRectContainsPoint(hitFrame, point);
//}

- (void)setAx_hitPointEdgeInsets:(UIEdgeInsets)ax_hitPointEdgeInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:ax_hitPointEdgeInsets];
    objc_setAssociatedObject(self, @selector(ax_hitPointEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)ax_hitPointEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, @selector(ax_hitPointEdgeInsets));
//    NSValue *value = objc_getAssociatedObject(self,_cmd);
    if(value) {
        return [value UIEdgeInsetsValue];
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if(UIEdgeInsetsEqualToEdgeInsets(self.ax_hitPointEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.ax_hitPointEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

@end
