//
//  AXObject.h
//  BigApple
//
//  Created by Mole Developer on 2016/12/5.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXObject : NSObject

+(void)debug:(void(^)())bebug release:(void(^)())release;

+(void)ax_configure;

@end
