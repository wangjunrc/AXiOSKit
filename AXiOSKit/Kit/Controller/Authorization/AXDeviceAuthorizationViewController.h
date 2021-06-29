//
//  AXDeviceAuthorizationViewController.h
//  AXiOSKit
//
//  Created by axing on 2019/7/13.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXKitViewController.h"
#import "AXDeviceFunctionDisableViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface AXDeviceAuthorizationViewController : AXKitViewController

-(instancetype)initWithType:(AXDeviceFunctionType )type
                disableType:(AXDeviceFunctionDisableType )disableType;

@end

NS_ASSUME_NONNULL_END
