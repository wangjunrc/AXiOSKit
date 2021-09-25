//
//  UITextView+AXKit.h
//  AXiOSKitDemo
//
//  Created by liuweixing 2018/6/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (AXKit)

/**
 通过UILabel 设置站位文字
 
 @param aText 文字
 @param aColor 颜色
 */
- (void)ax_setPlaceholder:(NSString*)aText color:(UIColor*)aColor;

/**
 最长输入文字数量
 */
- (BOOL)ax_textView:(UITextView*)textView
      maxTextLength:(NSUInteger)count
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString*)text;

@end
