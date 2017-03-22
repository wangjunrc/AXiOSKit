//
//  AXObject.m
//  BigApple
//
//  Created by Mole Developer on 2016/12/5.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "AXObject.h"

@implementation AXObject

+(void)debug:(void(^)())bebug release:(void(^)())release{
    
#ifdef DEBUG
    if (bebug) {
        bebug();
    }
#else
    if (release) {
        release();
    }
#endif

}

+(void)ax_configure{
    [self setupAppearance];
    [self setupIQKeyboardManager];
}

/**
 * appearance
 */
+(void)setupAppearance{
    
    //    [UITextField appearance].clearsOnBeginEditing = YES;
    [UITextField appearance].clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //    [UILabel appearance].textAlignment = NSTextAlignmentCenter;
}

/**
 * 键盘
 */
+(void)setupIQKeyboardManager{
    //拖入工程即生效,这里只是做一下设置
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //控制整个功能是否启用
    manager.enable = YES;
    //控制整个功能是否启用
    manager.shouldResignOnTouchOutside = YES;
    //控制键盘上的工具条文字颜色是否用户自定义
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //控制是否显示键盘上的工具条
    manager.enableAutoToolbar = NO;
}



@end
