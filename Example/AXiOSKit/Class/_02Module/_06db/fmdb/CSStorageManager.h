//
//  CSStorageManager.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/29.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

@import FMDB;


NS_ASSUME_NONNULL_BEGIN

@class DBStudent;

/// 数据库存储
@interface CSStorageManager : NSObject

+ (instancetype)sharedManager;

-(BOOL)initDatabase;

@property(nonatomic,strong,readonly)FMDatabaseQueue *dbQueue;

@end


NS_ASSUME_NONNULL_END
