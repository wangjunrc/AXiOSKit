//
//  AXiOSKit.h
//  AXiOSKit
//  https://github.com/AXinger/AXiOSKit.git
//
//  Created by AXing on 2017/4/30.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for AXiOSKit.
FOUNDATION_EXPORT double AXiOSKitVersionNumber;

//! Project version string for AXiOSKit.
FOUNDATION_EXPORT const unsigned char AXiOSKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AXiOSKit/PublicHeader.h>
//#import "AXiOSFoundation.h"

#import "AXUIAssistant.h"
#import "UIBarButtonItem+AXKit.h"
#import "UIButton+AXCountDown.h"
#import "UIButton+AXKit.h"
#import "UICollectionView+AXKit.h"
#import "UIColor+AXKit.h"
#import "UIControl+AXKit.h"
#import "UIDevice+AXKit.h"
#import "UIImage+AXKit.h"
#import "UIImageView+AXKit.h"
#import "UILabel+AXKit.h"
#import "UINavigationController+AXKit.h"
#import "UIScrollView+AXEmptyDataSet.h"
#import "UIScrollView+AXKit.h"
#import "UISlider+AXKit.h"
#import "UISwitch+AXKit.h"
#import "UITableView+AXKit.h"
#import "UITextField+AXKit.h"
#import "UITextView+AXKit.h"
#import "UITextView+AXAction.h"
#import "UIView+AXAnimation.h"
#import "UIView+AXFrame.h"
#import "UIView+AXIBInspectable.h"
#import "UIView+AXSnapshot.h"
#import "UIView+AXKit.h"
#import "UIViewController+AXAlert.h"
#import "UIViewController+AXiPadAlert.h"
#import "UIViewController+AXKit.h"
#import "UITextField+AXAction.h"
#import "UIWindow+AXKit.h"
#import "UIView+AXSheet.h"
#import "IBObjectHeader.h"
#import "AXFoundationAssistant.h"
#import "AXViewController.h"
#import "AXBaseAlertVC.h"
#import "AXQRCodeVC.h"
#import "AXSinglePickVC.h"
#import "AXPlayVC.h"
#import "AXWebVC.h"
#import "AXWKWebVC.h"
#import "AXFullLayout.h"
#import "AXDateVC.h"
#import "AXVeriCodeView.h"
#import "QRCodeViewController.h"
#import "WKWebViewController.h"
#import "AXTableViewController.h"
#import "AXSafariVC.h"
#import "AXMacros.h"
#import "AXGCDTimer.h"
#import "AXWeakProxy.h"
#import "AXLocationManager.h"
#import "AXTouchIDManager.h"
#import "AXUIAssistant.h"
//读取本framework图片资料
#import "UIImage+AXBundle.h"
/* 02ThirdTools */
#pragma mark - 02ThirdTools
#import "UIScrollView+AXRefresh.h"
#import "AXNetManager.h"
#import "MBProgressHUD+AX.h"
#import "NSObject+AXCacheImage.h"
#import "AXNetManager.h"
#import "NSBundle+AXBundle.h"

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#elif __has_include("Masonry.h")
#import "Masonry.h"
#endif

#if __has_include(<IQKeyboardManager/IQKeyboardManager.h>)
#import <IQKeyboardManager/IQKeyboardManager.h>
#elif __has_include("IQKeyboardManager.h")
#import "IQKeyboardManager.h"
#endif

#if __has_include("MBProgressHUD.h")
#import "MBProgressHUD.h"
#endif

#if __has_include("UIImageView+WebCache.h")
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIImage+GIF.h"
#endif


