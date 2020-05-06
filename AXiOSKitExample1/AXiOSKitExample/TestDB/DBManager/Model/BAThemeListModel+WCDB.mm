//
//  BAThemeListModel+WCDB.m
//  BigApple
//
//  Created by liuweixing on 2018/1/17.
//  Copyright © 2018年 MoleDeveloper. All rights reserved.
//

#import "BAThemeListModel+WCDB.h"

@implementation BAThemeListModel (WCDB)

#pragma mark - 定义绑定到数据库表的类
WCDB_IMPLEMENTATION(BAThemeListModel)


#pragma mark - 设置主键
WCDB_PRIMARY(BAThemeListModel, resourceId)

#pragma mark - 定义需要绑定到数据库表的字段
WCDB_SYNTHESIZE(BAThemeListModel, resourceId)
WCDB_SYNTHESIZE(BAThemeListModel, name)
WCDB_SYNTHESIZE(BAThemeListModel, playTime)
WCDB_SYNTHESIZE(BAThemeListModel, date)


#pragma mark - 设置索引
//WCDB_INDEX(WPUserModel, "_index", age)



@end
