//
//  UITextView+AXAction.m
//  AXiOSKit
//
//  Created by axing on 2019/5/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "UITextView+AXAction.h"
#import "AXMacros_addProperty.h"
#import "UITextView+AXKit.h"
@interface AXTextViewDelegateHandler ()

@property (nonatomic, weak) UITextView* currentTextView;

@end

@implementation AXTextViewDelegateHandler


- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.didEndBlock) {
        self.didEndBlock(textView);
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
- (void)setMaxTextLength:(NSUInteger)maxTextLength {
    _maxTextLength = maxTextLength;
    
    self.shouldChangeBlock = ^BOOL(UITextView * _Nonnull textView, NSRange range, NSString * _Nonnull aString) {
        return [textView ax_textView:textView maxTextLength:maxTextLength shouldChangeTextInRange:range replacementText:aString];
    };
}


@end

@implementation UITextView (AXAction)


- (void)setAx_delegateHandler:(AXTextViewDelegateHandler * _Nonnull)ax_delegateHandler {
    ax_setStrongPropertyAssociated(ax_delegateHandler);
}
- (AXTextViewDelegateHandler *)ax_delegateHandler {
    
    AXTextViewDelegateHandler *handler = ax_getValueAssociated(ax_delegateHandler);
    
    if (handler == nil ){
        
        handler = [[AXTextViewDelegateHandler alloc]init];
        handler.currentTextView = self;
        self.delegate = handler;
        self.ax_delegateHandler = handler;
    }
    return handler;
}


@end
