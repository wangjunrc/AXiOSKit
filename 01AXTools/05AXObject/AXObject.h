//
//  AXObject.h
//  BigApple
//
//  Created by liuweixing on 2016/12/5.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXToolsHeader.h"

@interface AXObject : NSObject

+(void)debug:(void(^)(void))bebug release:(void(^)(void))release;

+(void)ax_configure;

+(void)iPad:(void(^)(void))bebug iPhone:(void(^)(void))release;


@end
