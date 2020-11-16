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
#import "AXFoundationAssistant.h"

#pragma mark - implementation UITextField

@implementation UITextField (AXAction)

#pragma mark - ax_delegateHandler

- (void)setAx_delegateObserve:(AXTextFieldDelegateObserve*)ax_delegateObserve
{
    ax_setStrongPropertyAssociated(ax_delegateObserve);
}

- (AXTextFieldDelegateObserve*)ax_delegateObserve
{
    AXTextFieldDelegateObserve* handler = ax_getValueAssociated(ax_delegateObserve);
    if (!handler) {
        handler = [[AXTextFieldDelegateObserve alloc] initWithTextField:self];
//        handler.currentTextField = self;
        //        self.delegate = handler;
        self.ax_delegateObserve = handler;
    }
    return handler;
}

#pragma mark - AXKeyboardObserve
- (void)setAx_keyboardObserve:(AXKeyboardObserve*)ax_keyboardObserve
{
    ax_setStrongPropertyAssociated(ax_keyboardObserve);
}

- (AXKeyboardObserve*)ax_keyboardObserve
{
    AXKeyboardObserve *obj = ax_getValueAssociated(ax_keyboardObserve);
    if (obj == nil ){
        obj = [[AXKeyboardObserve alloc] initWithOwner:self];
        self.ax_keyboardObserve = obj;
    }
    return obj;
    
}

@end
