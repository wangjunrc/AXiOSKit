//
//  UIGestureRecognizer+AXKit.m
//  AXiOSKit
//
//  Created by axing on 2019/6/17.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "UIGestureRecognizer+AXKit.h"
#import <objc/runtime.h>

@interface UIGestureRecognizer ()

@property (nonatomic, copy)AXGestureBlock actionBlock;

@end

@implementation UIGestureRecognizer (AXKit)

+(instancetype )ax_gestureRecognizerWithActionBlock:(AXGestureBlock )block {
    
    return [[self alloc]initWithActionBlock:block];
}

-(instancetype )initWithActionBlock:(AXGestureBlock )block {
    if (self = [self init]) {
        self.actionBlock = block;
        [self addTarget:self action:@selector(__gestureAction:)];
    }
    return self;
}


/**
 * 事件block
 */
- (void)ax_addActionBlock:(void(^)(UIGestureRecognizer *sender))block {
     self.actionBlock = block;
    [self addTarget:self action:@selector(__gestureAction:)];
}

-(void)__gestureAction:(UIGestureRecognizer *)sender {
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}

- (void)setActionBlock:(AXGestureBlock)actionBlock {
     objc_setAssociatedObject(self, @selector(actionBlock),actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (AXGestureBlock)actionBlock {
    return objc_getAssociatedObject(self, @selector(actionBlock));
}

@end
