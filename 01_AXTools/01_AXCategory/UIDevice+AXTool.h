//
//  UIDevice+AXTool.h
//  AXTools
//
//  Created by Mole Developer on 16/9/13.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  enum{
    iPhone4,    //0
    iPhone5,    // 1 //5.5s.5c屏幕一致
    iPhone6,    //2
    iPhone6Plus,//3
    UnKnown     //4
}iPhoneModel;

@interface UIDevice (AXTool)

+ (iPhoneModel)ax_getiPhoneSize;

/**
 * 手机型号
 */
+ (NSString *)ax_devicePlatForm;
@end
