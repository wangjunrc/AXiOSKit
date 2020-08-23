//
//  AXKeyboardObserve.m
//  AXiOSKit
//
//  Created by AXing on 2019/5/29.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXKeyboardObserve.h"
#import <UIKit/UIKit.h>

@interface AXKeyboardObserve ()

@property (nonatomic, weak) UIView* editView;

@property (nonatomic, strong) UITapGestureRecognizer* dismissTap;

@end

@implementation AXKeyboardObserve

- (id)initWithOwner:(UIView*)editView
{
    self = [self init];
    if (self != nil) {
        _editView = editView;
        _offset = 20;

        if ([_editView isKindOfClass:[UITextField class]]) {
            UITextField* textField = (UITextField*)_editView;
            [textField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
            [textField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
        }
    }

    return self;
}

- (void)dismissTapAction:(UITapGestureRecognizer*)tap
{
    if (self.editView) {
        [self.editView endEditing:YES];
    }
}

- (void)addObserver
{
    //添加键盘事件监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //添加编辑框监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)removeObserver
{
    //移除键盘事件监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    //移除编辑框监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    if (self.dismissTap) {
        [self.dismissTap removeTarget:self action:@selector(dismissTapAction:)];
    }
}

#pragma - mark 获取键盘高度
- (UIView*)__findKeyBoard
{
    UIView* keyboardView = nil;
    NSArray* windows = [[UIApplication sharedApplication] windows];
    for (UIWindow* window in [windows reverseObjectEnumerator]) {
        //逆序效率更高，因为键盘总在上方
        keyboardView = [self __findKeyBoardInView:window];
        if (keyboardView) {
            return keyboardView;
        }
    }
    return nil;
}

- (UIView*)__findKeyBoardInView:(UIView*)view
{
    for (UIView* subView in [view subviews]) {
        if (strstr(object_getClassName(subView), "UIKeyboard")) {
            return subView;
        } else {
            UIView* tempView = [self __findKeyBoardInView:subView];
            if (tempView) {
                return tempView;
            }
        }
    }
    return nil;
}

#pragma - mark 监听canBecomeFirstResponder
- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    [self addObserver];
    //编辑框键盘弹出状态处理(多个键盘间切换处理)
    [self movingView];
}

- (void)textFieldDidEndEditing:(UITextField*)textField
{
    [self removeObserver];
}

#pragma - mark textField编辑监听
- (void)textFiledEditChanged:(NSNotification*)noti
{
}

#pragma - mark 监听键盘
- (void)handleKeyboardWillShow:(NSNotification*)noti
{
    if (self.containerView != nil && [self.editView isFirstResponder]) {
        NSDictionary* userInfo = [noti userInfo];
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGFloat keyboardHeight = [aValue CGRectValue].size.height;

        [self movingView:keyboardHeight];

        self.dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTapAction:)];
        [self.containerView addGestureRecognizer:self.dismissTap];
    }
}

- (void)handleKeyboardWillHide:(NSNotification*)noti
{
    if (self.containerView != nil && [self.editView isFirstResponder]) {
        if (!CGAffineTransformIsIdentity(self.containerView.transform)) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            self.containerView.transform = CGAffineTransformIdentity;
            [UIView commitAnimations];

            [self.dismissTap removeTarget:self action:@selector(dismissTapAction:)];
        }
    }
}

- (void)handleKeyboardWillChange:(NSNotification*)noti
{
    [self handleKeyboardWillShow:noti];
}

- (void)movingView
{
    UIView* keyboardView = [self __findKeyBoard];
    if (self.containerView != nil && keyboardView != nil) {
        [self movingView:CGRectGetHeight(keyboardView.frame)];
    }
}

- (void)movingView:(CGFloat)keyboardHeight
{
    CGRect rect = [self.editView convertRect:self.editView.bounds toView:self.editView.window];
    CGFloat h = rect.origin.y + rect.size.height - (self.editView.window.bounds.size.height - keyboardHeight) + _offset;
    if (h > 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGAffineTransform at = CGAffineTransformMakeTranslation(0, -1 * (h + _offset - self.containerView.transform.ty));
        self.containerView.transform = at;
        [UIView commitAnimations];
    } else {
        //如果太高要往下移动。。。。
        if (!CGAffineTransformIsIdentity(self.containerView.transform)) {
            CGAffineTransform at = CGAffineTransformMakeTranslation(0, -1 * (h + _offset - self.containerView.transform.ty));

            if (at.ty > 0) {
                at = CGAffineTransformIdentity;
            }

            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            self.containerView.transform = at;
            [UIView commitAnimations];
        }
    }
}

- (void)dealloc {
    [self removeObserver];
}


@end
