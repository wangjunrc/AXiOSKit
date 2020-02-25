//
//  AXDeviceFunctionDisableViewController.h
//  AXiOSKit
//
//  Created by AXing on 2019/7/13.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AXDeviceFunctionType) {
    AXDeviceFunctionTypeCamera,
    AXDeviceFunctionTypeAlbumRead,
    AXDeviceFunctionTypeAlbumWrite,
};

typedef NS_ENUM(NSUInteger, AXDeviceFunctionDisableType) {
    /// 设备不支持
    AXDeviceFunctionDisableTypeNotSupport,
    /// 设置未授权
    AXDeviceFunctionDisableTypeNotAuthorize
};

@interface AXDeviceFunctionDisableViewController : UINavigationController

-(instancetype)initWithType:(AXDeviceFunctionType )type
                disableType:(AXDeviceFunctionDisableType )disableType;

@end

NS_ASSUME_NONNULL_END
