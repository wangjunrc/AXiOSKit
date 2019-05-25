//
//  NSURL+AXKit.m
//  AXiOSKit
//
//  Created by liuweixing on 16/6/17.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSURL+AXKit.h"

@implementation NSURL (AXKit)

+(NSURL *)ax_URLByPhone:(NSString *)phone{
    return [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
}


@end
