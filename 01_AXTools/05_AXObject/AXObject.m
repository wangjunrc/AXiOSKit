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

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
+(void)iPad:(void(^)())iPad iPhone:(void(^)())iPhone{

    if( IS_IPAD ){
        if (iPad) {
            iPad();
        }

    }else{
        if (iPhone) {
            iPhone();
        }
        
    }
    
}






+(void)ax_configure{
    [self func_viewAppearance];
    [self func_IQKeyboardManager];
}

/**
 * appearance
 */
+(void)func_viewAppearance{
    
    //    [UITextField appearance].clearsOnBeginEditing = YES;
    [UITextField appearance].clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //    [UILabel appearance].textAlignment = NSTextAlignmentCenter;
    
    
    // UIView有个属性叫做exclusiveTouch，设置为YES后，其响应事件会和其他view互斥(有其他view事件响应的时候点击它不起作用)
    [[UITableViewCell appearance] setExclusiveTouch:YES];
}

/**
 * 键盘
 */
+(void)func_IQKeyboardManager{
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
