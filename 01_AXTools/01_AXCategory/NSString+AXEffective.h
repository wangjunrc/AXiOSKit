//
//  NSString+AXEffective.h
//  Financing118
//
//  Created by Mole Developer on 16/2/18.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AXEffective)
/**
 * 是否邮箱
 */
-(BOOL)ax_isEmail;

/**
 * 是否URL,URL包含https://或者http://
 */
-(BOOL)ax_isURL;

/**
 * 匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)
 */
-(BOOL)ax_isAccount;

/**
 * 匹配国内电话号码 形式如 0511-4405222
 */
-(BOOL)ax_isTelephone;

/**
 * 中国三大电信运营商手机号
 */
-(BOOL)ax_isChinaPhoneNumber;

/**
 * 匹配身份证 中国的身份证为15位或18位 含有X
 */
-(BOOL)ax_isIdentityCard;

/**
 * 英文或者数字
 */
-(BOOL)ax_isAlphabetOrNumber;

/**
 * 只能是数字
 */
-(BOOL)ax_isNumber;

/**
 * 正数(包含0 正数 小数)
 */
-(BOOL)ax_isPositive;

/**
 * 整数
 */
-(BOOL)ax_isInt;

/**
 * 正整数包含0
 */
-(BOOL)ax_isPositiveInt;

/**
 * 负整数
 */
-(BOOL)ax_isNegativeInt;

/**
 * 浮点数
 */
-(BOOL)ax_isFloat;

/**
 * 正浮点数
 */
-(BOOL)ax_isPositiveFloat;

/**
 * 正浮点数2位有效数字
 */
-(BOOL)ax_isPositive2Float;

/**
 * 负浮点数
 */
-(BOOL)ax_isNegativeFloat;

@end
