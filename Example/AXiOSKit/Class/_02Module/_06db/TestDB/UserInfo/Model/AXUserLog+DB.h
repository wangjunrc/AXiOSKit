//
//  AXUserLog+DB.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/17.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AXUserLog.h"
#import <WCDB/WCDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface AXUserLog (DB)<WCTTableCoding>

WCDB_PROPERTY(logId)
WCDB_PROPERTY(ip)
WCDB_PROPERTY(address)

@end

NS_ASSUME_NONNULL_END
