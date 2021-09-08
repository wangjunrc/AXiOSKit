//
//  AXDemoUser.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/6/4.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXDemoUser.h"

@implementation AXDemoUser
AX_SINGLETON_IMPL(User)
AX_CANCEL_SINGLETON_IMPL
+(void)testSub {
    NSLog(@"testSub=%@",self);
}
@end
