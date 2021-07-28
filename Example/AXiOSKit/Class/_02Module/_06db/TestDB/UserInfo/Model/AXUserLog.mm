//
//  AXUserIp.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/11/17.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AXUserLog.h"
#import <WCDB/WCDB.h>
#import "AXUserLog+DB.h"
#import <MJExtension/MJExtension.h>
@interface AXUserLog ()<WCTColumnCoding>

@end

@implementation AXUserLog

WCDB_IMPLEMENTATION(AXUserLog);


+ (instancetype)unarchiveWithWCTValue:(NSString *)value
{
    if (value) {
        AXUserLog *user = [AXUserLog mj_objectWithKeyValues:value];
        return user;
    }
    return nil;
}

- (NSString *)archivedWCTValue
{
    return [self mj_JSONString];
}

+ (WCTColumnType)columnTypeForWCDB
{
    return WCTColumnTypeString;
}

@end
