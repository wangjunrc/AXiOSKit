//
//  BAUserInfo.m
//  BigApple
//
//  Created by Mole Developer on 2016/10/27.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "BAUserInfo.h"


@implementation UserInfo
 MJExtensionCodingImplementation
@end

@implementation User
 MJExtensionCodingImplementation
@end

@implementation BAUserInfo
axShared_M(BAUserInfo);

//+(void)removeSharedBAUserInfo{
//    _instance = nil;
//    _onceToken = 0;
//}

//- (NSNumber *)login{
//    if (!_login) {
//        if (self.userInfo.mobile.length>0) {
//            _login = @(YES);
//        }else{
//            _login = @(NO);
//        }
//    }
//    return _login;
//}

#define axUserInfoKey @"axUserInfoKey"

+(void)saveSharedUserInfo{
    NSDictionary *dcit =[[BAUserInfo sharedBAUserInfo] mj_keyValues];
    [axUserDefaults setObject:dcit forKey:axUserInfoKey];
    axUserDefaultsSynchronize;
}

-(void)saveSharedUserInfo{
    NSDictionary *dcit =[[BAUserInfo sharedBAUserInfo] mj_keyValues];
    [axUserDefaults setObject:dcit forKey:axUserInfoKey];
    axUserDefaultsSynchronize;
}

+(instancetype )getSaveSharedUserInfo{
    NSDictionary *dcit =[axUserDefaults objectForKey:axUserInfoKey];
    BAUserInfo *userInfo = [BAUserInfo mj_objectWithKeyValues:dcit];
    
    
    //打开CoreData
//    [MagicalRecord setupCoreDataStackWithStoreNamed:[NSString stringWithFormat:@"%@.sqlite", userInfo.user.userId]];
    
    return userInfo;
}

+(void)removeSharedUserInfo{
    [axUserDefaults removeObjectForKey:axUserInfoKey];
    axUserDefaultsSynchronize;
    _instance = nil;
    _onceToken = 0;
}


@end
