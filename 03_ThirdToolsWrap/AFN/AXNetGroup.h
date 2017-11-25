//
//  AXNetGroup.h
//  BigApple
//
//  Created by Mole Developer on 2017/11/15.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

<<<<<<< HEAD
/**
 * 参数 封装对象
 */
=======
>>>>>>> 655b48996deb59798bf9bc6956a24f7ed81fe4ec
@interface AXNetGroup : NSObject
/**
 * url
 */
@property (nonatomic, copy) NSString *url;

/**
 * 参数
 */
@property (nonatomic, strong)NSMutableDictionary  *parameter;

@end

<<<<<<< HEAD
/**
 * 返回结果,封装对象
 */
=======

>>>>>>> 655b48996deb59798bf9bc6956a24f7ed81fe4ec
@interface AXNetGroupResult : NSObject
/**
 * url
 */
@property (nonatomic, copy) NSString *url;

/**
 * 当前请求 是否成功
 */
@property (nonatomic, assign,getter=isSuccess) BOOL success;

/**
 * 状态
 */
@property (nonatomic, assign) NSInteger state;

/**
 * 返回内容
 */
@property (nonatomic, strong)id  json;

@end
