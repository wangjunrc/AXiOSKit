//
//  UILabel+AXTool.m
//
//
//  Created by liuweixing on 15/10/27.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "UILabel+AXTool.h"
#import <objc/runtime.h>
#import "AXMacros.h"
#import "NSString+AXEffective.h"

@implementation UILabel (AXTool)

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copyText:));
}

- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:g];
}

//  处理手势相应事件
- (void)handleTap:(UIGestureRecognizer *)g {
    [self becomeFirstResponder];
    
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:AXMyLocalizedString(@"ax.copy") action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
}
//  复制时执行的方法
- (void)copyText:(id)sender {
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        if (self.text) {
            pBoard.string = self.text;
        } else {
            pBoard.string = self.attributedText.string;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return [objc_getAssociatedObject(self, @selector(axCopyable)) boolValue];
}

- (void)setAxCopyable:(BOOL)number {
    objc_setAssociatedObject(self, @selector(axCopyable), [NSNumber numberWithBool:number], OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}

- (BOOL)axCopyable {
    return [objc_getAssociatedObject(self, @selector(axCopyable)) boolValue];
}


/**
 设置 电话 含有下划线,并可以点击打电话
 */
-(void)ax_setPhoneCall{
    
    NSString *labelStr = self.text;
    UILabel *label = self;
    
    //获取字符串中的电话号码
    NSString *regulaStr = @"\\d{3,4}[- ]?\\d{7,8}";
    NSRange stringRange = NSMakeRange(0, labelStr.length);
    //正则匹配
    NSError *error;
    NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
    if (!error && regexps != nil) {
        [regexps enumerateMatchesInString:labelStr options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            
            //可能为电话号码的字符串及其所在位置
            NSRange phoneRange = result.range;
            
            //设置文本中的电话号码显示为蓝色
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:labelStr];
            NSDictionary *dcit = @{
                                   //添加下划线
                                   NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                   
                                   // 文字颜色
                                   NSForegroundColorAttributeName:[UIColor blueColor],
                                   
                                   //下划线颜色
                                   NSUnderlineColorAttributeName:[UIColor blueColor]
                                   };
            [str addAttributes:dcit range:phoneRange];
            label.attributedText = str;
            NSString *phoneStr = [labelStr substringWithRange:phoneRange];
            [self ax_addTargetBlock:^(UIView *aView) {
                ax_CallTel(phoneStr);
            }];
            
        }];
    }
}

@end
