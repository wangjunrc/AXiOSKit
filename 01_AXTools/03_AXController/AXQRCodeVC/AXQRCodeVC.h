//
//  AXQRCodeVC.h
//  AXTools
//
//  Created by Mole Developer on 16/6/12.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXQRCodeVC : UIViewController

-(void)successQRCode:(void(^)(NSString *code))code;

@end
