//
//  UIViewController+Load.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/7/3.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "UIViewController+Load.h"
#import <Aspects/Aspects.h>

#import <AXiOSKit/AXiOSKit.h>

@implementation UIViewController (Load)

// UIViewController+AOP类中：
+ (void)load {
    
    NSError *error;
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
       UIViewController *vc = aspectInfo.instance;
         NSLog(@"拦截====1 %@",vc);
        
        
    } error:&error];
    if (error) NSLog(@"%@", error);
}
 


@end
