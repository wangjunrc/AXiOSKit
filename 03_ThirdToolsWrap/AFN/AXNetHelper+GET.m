//
//  AXNetHelper+GET.m
//  BigApple
//
//  Created by Mole Developer on 2017/6/9.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "AXNetHelper+GET.h"

@implementation AXNetHelper (GET)
/**
 *GET请求
 */
+ (void)GETWithUrl:(NSString *)url parameters:(NSDictionary *)paramas success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure{
    
    [[self createSessionManager] GET:url parameters:paramas progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        
        if (success) {
            success([self handleResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

@end
