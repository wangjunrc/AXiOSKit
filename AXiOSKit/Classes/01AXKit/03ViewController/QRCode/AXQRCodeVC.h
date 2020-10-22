//
//  AXQRCodeVC.h
//  AXiOSKit
//
//  Created by liuweixing on 16/6/12.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXQRCodeVC : UIViewController

@property (nonatomic, copy) void(^qrCodeBlock)(NSError *error,NSString *qrCode);

@end
