//
//  UIColor+AXTool.m
//  AXTools
//
//  Created by Mole Developer on 16/6/3.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "UIColor+AXTool.h"

@implementation UIColor (AXTool)
/**
 * 输入16进制颜色 格式为: 0xaabbcc
 */
+(UIColor *)ax_colorFrom16RGB:(int)rgbValue{
    return  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1];
}

/**
 * 直接输入0~225的数字
 */
+(UIColor *)ax_colorRed:(int)r green:(int)g blue:(int)b{
    return  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
}

/**
 * 随机色
 */
+(UIColor *)ax_randomColor{
    
    CGFloat red = arc4random() % 256 / 256.0 ;
    
    CGFloat green = arc4random() % 256 / 256.0;
    
    CGFloat blue = arc4random() % 256 / 256.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}
@end
