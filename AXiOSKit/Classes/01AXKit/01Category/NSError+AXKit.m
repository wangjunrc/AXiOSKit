//
//  NSError+AXKit.m
//  AXiOSKit
//
//  Created by AXing on 2019/2/28.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "NSError+AXKit.h"

@implementation NSError (AXKit)

+(instancetype)ax_errorWithDescription:(NSString *)description {
    
    NSDictionary *userInfo = @{
                                NSLocalizedDescriptionKey:description,
                                };
  return [[NSError alloc] initWithDomain:@"com.ax.error" code:-1 userInfo:userInfo];
    
}
@end
