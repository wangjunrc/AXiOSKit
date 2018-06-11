//
//  NSObject+AXVersion.m
//  AXTools
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSObject+AXVersion.h"
#import "NSString+AXTool.h"

#define AX_APPVERSION_SAVE_KEY @"ax_AppVersion_save_key"

@implementation NSObject (AXVersion)

/**
 请求AppStore,得到app的版本信息
 
 @param appid appid description
 @param block 得到app的版本信息
 */
-(void )ax_requestAppStoreVersionAppid:(NSString *)appid success:(void(^)(NSString *appVersion))block{
    
    if (block) {
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        
//        request.HTTPMethod = @"POST";
        
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
            
            AXLog(@"appid dict>> %@",dict);
            
            if ([dict[@"resultCount"] boolValue]) {
                
                block(dict[@"results"][0][@"version"]);
            }else{
                NSString *loc = [NSString ax_getAppVersion];
                block(loc);
            }
        }];
        
        [task resume];
        
    }
}


/**
 工程版本号与AppStore版本号对比
 
 @param appid appid
 @param block 0>相同 1,2,3>顺序的版本不同
 */
-(void)ax_versionToServerVersionByAppid:(NSString *)appid success:(void(^)(NSInteger comp))block {
    
    if (block) {
        
        [self ax_requestAppStoreVersionAppid:appid success:^(NSString *appVersion) {
            
            NSString *loc = [NSString ax_getAppVersion];
            NSString *ser = appVersion;
            
            if ([loc isEqualToString:ser]) {
                block(0);
                return ;
            }
            
            
            
            NSArray *locArray = [loc componentsSeparatedByString:@"."];
            NSArray *serArray = [ser componentsSeparatedByString:@"."];
            
            for (int index=0; index<3; index++) {
                if (![locArray[index] isEqualToString:serArray[index]]) {
                    block(index+1);
                    break;
                }
            }
        }];
        
    }
}

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



/**
 工程版本号 与App Store中版本号比较
 
 @param appid appid
 @param resultBlock 回调
 */
-(void)ax_versionProjectCompareAppStoreWithAppid:(NSString *)appid comparisonResult:(void(^)(NSString *projectVersion , NSString *appStoreVersion,NSComparisonResult comparisonResult))resultBlock {
    
    if (resultBlock) {
        
        [self ax_requestAppStoreVersionAppid:appid success:^(NSString *appVersion) {
            
            NSString *projectVersion = [NSString ax_getAppVersion];
            NSString *appStoreVersion = appVersion;
            
            resultBlock(projectVersion,appStoreVersion,[projectVersion compare:appStoreVersion]);
            
        }];
        
    }
}


@end
