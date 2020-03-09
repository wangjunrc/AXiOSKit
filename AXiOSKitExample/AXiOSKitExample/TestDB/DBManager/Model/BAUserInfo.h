//
//  BAUserInfo.h
//  BigApple
//
//  Created by Mole Developer on 2016/10/27.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AXiOSKit/AXiOSKit.h>

@interface UserInfo : NSObject
/**
 * <#注释#>
 */
@property (nonatomic, copy) NSString *mobile;
/**
 * <#注释#>
 */
@property (nonatomic, copy) NSString *nickName;
/**
 * <#注释#>
 */
@property (nonatomic, copy) NSString *userId;
/**
 * <#注释#>
 */
@property (nonatomic, copy) NSString *headIcon;

@end

@interface User : NSObject

/**
 * <#注释#>
 */
@property (nonatomic, copy) NSString *password;
/**
 * <#注释#>
 */
@property (nonatomic, copy) NSString *userType;
/**
 * <#注释#>
 */
@property (nonatomic, copy) NSString *userId;
/**
 * <#注释#>
 */
@property (nonatomic, copy) NSString *userName;

@end


@interface BAUserInfo : NSObject
axShared_H(BAUserInfo);
/**
 * <#注释#>
 */
@property (nonatomic, strong) UserInfo  *userInfo;
/**
 * <#注释#>
 */
@property (nonatomic, strong) User  *user;

/**
 * <#注释#>
 */
//@property (nonatomic, strong) NSNumber *login;
/**
 * 0 普通用户  1 管理员,,可以不付费下载
 */
@property (nonatomic, copy) NSString *superior;


//+(void)removeSharedBAUserInfo;


+(void)saveSharedUserInfo;

-(void)saveSharedUserInfo;

+(void)removeSharedUserInfo;

+(instancetype )getSaveSharedUserInfo;

@end
