//
//  NSArray+AXTool.h
//  
//
//  Created by liuweixing on 15/11/18.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (AXTool)

/**
 NSArray转换json字串
 */
-(NSString *)ax_toJson;

/**
 * 0-9 a-z A-Z 集合
 */
+(NSArray *)ax_numbernAndAlphabet;

@end
