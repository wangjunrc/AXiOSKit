//
//  NSObject+Load.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/20.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "NSObject+Load.h"
#import <Aspects/Aspects.h>
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/NSBundle+AXBundle.h>
#import <AXiOSKit/NSObject+AXRuntime.h>

@implementation NSObject (Load)

+ (void)load {
    
    [UIAlertController ax_replaceClassMethodWithOriginal:@selector(alertControllerWithTitle: message:preferredStyle:) newSelector:@selector(ax_alertControllerWithTitle:message:preferredStyle:)];
    
    [UIAlertController ax_replaceInstanceMethodWithOriginal:@selector(addAction:) newSelector:@selector(ax_addAction:)];
    
}


-(void)ax_addAction:(UIAlertAction *)action{
    [action setValue:UIColor.orangeColor forKey:@"_titleTextColor"];
    [self ax_addAction:action];
}

+ (UIAlertController *)ax_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UIAlertController *alertController =  [self ax_alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (title.length) {
        //修改title字体及颜色
        NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, titleStr.length)];
        [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, titleStr.length)];
        [alertController setValue:titleStr forKey:@"attributedTitle"];
    }
    if(message.length){
        // 修改message字体及颜色
        NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor greenColor] range:NSMakeRange(0, messageStr.length)];
        [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.length)];
        [alertController setValue:messageStr forKey:@"attributedMessage"];
    }
    return alertController;
    
}

@end
