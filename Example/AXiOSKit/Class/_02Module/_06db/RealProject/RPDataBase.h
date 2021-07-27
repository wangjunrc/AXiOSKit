//
//  RPDataBase.h
//  RealmDemo
//
//  Created by xiongan on 2017/7/28.
//  Copyright © 2017年 xiongan. All rights reserved.
//
#if __has_include(<Realm/Realm.h>)
#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RPDataBase : RLMRealm
+ (RPDataBase *)db;
+ (void)dataBaseMigration;
+ (BOOL)dropRealmIfNeed;
@end
#endif
