//
//  DataBase.m
//  FMDB
//
//  Created by liuweixing on 16/4/5.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXDataBase.h"
//#if __has_include("FMDB.h")

#import "AXSQLStatement.h"
#import "AXEncryptDatabaseQueue.h"

@interface AXDataBase()

@property (nonatomic, strong,readwrite)AXEncryptDatabaseQueue *dbQueue;

@property (nonatomic, copy) NSString *dbPath;

@end

@implementation AXDataBase

AX_SINGLETON_IMPL()

+ (AXEncryptDatabaseQueue *)dbQueue {
    return AXDataBase.shared.dbQueue;
}

- (AXEncryptDatabaseQueue *)dbQueue {
    if (!_dbQueue || !self.dbPath) {
        
        NSString *name = @"IMDB";
        if (self.dbName) {
            name = self.dbName;
        }
        self.dbPath = [self dbPathWithName:name];
        //        _fmdbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
        
        _dbQueue = [AXEncryptDatabaseQueue databaseQueueWithPath:self.dbPath];
    }
    return _dbQueue;
}




- (void)setDbName:(NSString *)dbName {
    self.dbPath = nil;
//    self.dbQueue = nil;
    _dbName = dbName;
}

/**
 * 创建数据库路径
 */
-(NSString *)dbPathWithName:(NSString *)baseName{
    
    //拼接路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES).firstObject;
    NSString *pathComponent = [NSString stringWithFormat:@"%@.sqlite",baseName];
    NSString *dbPath = [docPath stringByAppendingPathComponent:pathComponent];
    
    //判断文件夹路径是否存在
    NSString *deletingLastPath = [dbPath  stringByDeletingLastPathComponent];
    if (![[NSFileManager defaultManager] fileExistsAtPath:deletingLastPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:deletingLastPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    NSLog(@"dbPath--> %@",dbPath);
    return dbPath;
}


@end

//#endif
