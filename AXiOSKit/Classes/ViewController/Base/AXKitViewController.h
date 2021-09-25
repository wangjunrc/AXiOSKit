//
//  MyViewController.h
//  AXiOSKit
//
//  Created by liuweixing on 16/5/26.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXNavigationController.h"

@interface AXKitViewController : UIViewController

+(AXNavigationController *)navigationVC;
/**
 * <#注释#>
 */
@property (nonatomic, assign)BOOL showDisItem;

@end
