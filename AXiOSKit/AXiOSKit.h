//
//  AXiOSKit.h
//  AXiOSKit
//
//  Created by AXing on 2019/4/30.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for AXiOSKit.
FOUNDATION_EXPORT double AXiOSKitVersionNumber;

//! Project version string for AXiOSKit.
FOUNDATION_EXPORT const unsigned char AXiOSKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AXiOSKit/PublicHeader.h>

#import "AXMacros.h"
#import "CALayer+AXFrame.h"
#import "NSArray+AXTool.h"
#import "NSData+AXTool.h"
#import "NSDate+AXTool.h"
#import "NSDateComponents+AXTool.h"
#import "NSNumber+AXTool.h"
#import "NSObject+AXKVO.h"
#import "NSObject+AXTool.h"
#import "NSObject+AXVersion.h"
#import "NSString+AXCrypto.h"
#import "NSString+AXDate.h"
#import "NSString+AXEffective.h"
#import "NSString+AXNet.h"
#import "NSString+AXTool.h"
#import "NSURL+AXTool.h"
#import "NSUserDefaults+AXTool.h"
#import "UIBarButtonItem+AXTool.h"
#import "UIButton+AXCountDown.h"
#import "UIButton+AXTool.h"
#import "UICollectionView+AXTool.h"
#import "UIColor+AXTool.h"
#import "UIControl+AXTool.h"
#import "UIDevice+AXTool.h"
#import "UIImage+AXTool.h"
#import "UIImageView+AXTool.h"
#import "UILabel+AXTool.h"
#import "UINavigationController+AXTool.h"
#import "UIScrollView+AXEmptyDataSet.h"
#import "UIScrollView+AXTool.h"
#import "UISlider+AXTool.h"
#import "UISwitch+AXTool.h"
#import "UITableView+AXTool.h"
#import "UITextField+AXTool.h"
#import "UITextView+AXTool.h"
#import "UIView+AXAnimation.h"
#import "UIView+AXFrame.h"
#import "UIView+AXIBInspectable.h"
#import "UIView+AXSnapshot.h"
#import "UIView+AXTool.h"
#import "UIViewController+AXAlert.h"
#import "UIViewController+AXiPadAlert.h"
#import "UIViewController+AXTool.h"
#import "UITextField+AXAction.h"
#import "UIWindow+AXTool.h"
#import "UIView+AXSheet.h"
#import "NSError+AXTool.h"
#import "IBObjectHeader.h"
#import "AXExternFunction.h"
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
#import "AXObject.h"
#import "AXHelper.h"
#import "QRCodeViewController.h"
#import "WKWebViewController.h"
#import "AXTableViewController.h"
#import "AXSafariVC.h"
#import "AXMacros.h"
#import "AXGCDTimer.h"
#import "AXSetValueProtocol.h"
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
#import "NSObject+FBKVOControllerAX.h"
#import "MBProgressHUD+AX.h"
#import "NSObject+AXCacheImage.h"
#import "AXNetManager.h"
#import "NSBundle+AXBundle.h"

#if __has_include("Masonry.h")
#import <Masonry/Masonry.h>
#endif

#if __has_include("IQKeyboardManager.h")
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

#if __has_include("MJExtension.h")
#import "MJExtension.h"
#endif
