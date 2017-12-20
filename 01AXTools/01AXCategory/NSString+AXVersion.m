//
//  NSString+AXVersion.m
//  AXTools
//
//  Created by Mole Developer on 16/7/13.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "NSString+AXVersion.h"
#import "AXToolsHeader.h"
@implementation NSString (AXVersion)


+(void )ax_appStoreVersionAppid:(NSString *)appid success:(void(^)(NSString *appVersion))block{
    
    if (block) {
        
//        NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid];
//        
//       [NetWokHelper POSTWithUrl:url parameters:nil success:^(id json) {
//           
//           if ([json[@"resultCount"] boolValue]) {
//               block(json[@"results"][0][@"version"]);
//           }else{
//                NSString *loc = [NSString getAppVersion];
//                block(loc);
//           }
//           
//       } failure:^(NSString *errorString) {
//           NSString *loc = [NSString getAppVersion];
//           block(loc);
//       }];
           
  }
}


+(void)ax_versionToServerVersionByAppid:(NSString *)appid success:(void(^)(NSInteger comp))block {
    
    if (block) {
        
   
        [self ax_appStoreVersionAppid:appid success:^(NSString *appVersion) {
            
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



@end
