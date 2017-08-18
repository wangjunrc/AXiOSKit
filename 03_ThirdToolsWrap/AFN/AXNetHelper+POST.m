//
//  AXNetHelper+POST.m
//  BigApple
//
//  Created by Mole Developer on 2017/6/9.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "AXNetHelper+POST.h"
#import "AXToolsHeader.h"
@implementation AXNetHelper (POST)
/**
 * post请求
 */
+ (void)POSTWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure{
    
    [self POSTWithUrl:url showHUD:NO parameters:parameters success:success failure:failure];
}
/**
 * post请求
 */
+ (void)POSTWithUrl:(NSString *)url showHUD:(BOOL )showHud parameters:(NSDictionary *)parameters  success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure{
    
    MBProgressHUD *hud = nil;
    if (showHud) {
        hud = [MBProgressHUD showMessage:AXNetLoadTitle];
    }
    
    _dataTask = [[self createSessionManager] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        if (showHud) {
            [hud hideAnimated:YES];
        }
        
        if (success) {
            success([self handleResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
//        NSHTTPURLResponse *httpRe = (NSHTTPURLResponse*)task.response;
//        AXLog(@"statusCode:%ld  %@",httpRe.statusCode,error);
        
        if (showHud) {
            [hud hideAnimated:YES];
            [MBProgressHUD showError:error.localizedDescription];
        }
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
  
    
}


@end
