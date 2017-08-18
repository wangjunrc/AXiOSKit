//
//  AXNetHelper+POST.h
//  BigApple
//
//  Created by Mole Developer on 2017/6/9.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "AXNetHelper.h"
#import "AXToolsHeader.h"
@interface AXNetHelper (POST)

/**
 * post请求
 */
+ (void)POSTWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure;

/**
 * post请求,含有hud
 */
+ (void)POSTWithUrl:(NSString *)url showHUD:(BOOL )showHud parameters:(NSDictionary *)parameters success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure;

@end
