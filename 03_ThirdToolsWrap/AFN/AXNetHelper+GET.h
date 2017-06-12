//
//  AXNetHelper+GET.h
//  BigApple
//
//  Created by Mole Developer on 2017/6/9.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "AXNetHelper.h"

@interface AXNetHelper (GET)

/**
 * GET请求
 */
+ (void)GETWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

@end
