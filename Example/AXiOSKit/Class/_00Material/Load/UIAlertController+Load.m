//
//  UIAlertController+Load.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/13.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "UIAlertController+Load.h"
@import AXiOSKit;

@import ReactiveObjC;

@implementation UIAlertController (Load)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /// 这个方式,是 UIAlertController init 后改变颜色, 后续使用再改变颜色,以使用颜色为主
        [UIAlertController ax_replaceClassMethodWithOriginal:@selector(alertControllerWithTitle:message:preferredStyle:) newSelector:@selector(ax_alertControllerWithTitle:message:preferredStyle:)];
        
        [UIAlertController ax_replaceInstanceMethodWithOriginal:@selector(addAction:) newSelector:@selector(ax_addAction:)];
        
    });
}


-(void)ax_addAction:(UIAlertAction *)action{
    [self ax_addAction:action];
}

+ (UIAlertController *)ax_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UIAlertController *alert =  [self ax_alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (alert.title.length) {
        //修改title字体及颜色
        NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:alert.title];
        [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, titleStr.string.length)];
        [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, titleStr.string.length)];
        [alert setValue:titleStr forKey:@"attributedTitle"];
    }
    if(alert.message.length){
        // 修改message字体及颜色
        NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:alert.message];
        [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor purpleColor] range:NSMakeRange(0, messageStr.string.length)];
        [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.string.length)];
        [alert setValue:messageStr forKey:@"attributedMessage"];
        
        
        
    
    }
    return alert;
    
}





@end
