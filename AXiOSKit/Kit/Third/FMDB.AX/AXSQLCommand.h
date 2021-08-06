//
//  AXSQLCommand.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/8/5.
//

/**
 查询空值
 SELECT * FROM Person WHERE id1 is NULL
 
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NSString const* AXSQLFieldType;
//
///// string
static AXSQLFieldType AXSQLFieldTypeString  = @"TEXT";
/// int
static AXSQLFieldType AXSQLFieldTypeInt  = @"INTEGER";
/// data
static AXSQLFieldType AXSQLFieldTypeData  = @"BLOB";
static AXSQLFieldType AXSQLFieldTypeReal  = @"REAL";
static AXSQLFieldType AXSQLFieldTypeNumeric  = @"NUMERIC";


@protocol AXSQLCommand <NSObject>

@required
#pragma mark - create

/// 创建表 不含有主键
/// @param table 表名
/// @param field @{@"age":AXSQLFieldTypeInt}
+(NSString *)createWithTable:(NSString*)table
                       field:(NSDictionary<NSString*,AXSQLFieldType> *)field;

/// 创建表 不含有主键
/// @param table 表名
/// @param field @{@"age":AXSQLFieldTypeInt}
/// @param key 主键
+(NSString *)createWithTable:(NSString*)table
                       field:(NSDictionary<NSString*,AXSQLFieldType> *)field
                         key:(NSString *)key;

#pragma mark - insert

/**
 * 插入数据  无判断条件
 */
+(NSString *)insertWithTable:(NSString *)table
                      values:(NSDictionary *)values;

/// 主键不存在插入,存在就更新,必须有主键
/// @param table 表名
/// @param values 值
+(NSString *)replaceWithTable:(NSString *)table
                       values:(NSDictionary *)values;



/// 不存在,再插入,存在不变化
/// @param table 表名
/// @param values 需要插入的内容
/// @param wheres 是否存在的 @{@"id1=":@"1",@"id2=":@"1"} 可以要含有符号
+(NSString *)insertNotExistsWithTable:(NSString *)table
                               values:(NSDictionary<NSString*,id> *)values
                               wheres:(NSDictionary<NSString*,id> *)wheres;

#pragma mark - delete

/// 清除表内容
/// @param table 表名
/// @param values 指定条件
+(NSString *)deleteWithTable:(NSString *)table
                      values:(NSDictionary *)values;

/**
 * 删除表
 */
+(NSString *)dropWithTable:(NSString *)tableName;

#pragma mark - update
/**
 * 修改语句
 */
+(NSString *)updateWithTable:(NSString *)tableName
                      values:(NSDictionary<NSString*,id> *)values
                      wheres:(NSDictionary *)wheres;

/**
 * 查询 最后几条 语句
 */
+(NSString *)selectCountWithTable:(NSString *)tableName
                            count:(NSUInteger )count;

///  查询 语句
/// @param table 表名
/// @param fields 返回需要的字段
/// @param wheres 条件
+(NSString *)selectWithTable:(NSString *)table
                      fields:(NSArray <NSString *>* _Nullable)fields
                      wheres:(NSDictionary<NSString*,id> *_Nullable)wheres;

/**
 * 查询表 数据数量
 */
+(NSString *)selectCountWithTable:(NSString *)tableName;


@end

NS_ASSUME_NONNULL_END
