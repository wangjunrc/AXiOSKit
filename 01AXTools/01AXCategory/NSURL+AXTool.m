//
//  NSURL+AXTool.m
//  AXTools
//
//  Created by Mole Developer on 16/6/17.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "NSURL+AXTool.h"

@implementation NSURL (AXTool)
+(NSURL *)ax_URLByPhone:(NSString *)phone{
    return [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
}


@end
