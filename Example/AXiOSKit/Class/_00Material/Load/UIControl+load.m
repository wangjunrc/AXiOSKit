//
//  UIControl+load.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/10.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "UIControl+load.h"
#import <Aspects/Aspects.h>
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/NSBundle+AXBundle.h>
#import <AXiOSKit/NSObject+AXRuntime.h>
@implementation UIControl (load)

//NSDictionary *dict;

+ (void)load {
    
//    NSError *error;
//    [UIControl aspect_hookSelector:@selector(sendAction:to:forEvent:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//        id obj = aspectInfo.instance;
//
//        if (dict == nil) {
//             NSLog(@"dict == nil");
//             dict = [NSBundle.mainBundle ax_dictionaryForResource:@"PointViewController2.plist"];
//        }
//        if ([dict.allKeys containsObject:NSStringFromClass(vc.class)]) {
//
//            NSLog(@"dict: %@",dict);
//        }
//
//
//
//
//    } error:&error];
//    if (error) NSLog(@"%@", error);
    
//    [UIControl ax_replaceInstanceMethodWithOriginal:@selector(sendAction:to:forEvent:) newSelector:@selector(user_sendAction:to:forEvent:)];
}

-(void)user_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
//    NSLog(@"\n***hook success.\n[1]action:%@\n[2]target:%@ \n[3]event:%ld", NSStringFromSelector(action), target, (long)event);
    
    NSLog(@"user_sendAction %@",NSStringFromSelector(action));
    NSLog(@"target %@",target);
    NSLog(@"event %@",event);
    
    [self user_sendAction:action to:target forEvent:event];
}


@end
