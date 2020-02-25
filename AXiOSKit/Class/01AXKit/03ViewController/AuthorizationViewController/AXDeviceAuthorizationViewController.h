//
//  AXDeviceAuthorizationViewController.h
//  AXiOSKit
//
//  Created by AXing on 2019/7/13.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXViewController.h"
#import "AXDeviceFunctionDisableViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface AXDeviceAuthorizationViewController : AXViewController

-(instancetype)initWithType:(AXDeviceFunctionType )type
                disableType:(AXDeviceFunctionDisableType )disableType;

@end

NS_ASSUME_NONNULL_END
