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
#import <AXiOSKit/NSBundle+AXBundle.h>
@implementation UIViewController (Load)

// UIViewController+AOP类中：
NSDictionary *dict;

+ (void)load {
    
    NSError *error;
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc = aspectInfo.instance;
//        NSLog(@"拦截====1 %@",vc);
        
//        NSArray<NSDictionary*> *array = [NSBundle.mainBundle ax_arrayForResource:@"PointViewController.plist"];
//        NSLog(@"array: %@",array[0].allValues);
        if (dict == nil) {
             NSLog(@"dict == nil");
             dict = [NSBundle.mainBundle ax_dictionaryForResource:@"PointViewController2.plist"];
        }
        if ([dict.allKeys containsObject:NSStringFromClass(vc.class)]) {
            
            NSLog(@"dict: %@",dict);
        }
        
        
        
        
    } error:&error];
    if (error) NSLog(@"%@", error);
}


@end
