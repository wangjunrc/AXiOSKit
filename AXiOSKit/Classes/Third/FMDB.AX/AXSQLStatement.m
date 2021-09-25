//
//  DBStatements.m
//  AXiOSKit
//
//  Created by liuweixing on 16/4/7.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXSQLStatement.h"

@implementation AXSQLStatement

#pragma mark - create

/// 创建表
/// @param table 表名
/// @param field @{@"age":AXSQLFieldTypeInt}
+(NSString *)createWithTable:(NSString*)table
                       field:(NSDictionary<NSString*,AXSQLFieldType> *)field {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [field enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, AXSQLFieldType  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"%@ %@",key,obj];
        [tempArray addObject:str];
    }];
    
    NSString *fieldStr = [tempArray componentsJoinedByString:@","];
    
    //新建表 IF NOT EXISTS
    NSString  *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ ( %@ )",table,fieldStr];
    NSLog(@"CREATE SQL = %@",sql);
    return sql;
}

/// 创建表 不含有主键
/// @param table 表名
/// @param field @{@"age":AXSQLFieldTypeInt}
/// @param key 主键
+(NSString *)createWithTable:(NSString*)table
                       field:(NSDictionary<NSString*,AXSQLFieldType> *)field
                         key:(NSString *)key {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [field enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, AXSQLFieldType  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"%@ %@",key,obj];
        [tempArray addObject:str];
    }];
    
    NSString *fieldStr = [tempArray componentsJoinedByString:@","];
    NSString  *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ ( %@ ,PRIMARY KEY (%@))",table,fieldStr,key];
    NSLog(@"CREATE SQL = %@",sql);
    return sql;
}

#pragma mark - insert
/**
 * 插入数据 语句
 */
+(NSString *)insertWithTable:(NSString *)table
                      values:(NSDictionary *)values {
    
    NSString *key = [values.allKeys componentsJoinedByString:@","];
    NSString *value = [values.allValues componentsJoinedByString:@"','"];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES ('%@')",table,key,value];
    NSLog(@"insert sql: %@",sql);
    return sql;
    
}

/// 主键不存在插入,存在就更新,必须有主键
/// @param table 表名
/// @param values 值
+(NSString *)replaceWithTable:(NSString *)table
                       values:(NSDictionary *)values {
    
    NSString *key = [values.allKeys componentsJoinedByString:@","];
    NSString *value = [values.allValues componentsJoinedByString:@"','"];
    
    NSString *sql = [NSString stringWithFormat:@"REPLACE INTO %@ (%@) VALUES ('%@')",table,key,value];
    NSLog(@"replac sql: %@",sql);
    return sql;
}


/// 不存在,再插入,存在不变化
/// @param table 表名
/// @param values 需要插入的内容
/// @param wheres 是否存在的 @{@"id1=":@"1",@"id2=":@"1"} 可以要含有符号
+(NSString *)insertNotExistsWithTable:(NSString *)table
                               values:(NSDictionary<NSString*,id> *)values
                               wheres:(NSDictionary<NSString*,id> *)wheres {
    
    // INSERT INTO Person (id1,id2,name1,age1) SELECT '1','4', 'tom1','10'
    // WHERE NOT EXISTS (SELECT 1 FROM Person WHERE id1= '1' AND id2= '4' )
    
    NSString *key = [values.allKeys componentsJoinedByString:@","];
    NSString *value = [values.allValues componentsJoinedByString:@"','"];
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT '%@'",table,key,value];
    
    NSMutableArray<NSString *> *exis_where = NSMutableArray.array;
    [wheres enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [exis_where addObject:[NSString stringWithFormat:@"%@'%@'",key,obj]];
    }];
    
    NSString *where = [exis_where componentsJoinedByString:@" AND "];
    NSString *existSql = [NSString stringWithFormat:
                          @"WHERE NOT EXISTS (SELECT 1 FROM %@ WHERE %@ )",
                          table,
                          where];
    NSString *sql = [NSString stringWithFormat:@"%@ %@",insertSql,existSql];
    NSLog(@"不存在,再插入 sql: %@",sql);
    return sql;
    
}

#pragma mark - delete

/// 清除表内容
/// @param table 表名
/// @param values 指定条件
+(NSString *)deleteWithTable:(NSString *)table
                      values:(NSDictionary *)values {
    
    if (values.count==0) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",table];
        NSLog(@"delete sql: %@",sql);
        return sql;
    }
    
    NSMutableArray<NSString *> *tempArray = [NSMutableArray array];
    [values enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [tempArray addObject:[NSString stringWithFormat:@"%@ = '%@'",key,obj]];
    }];
    
    NSString *tempStr = [tempArray componentsJoinedByString:@" AND "];
    NSString * sql = [NSString stringWithFormat:@"DELETE FROM  %@ WHERE %@",table,tempStr];
    NSLog(@"delete sql: %@",sql);
    return sql;
}

/**
 * 删除表
 */
+(NSString *)dropWithTable:(NSString *)table{
    
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@",table];
    NSLog(@"DROP sql: %@",sql);
    return sql;
}

#pragma mark - update
/**
 * 修改语句
 */
+(NSString *)updateWithTable:(NSString *)table
                      values:(NSDictionary<NSString*,id> *)values
                      wheres:(NSDictionary *)wheres {
    // UPDATE Person SET id2='21',  name1='tom_21'   WHERE id1='1' AND id2='2'
    
    //拼接 条件字段语句
    NSMutableArray *valuesArray = [NSMutableArray array];
    
    [values enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"%@ = '%@'",key,obj];
        [valuesArray addObject:str];
    }];
    
    NSString *valStr = [valuesArray componentsJoinedByString:@" , "];
    
    NSMutableArray *wheresArray = [NSMutableArray array];
    [wheres enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"%@ = '%@'",key,obj];
        [wheresArray addObject:str];
    }];
    NSString *where = [wheresArray componentsJoinedByString:@"AND "];
    
    NSString *sql = [NSString stringWithFormat:@"\
                     UPDATE\
                     %@ \
                     SET\
                     %@\
                     WHERE\
                     %@;",table,valStr,where];
    
    NSLog(@"UPDATE sql:\n%@",sql);
    return sql;
}


/**
 * 查询 最后几条 语句
 */
+(NSString *)selectCountWithTable:(NSString *)table
                            count:(NSUInteger )count {
    
    
    NSString * executeQuery = [NSString stringWithFormat:@"SELECT TOP %ld * FROM %@",(long)count,table];
    return executeQuery;
}

///  查询 语句
/// @param table 表名
/// @param fields 返回需要的字段
/// @param wheres 条件
+(NSString *)selectWithTable:(NSString *)table
                      fields:(NSArray <NSString *>*)fields
                      wheres:(NSDictionary<NSString*,id> *)wheres {
    
    NSString *executeQuery = nil;
    
    //拼接条件字段 key = 'value' AND key = 'value' 样式
    NSString *whereStr = nil;
    
    if (wheres != nil && wheres.count!=0) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSString *key in wheres) {
            
            NSString *str = [NSString stringWithFormat:@"%@ = '%@'",key,wheres[key]];
            [array addObject:str];
        }
        whereStr = [array componentsJoinedByString:@" AND "];
    }
    
    //拼接返回字段 key,key  样式
    NSString *fieldsStr = nil;
    if (fields != nil && fields.count!=0) {
        
        fieldsStr =[fields componentsJoinedByString:@" , "];
    }
    
    BOOL needBOOL = fields.count>0 ? YES :NO;
    BOOL contentBOOL = wheres.count>0 ? YES :NO;
    
    
    //所有数据
    if ( !needBOOL && !contentBOOL) {
        executeQuery = [NSString stringWithFormat:@"SELECT * FROM %@",table];
    }
    //查询条件,返回所有字段内容
    else if (!needBOOL && contentBOOL){
        
        executeQuery = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@",table,whereStr];
    }
    //不需要条件,返回指定字段内容
    else if ( needBOOL && !contentBOOL) {
        
        executeQuery = [NSString stringWithFormat:@"SELECT %@ FROM %@ ",fieldsStr,table];
    }
    //指定条件,指定内容
    else{
        
        executeQuery = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@",fieldsStr,table,whereStr];
    }
    
    return executeQuery;
}

/**
 * 查询表 数据数量
 */
+(NSString *)selectCountWithTable:(NSString *)table{
    
    return [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@",table];
}


@end

