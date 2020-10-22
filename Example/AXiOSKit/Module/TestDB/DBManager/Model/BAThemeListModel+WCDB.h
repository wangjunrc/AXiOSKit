//
//  BAThemeListModel+WCDB.h
//  BigApple
//
//  Created by liuweixing on 2018/1/17.
//  Copyright © 2018年 MoleDeveloper. All rights reserved.
//

#import "BAThemeListModel.h"
#import <WCDB/WCDB.h>

@interface BAThemeListModel (WCDB)<WCTTableCoding>

#pragma mark - 声明需要绑定到数据库表的字段

WCDB_PROPERTY(resourceId)
WCDB_PROPERTY(name)
WCDB_PROPERTY(playTime)
WCDB_PROPERTY(date)

@end
