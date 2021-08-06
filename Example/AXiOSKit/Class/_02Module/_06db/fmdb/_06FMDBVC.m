//
//  _06FMDBVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/29.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_06FMDBVC.h"
#import <AXiOSKit/AXDataBase.h>
#import <MJExtension/MJExtension.h>
#import "NHDBEngine.h"

@interface _06FMDBVC ()


@end

@implementation _06FMDBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self _dividerLabel:@"线程安全并且数据库加密"];
    
    [self _buttonTitle:@"创建数据库" handler:^(UIButton * _Nonnull btn) {
        //线程安全并且数据库加密
        [NHDBEngine share];
    }];
    
    
    [self _buttonTitle:@"加密,insert数据" handler:^(UIButton * _Nonnull btn) {
        NSString *n_id = [NSString stringWithFormat:@"%d",1];
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:n_id,@"infoid",@"something that test !",@"info",@"2016-02-17 13:03:03",@"time", nil];
        [[NHDBEngine share] saveInfo:info];
        
    }];
    
    [self _buttonTitle:@"加密,get数据" handler:^(UIButton * _Nonnull btn) {
        
        id dict =[[NHDBEngine share] getInfo];
        NSLog(@"加密,get数据:%@",dict);
        
    }];
    
    [self _dividerLabel:@"未加密数据库"];
    AXDataBase.shared.dbName = @"test";
    
    [self _buttonTitle:@"建表" handler:^(UIButton * _Nonnull btn) {
        __block BOOL ret1 = NO;
        
        [AXDataBase.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            {
                
                NSString *sql = @"CREATE TABLE IF NOT EXISTS\
                t_user(\
                id INTEGER PRIMARY KEY,\
                name VARCHAR,\
                age INTEGER);";
                NSLog(@"sql=%@",sql);
                BOOL success =  [db executeUpdate:sql];
                NSLog(@"创建表=%@",success ? @"成功" : @"失败");
                if (!success) {
                    *rollback = YES;
                    return;
                }
            }
            {
                
                NSString *sql = @"CREATE TABLE IF NOT EXISTS\
                t_user2(\
                id INTEGER,\
                name VARCHAR,\
                age INTEGER);";
                NSLog(@"sql=%@",sql);
                BOOL success =  [db executeUpdate:sql];
                NSLog(@"创建表=%@",success ? @"成功" : @"失败");
                if (!success) {
                    *rollback = YES;
                    return;
                }
            }
            
            {
                
                NSString *sql = @"CREATE TABLE IF NOT EXISTS\
                t_person (\
                id INTEGER PRIMARY KEY AUTOINCREMENT,\
                name VARCHAR,\
                age INTEGER);";
                NSLog(@"sql=%@",sql);
                BOOL success =  [db executeUpdate:sql];
                NSLog(@"创建表=%@",success ? @"成功" : @"失败");
                if (!success) {
                    *rollback = YES;
                    return;
                }
            }
            
            ret1 = YES;
        }];
        
        NSLog(@"建表,t_user=%@",ret1 ? @"成功" : @"失败");
        
    }];
    [self _buttonTitle:@"插入,t_user,普通主键" handler:^(UIButton * _Nonnull btn) {
        
        __block BOOL success = NO;
        [AXDataBase.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSDictionary *dict = @{
                @"id":@(6),
                @"name" : @"tom",
                @"age" : @(10)
            };
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ ( %@ ) VALUES ('%@');",@"t_user",[dict.allKeys componentsJoinedByString:@","],[dict.allValues componentsJoinedByString:@"','"]];
            NSLog(@"插入,t_usersql=%@",sql);
            NSError *error;
            success = [db executeUpdate:sql withErrorAndBindings:&error];
            if (error) {
                NSLog(@"Error = %@",error.localizedDescription);
            }
        }];
        NSLog(@"插入,t_user=%@",success ? @"成功" : @"失败");
        
    }];
    
    [self _buttonTitle:@"插入,t_user2,无主键,withParameterDictionary" handler:^(UIButton * _Nonnull btn) {
        
        __block BOOL success = NO;
        [AXDataBase.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSDictionary *dict = @{
                
                @"age" : @(10),
                @"id":@(7),
                @"name" : @"tom",
            };
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ values (:id, :name,:age );",@"t_user2"];
            NSLog(@"插入,t_usersql=%@",sql);
            NSError *error;
            success = [db executeUpdate:sql withParameterDictionary:dict];
            
            if (error) {
                NSLog(@"Error = %@",error.localizedDescription);
            }
        }];
        NSLog(@"插入,t_user2=%@",success ? @"成功" : @"失败");
        
    }];
    
    [self _buttonTitle:@"select t_user2 ,withParameterDictionary" handler:^(UIButton * _Nonnull btn) {
        
        NSMutableArray *arr = NSMutableArray.array;
        [AXDataBase.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSDictionary *dict = @{
                @"id":@(7),
                @"age" : @(12),
                
                @"name" : @"tom",
            };
            
            FMResultSet *result = [db executeQuery:@"select * from t_user2 where id = :id" withParameterDictionary:dict];
            while ([result next]) {
                NSMutableDictionary *dict = NSMutableDictionary.dictionary;
                [result.columnNameToIndexMap.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
                    dict[key] = [result objectForColumn:key];
                }];
                [arr addObject:dict];
            }
            
        }];
        NSLog(@"select t_user2=%@",arr);
        
    }];
    
    
    [self _buttonTitle:@"UPDATE,t_user,普通主键,withParameterDictionary" handler:^(UIButton * _Nonnull btn) {
        
        __block BOOL success = NO;
        [AXDataBase.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSDictionary *dict = @{
                @"age" : @(12),
                @"id":@(7),
                @"name" : @"tom",
            };
            
            NSString *sql = [NSString stringWithFormat:@"UPDATE  %@ SET id=:id, name=:name,age=:age where id=:id;",@"t_user2"];
            NSLog(@"插入,t_usersql=%@",sql);
            NSError *error;
            success = [db executeUpdate:sql withParameterDictionary:dict];
            
            if (error) {
                NSLog(@"Error = %@",error.localizedDescription);
            }
        }];
        NSLog(@"UPDATE,t_user=%@",success ? @"成功" : @"失败");
        
    }];
    
    
    [self _buttonTitle:@"不存在插入，存在更新语句,replace" handler:^(UIButton * _Nonnull btn) {
        
        __block BOOL success = NO;
        [AXDataBase.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSDictionary *dict = @{
                @"id":@(2),
                @"name" : [NSString stringWithFormat:@"tom_%d",ax_randomZeroToValue(10)],
                @"age" : @(10)
            };
            
            NSString *sql = [NSString stringWithFormat:@"replace INTO %@ ( %@ ) VALUES ('%@');",@"t_user",[dict.allKeys componentsJoinedByString:@","],[dict.allValues componentsJoinedByString:@"','"]];
            NSLog(@"插入,t_usersql=%@",sql);
            NSError *error;
            success = [db executeUpdate:sql withErrorAndBindings:&error];
            if (error) {
                NSLog(@"Error = %@",error.localizedDescription);
            }
        }];
        NSLog(@"插入,t_user=%@",success ? @"成功" : @"失败");
        
    }];
    
    
    
    
    [self _buttonTitle:@"插入,t_person,自增主键" handler:^(UIButton * _Nonnull btn) {
        
        __block BOOL success = NO;
        [AXDataBase.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSDictionary *dict = @{
                @"name" : [NSString stringWithFormat:@"tom_%d",ax_randomZeroToValue(10)],
                @"age" : @(10)
            };
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ ( %@ ) VALUES ('%@');",@"t_person",[dict.allKeys componentsJoinedByString:@","],[dict.allValues componentsJoinedByString:@"','"]];
            NSLog(@"插入,t_usersql=%@",sql);
            NSError *error;
            success = [db executeUpdate:sql withErrorAndBindings:&error];
            if (error) {
                NSLog(@"Error = %@",error.localizedDescription);
            }
        }];
        NSLog(@"插入,t_person=%@",success ? @"成功" : @"失败");
        
    }];
    
    
    [self _buttonTitle:@"插入,t_person,获得最后主键,需要打开链接" handler:^(UIButton * _Nonnull btn) {
        
        [AXDataBase.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            //          int Id = [db intForQuery:@"select top 1 id from t_person"];
            int64_t Id =  [db lastInsertRowId];
            NSLog(@"最后主键=%lld",Id);
            
            
        }];
        
        
    }];
    
    [self _buttonTitle:@"插入,t_person,获得最后主键 limit 1" handler:^(UIButton * _Nonnull btn) {
        /// https://blog.csdn.net/u010214802/article/details/94137332?utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-1.control
        
        
        [AXDataBase.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            {   int Id = [db intForQuery:@"select * from t_person where id = (select max(id) from t_person);"];
                
                NSLog(@"最后主键a=%d",Id);}
            
            {   int Id = [db intForQuery:@"select * from t_person order by id desc limit 1;"];
                
                NSLog(@"最后主键b=%d",Id);}
            {   int Id = [db intForQuery:@"select * from t_person where id = (select last_insert_id());"];
                
                NSLog(@"最后主键,last_insert_id 需要链接才有效=%d",Id);}
            
        }];
    }];
    
    
    
    [self _lastLoadBottomAttribute];
    
    
}

@end
