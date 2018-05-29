//
//  NSObject+Version.m
//  AXTools
//
//  Created by liuweixing on 16/3/29.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSObject+Version.h"
#import "NSString+AXTool.h"

#define AX_APPVERSION_SAVE_KEY @"ax_AppVersion_save_key"

@implementation NSObject (Version)


/**
 当前版本号,与本地保存的版本号是否一致

 @param different 不一样回调
 @param same 一样回调
 */
-(void)ax_versionDifferent:(void(^)(NSString *appVersion, NSString *saveVersion))different same:(void(^)(NSString *appVersion, NSString *saveVersion))same{
    
    NSString *appVersion = [NSString ax_getAppVersion];
    
    NSString *saveVersion =  [[axUserDefaults objectForKey:AX_APPVERSION_SAVE_KEY] description];
    
    AXLog(@"appVersion>> %@  %@",appVersion,saveVersion);
    
    if (![appVersion isEqualToString:saveVersion]) {
        
        if (different) {
            [axUserDefaults setObject:appVersion forKey:AX_APPVERSION_SAVE_KEY];
            axUserDefaultsSynchronize;
            different(appVersion,saveVersion);
        }
        
    }else{
        if (same) {
             [axUserDefaults setObject:appVersion forKey:AX_APPVERSION_SAVE_KEY];
             axUserDefaultsSynchronize;
            same(appVersion,saveVersion);
        }
    }
    
}


@end
