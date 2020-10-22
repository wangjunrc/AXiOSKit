//
//  NSString+AXCrypto.h
//  BigApple
//
//  Created by liuweixing on 2016/12/1.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AXCrypto)

/**
 * string加密 to Base64String
 */
- (NSString *)ax_stringToBase64String;

/**
 * Base64String解密 to string
 */
- (NSString *)ax_base64StringToString;

/**
 * MD5加密_普通算法,结果为大写,
 */
- (NSString *)ax_MD5;

/**
 * DES 加密
 */
- (NSString *)ax_encryptDESWithKey:(NSString *)key;

/**
 *  DES 解密
 */
- (NSString*)ax_decryptDESWithKey:(NSString*)key;

/**
 * hmacSha1 加密
 */
- (NSString *)ax_hmacSha1:(NSString*)key;

/**
 * 对publickey和privatekey进行加密
 */
- (NSString *)ax_hmacSha1:(NSString*)public_key private_key:(NSString*)private_key;

/**
 * DES 加密 Base64
 */
- (NSString *)ax_encryptDESBase64WithKey:(NSString *)key;

/**
 * DES  解密 Base64
 */
- (NSString*)ax_decryptDESBase64WithKey:(NSString *)key;

/**
 *加密 3DES
 */
- (NSString *)ax_encrypt3DESWithKey:(NSString *)key;

/**
 * 解密 3DES
 */
- (NSString *)ax_decrypt3DESWithKey:(NSString *)key;


@end
