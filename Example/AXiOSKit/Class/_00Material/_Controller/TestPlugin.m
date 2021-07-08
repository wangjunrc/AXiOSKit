//
//  TestPlugin.m
//  DoraemonKitDemo
//
//  Created by yixiang on 2017/12/11.
//  Copyright © 2017年 yixiang. All rights reserved.
//

#import "TestPlugin.h"
#import "TestPluginViewController.h"
#import <DoraemonKit/DoraemonHomeWindow.h>
@implementation TestPlugin

- (void)pluginDidLoad{
    NSLog(@"TestPlugin pluginDidLoad");
    
    TestPluginViewController *vc = [[TestPluginViewController alloc] init];
    [DoraemonHomeWindow openPlugin:vc];
    
}

- (void)pluginDidLoad:(NSDictionary *)itemData{
    NSLog(@"TestPlugin pluginDidLoad:itemData = %@",itemData);
}

@end
