//
//  DBFunctionProtocol.h
//  BigApple
//
//  Created by Mac Mini on 2018/1/18.
//  Copyright © 2018年 MoleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DBFunctionProtocol <NSObject>

/**
 * insert
 */
- (BOOL)insertWithModel:( id )model;


/**
 * delet
 */
- (BOOL)deletWithModel:( id )model;
- (BOOL)deletAllData;

/**
 * update
 */
- (BOOL)updateWithModel:( id )model;

/**
 * 插入或者更新,内部判断
 */
- (BOOL)insertOrUpdateWithModel:( id )model;

/**
 * select
 */
- (NSArray *)getAll;
- (NSArray *)getAllByOrder;

- (id )getOneById:(NSInteger )Id;

@end
