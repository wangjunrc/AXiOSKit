//
//  AXUserInfoDao.m
//  macOS_demo
//
//  Created by 小星星吃KFC on 2020/10/15.
//

#import "AXUserInfoDao.h"
#import <WCDB/WCDB.h>
#import "AXUserInfo+DB.h"

static NSString *const DBTableName = @"t_user_info";

@interface AXUserInfoDao ()

@property (nonatomic, strong) WCTDatabase *dataBase;
@property (nonatomic, strong) WCTTable    *table;


@end

@implementation AXUserInfoDao

axShared_M(Dao);

#pragma mark - Insert
- (BOOL)insertWithModel:(AXUserInfo *)model {
    model.isAutoIncrement = YES;
    return [self.table insertObject:model];
}

#pragma mark - Update
- (BOOL)updateWithModel:(AXUserInfo *)model {
    return [self.table updateRowsOnProperties:AXUserInfo.AllProperties
                               withObject:model
                                    where:AXUserInfo.userId == model.userId];
}

//插入或者更新,内部判断
- (BOOL)insertOrUpdateWithModel:(AXUserInfo *)model{
    
//    AXUserInfo *getModel = [self getOneById:model.userId];
//    getModel.isAutoIncrement = YES;
//    if (!getModel) {
//      return  [self insertWithModel:model];
//    }else{
//        return [self updateWithModel:model];
//    }
    if (model.userId==0) {
        model.isAutoIncrement = YES;
    }
    return [self.table insertOrReplaceObject:model];
}



#pragma mark - Delete
- (BOOL)deletWithModel:(AXUserInfo *)model {
    return [self.table deleteObjectsWhere:AXUserInfo.userId == model.userId];
}
- (BOOL)deletAllData {
    return [self.table deleteAllObjects];
}

#pragma mark - Select
- (NSArray *)getAllByOrder {
    return [self.table getObjectsOrderBy:AXUserInfo.userId.order(WCTOrderedDescending)];
}
- (NSArray *)getAll {
    return [self.table getAllObjects];
}

- (AXUserInfo *)getOneById:(NSInteger )Id {
    return [self.table getObjectsWhere:AXUserInfo.userId == Id].firstObject;;
}


- (WCTDatabase *)dataBase{
    if (!_dataBase) {
      NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES ).firstObject;
        path = [path  stringByAppendingPathComponent:@"db/my.sqlite"];
        
        NSLog(@"ba_db_document_path = %@",path);
        
        _dataBase = [[WCTDatabase alloc] initWithPath:path];
        [_dataBase createTableAndIndexesOfName:DBTableName withClass:AXUserInfo.class];
    }
    return _dataBase;
}

- (WCTTable *)table{
    if (!_table) {
        _table = [self.dataBase getTableOfName:DBTableName withClass:AXUserInfo.class];
    }
    return _table;
}

@end
