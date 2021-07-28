//
//  CSStorageManager.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/29.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "CSStorageManager.h"
@import FMDB;
@import SQLCipher;

@interface CSStorageManager()

@property(nonatomic,strong,readwrite)FMDatabaseQueue *dbQueue;

@end

@implementation CSStorageManager

static CSStorageManager *_instance = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CSStorageManager alloc] init];
//        [_instance initial];
    });
    return _instance;
}

- (void)initial {
    __unused BOOL result = [self initDatabase];  // 创建数据库
//    NSAssert(result, @"创建数据库失败");
}




/**
 Init database.
 */
- (BOOL)initDatabase {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    doc = [doc stringByAppendingPathComponent:@"db"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:doc]) {
        NSError *error;
        [[NSFileManager  defaultManager] createDirectoryAtPath:doc withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"error = %@",error.description);
        }
        NSAssert(!error, error.description);
    }
    NSString *filePath = [doc stringByAppendingPathComponent:@"test.db"];
    
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
    __block BOOL ret1 = NO;
    
//    NSString *sqlFile = [[NSBundle mainBundle] pathForResource:@"test_fmdb" ofType:@"sql"];
//    NSString *sqls = [NSString stringWithContentsOfFile:sqlFile encoding:NSUTF8StringEncoding error:nil];
//
//    NSArray<NSString *> *sqlArray = [sqls componentsSeparatedByString:@"|"];
//    NSLog(@"sqlArray=%@",sqlArray);
    
    
    
    
    [_dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
//        [db setKey:@"a123"];
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
    
    
    return ret1;
}



@end
