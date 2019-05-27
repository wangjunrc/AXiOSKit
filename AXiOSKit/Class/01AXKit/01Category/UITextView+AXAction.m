//
//  UITextView+AXAction.m
//  AXiOSKit
//
//  Created by AXing on 2019/5/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "UITextView+AXAction.h"
#import "AXMacros_addProperty.h"
#import "UITextView+AXKit.h"

@implementation AXTextViewDelegateHandler


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (self.didEndBlock) {
        self.didEndBlock(textView.text);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (self.shouldChangeBlock) {
       return self.shouldChangeBlock(textView, range, text);
    }
    return YES;
}

/**
 最大输入文字数量
 */
- (void)maxCharacterCount:(NSUInteger)count {
    
    self.shouldChangeBlock = ^BOOL(UITextView * _Nonnull textView, NSRange range, NSString * _Nonnull aString) {
        return [textView ax_textView:textView maxCharacterCount:count shouldChangeTextInRange:range replacementText:aString];
    };
    
}


@end

@implementation UITextView (AXAction)

- (void)setAxDelegateHandler:(AXTextViewDelegateHandler *)axDelegateHandler {
    ax_setStrongPropertyAssociated(axDelegateHandler);
}

- (AXTextViewDelegateHandler *)axDelegateHandler{
    
    AXTextViewDelegateHandler *handler = ax_getValueAssociated(axDelegateHandler);
    
    if (handler == nil ){
        
        handler = [[AXTextViewDelegateHandler alloc]init];
        handler.currentTextView = self;
        self.delegate = handler;
        self.axDelegateHandler = handler;
    }
    return handler;
}


@end
