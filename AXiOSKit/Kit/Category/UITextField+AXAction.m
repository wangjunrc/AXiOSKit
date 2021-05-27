//
//  UITextField+AXAction.m
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/8/15.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UITextField+AXAction.h"
#import "AXMacros_addProperty.h"
#import "UITextField+AXKit.h"
#import "NSObject+AXAssistant.h"

#pragma mark - implementation UITextField

@implementation UITextField (AXAction)

#pragma mark - ax_delegateHandler

- (void)setAx_observe:(AXTextFieldObserve *)ax_observe {
    ax_setStrongPropertyAssociated(ax_observe);
}

- (AXTextFieldObserve *)ax_observe {
    AXTextFieldObserve *handler = ax_getValueAssociated(ax_observe);
    if (!handler) {
        handler = [[AXTextFieldObserve alloc] initWithTextField:self];
//        handler.currentTextField = self;
        //        self.delegate = handler;
        self.ax_observe = handler;
    }
    return handler;
}

#pragma mark - AXKeyboardObserve
- (void)setAx_keyboardObserve:(AXKeyboardObserve *)ax_keyboardObserve{
    ax_setStrongPropertyAssociated(ax_keyboardObserve);
}

- (AXKeyboardObserve *)ax_keyboardObserve
{
    AXKeyboardObserve *obj = ax_getValueAssociated(ax_keyboardObserve);
    if (obj == nil) {
        obj = [[AXKeyboardObserve alloc] initWithOwner:self];
        self.ax_keyboardObserve = obj;
    }
    return obj;
}

@end
