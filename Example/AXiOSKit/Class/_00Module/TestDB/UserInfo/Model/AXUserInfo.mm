//
//  AXUserInfo.m
//  macOS_demo
//
//  Created by 小星星吃KFC on 2020/10/15.
//

#import "AXUserInfo.h"
#import <WCDB/WCDB.h>
#import "AXUserInfo+DB.h"

@implementation AXUserInfo
/**
 https://github.com/Tencent/wcdb/wiki/ORM%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B#%E8%A1%A8%E7%BA%A6%E6%9D%9F
 
 
 表约束

     多主键约束以WCDB_MULTI_PRIMARY开头，定义了数据库的多主键，支持自定义每个主键的排序方式。
         WCDB_MULTI_PRIMARY(className, constraintName, propertyName)是最基本的用法，与索引类似，多个主键通过constraintName匹配。
         WCDB_MULTI_PRIMARY_ASC(className, constraintName, propertyName)定义了多主键propertyName对应的主键升序。
         WCDB_MULTI_PRIMARY_DESC(className, constraintName, propertyName)定义了多主键中propertyName对应的主键降序。
     多字段唯一约束以WCDB_MULTI_UNIQUE开头，定义了数据库的多字段组合唯一，支持自定义每个字段的排序方式。
         WCDB_MULTI_UNIQUE(className, constraintName, propertyName)是最基本的用法，与索引类似，多个字段通过constraintName匹配。
         WCDB_MULTI_UNIQUE_ASC(className, constraintName, propertyName)定义了多字段中propertyName对应的字段升序。
         WCDB_MULTI_UNIQUE_DESC(className, constraintName, propertyName)定义了多字段中propertyName对应的字段降序。
         
 
 字段约束

     主键约束以WCDB_PRIMARY开头，定义了数据库的主键，支持自定义主键的排序方式、是否自增。
         WCDB_PRIMARY(className, propertyName)是最基本的用法，它直接使用propertyName作为数据库主键。
         WCDB_PRIMARY_ASC(className, propertyName)定义主键升序。
         WCDB_PRIMARY_DESC(className, propertyName)定义主键降序。
         WCDB_PRIMARY_AUTO_INCREMENT(className, propertyName)定义主键自增。
         WCDB_PRIMARY_ASC_AUTO_INCREMENT(className, propertyName)是主键自增和升序的组合。
         WCDB_PRIMARY_DESC_AUTO_INCREMENT(className, propertyName)是主键自增和降序的组合。
     非空约束为WCDB_NOT_NULL(className, propertyName)，当该字段插入数据为空时，数据库会返回错误。
     唯一约束为WCDB_UNIQUE(className, propertyName)，当该字段插入数据与其他列冲突时，数据库会返回错误。

 
 */

#pragma mark - 定义绑定到数据库表的类
/// WCDB_IMPLEMENTATION，用于在类文件中定义绑定到数据库表的类
WCDB_IMPLEMENTATION(AXUserInfo)

#pragma mark - 设置主键
//WCDB_PRIMARY(AXUserInfo, userId)
/// 自增,需要在model .mm文件定义,在分类定义报错
WCDB_PRIMARY_ASC_AUTO_INCREMENT(AXUserInfo, userId)

#pragma mark - 定义需要绑定到数据库表的字段
//WCDB_SYNTHESIZE(AXUserInfo, userId)
/// 默认值
//WCDB_SYNTHESIZE_DEFAULT(AXUserInfo, userId,1)
//WCDB_SYNTHESIZE_COLUMN(AXUserInfo, userId, id)

WCDB_SYNTHESIZE_COLUMN_DEFAULT(AXUserInfo, userId, "id", 1)
WCDB_SYNTHESIZE(AXUserInfo, name)
WCDB_NOT_NULL(AXUserInfo, name)
WCDB_SYNTHESIZE_DEFAULT(AXUserInfo, icon, @"")
WCDB_SYNTHESIZE(AXUserInfo, headUrl)
WCDB_SYNTHESIZE(AXUserInfo, registerDate)
WCDB_SYNTHESIZE(AXUserInfo, log)

@end
