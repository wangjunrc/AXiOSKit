//
//  PalyThemeDB.m
//  BigApple
//
//  Created by liuweixing on 2018/1/17.
//  Copyright © 2018年 MoleDeveloper. All rights reserved.
//

#import "PalyThemeDB.h"
#import "BAThemeListModel+WCDB.h"
#import <WCDB/WCDB.h>
#import "BAFileHeader.h"

static NSString *const DBTableName = @"paly_theme_table";

@interface PalyThemeDB ()

@property (nonatomic, strong) WCTDatabase *dataBase;
@property (nonatomic, strong) WCTTable    *PalyDBTable;


@end

@implementation PalyThemeDB

axShared_M(PalyThemeDB);

#pragma mark - Insert
- (BOOL)insertWithModel:(BAThemeListModel *)model {
    return [self.PalyDBTable insertObject:model];
}

#pragma mark - Update
- (BOOL)updateWithModel:(BAThemeListModel *)model {
    return [self.PalyDBTable updateRowsOnProperties:BAThemeListModel.AllProperties
                               withObject:model
                                    where:BAThemeListModel.resourceId == model.resourceId];
}

//插入或者更新,内部判断
- (BOOL)insertOrUpdateWithModel:(BAThemeListModel *)model{
    
    BAThemeListModel *getModel = [self getPalyDBWithId:model.resourceId];
    
    if (!getModel) {
      return  [self insertWithModel:model];
    }else{
        return [self updateWithModel:model];
    }
}



#pragma mark - Delete
- (BOOL)deletWithModel:(BAThemeListModel *)model {
    return [self.PalyDBTable deleteObjectsWhere:BAThemeListModel.resourceId == model.resourceId];
}
- (BOOL)deletAllData {
    return [self.PalyDBTable deleteAllObjects];
}

#pragma mark - Select

- (BAThemeListModel *)getPalyDBWithId:(NSString *)resourceId {
    return [self.PalyDBTable getObjectsWhere:BAThemeListModel.resourceId == resourceId].firstObject;
}

- (NSArray *)getAllByOrder {
    return [self.PalyDBTable getObjectsOrderBy:BAThemeListModel.playTime.order(WCTOrderedDescending)];
}
- (NSArray *)getAll {
    return [self.PalyDBTable getAllObjects];
}

- (WCTDatabase *)dataBase{
    if (!_dataBase) {
        NSLog(@"ba_db_document_path:%@",BA_DB_DOCUMENT_PATH);
        
        _dataBase = [[WCTDatabase alloc] initWithPath:BA_DB_DOCUMENT_PATH];
    }
    return _dataBase;
}

- (WCTTable *)PalyDBTable{
    if (!_PalyDBTable) {
        [self.dataBase createTableAndIndexesOfName:DBTableName withClass:BAThemeListModel.class];
        _PalyDBTable = [self.dataBase getTableOfName:DBTableName withClass:BAThemeListModel.class];
    }
    return _PalyDBTable;
}
@end
