//
//  DataBase.h
//  FMDB
//
//  Created by liuweixing on 16/4/5.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

//#if __has_include("FMDB.h")

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "AXMacros_instance.h"
/**
 使用 FMDatabaseQueue [dataQueue inDatabase:^(FMDatabase *db){}];
 线程安全的
 */

@interface AXDataBase : NSObject

AX_SINGLETON_INTER()

@property (nonatomic, strong,readonly,class)FMDatabaseQueue *dbQueue;


/// 数据库名称
@property (nonatomic, copy) NSString *dbName;

@property (nonatomic, copy,readonly) NSString *dbPath;


@end


//#endif
