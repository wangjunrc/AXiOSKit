//
//  AXUserInfo+DB.h
//  macOS_demo
//
//  Created by 小星星吃KFC on 2020/10/15.
//

#import "AXUserInfo.h"
#import <WCDB/WCDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface AXUserInfo (DB)<WCTTableCoding>

WCDB_PROPERTY(userId)
WCDB_PROPERTY(name)
WCDB_PROPERTY(icon)
WCDB_PROPERTY(headUrl)
WCDB_PROPERTY(registerDate)
WCDB_PROPERTY(log)

@end

NS_ASSUME_NONNULL_END
