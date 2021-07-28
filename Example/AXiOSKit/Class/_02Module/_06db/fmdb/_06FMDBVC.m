//
//  _06FMDBVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/29.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_06FMDBVC.h"
#import <AXiOSKit/AXDataBase.h>
#import "CSStorageManager.h"
#import <MJExtension/MJExtension.h>
#import "NHDBEngine.h"

@interface _06FMDBVC ()

@property(nonatomic,strong)AXDataBase *dataBase;
@end

@implementation _06FMDBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _buttonTitle:@"创建数据库" handler:^(UIButton * _Nonnull btn) {
        self.dataBase = [AXDataBase dataBaseWithName:@"test"];
    }];
    
    [self _buttonTitle:@"创建数据库" handler:^(UIButton * _Nonnull btn) {
        
        [self.dataBase createTable:@"t_user" field:@{@"name":NSString.class,@"age":NSNumber.class}];
        
    }];
    
    [self _buttonTitle:@"创建数据库" handler:^(UIButton * _Nonnull btn) {
        
        [self.dataBase insertDataTable:@"t_user" content:@{@"name":@"jim",@"age":@(20)}];
        
    }];
    
    
    
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
    
    [self _buttonTitle:@"插入,t_user,普通主键" handler:^(UIButton * _Nonnull btn) {
        
        __block BOOL success = NO;
        [CSStorageManager.sharedManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
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
    
    [self _buttonTitle:@"不存在插入，存在更新语句,replace" handler:^(UIButton * _Nonnull btn) {
        
        __block BOOL success = NO;
        [CSStorageManager.sharedManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
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
        [CSStorageManager.sharedManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
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
        
        [CSStorageManager.sharedManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            //          int Id = [db intForQuery:@"select top 1 id from t_person"];
            int64_t Id =  [db lastInsertRowId];
            NSLog(@"最后主键=%lld",Id);
            
            
        }];
        
        
    }];
    
    [self _buttonTitle:@"插入,t_person,获得最后主键 limit 1" handler:^(UIButton * _Nonnull btn) {
        /// https://blog.csdn.net/u010214802/article/details/94137332?utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-1.control
        
        
        [CSStorageManager.sharedManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
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
