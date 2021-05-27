//
//  UITextView+AXKit.m
//  AXiOSKitDemo
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UITextView+AXKit.h"

@implementation UITextView (AXKit)

/**
 通过UILabel 设置站位文字

 @param aText 文字
 @param aColor 颜色
 */
- (void)ax_setPlaceholder:(NSString*)aText color:(UIColor*)aColor
{

    // 据说 8.3 不兼容
    UILabel* pLabel = [[UILabel alloc] init];
    pLabel.text = aText;
    pLabel.numberOfLines = 1;
    pLabel.textColor = [UIColor lightGrayColor];
    [pLabel sizeToFit];
    pLabel.font = self.font; //如果不设置font 为textView的font大小，第一次 placeholderLabel要偏移哦
    [self addSubview:pLabel];
    [self setValue:pLabel forKey:@"_placeholderLabel"];
}

- (BOOL)ax_textView:(UITextView*)textView
      maxTextLength:(NSUInteger)count
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString*)text
{

    // 删除键
    if ([text isEqualToString:@""]) {
        return YES;
    }

    // 点击return键
    if ([text isEqualToString:@"\n"]) {
        return NO;
    }

    // 大于最大数量
    if ((textView.text.length + text.length) > count) {
        return NO;
    }
    return YES;
}


@end
