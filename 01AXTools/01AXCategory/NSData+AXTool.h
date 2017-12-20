//
//  NSData+AXTool.h
//  AXTools
//
//  Created by Mole Developer on 16/8/10.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AXTool)

/**
 * NSData 进行 Base64
 */
-(NSString *)ax_toBase64;
/**
 *  NSData json解析
 */
-(id)ax_formJSON;

/**
 * 二进制转化为十六进制
 */
-(NSString *)ax_dataToHexString;

@end
