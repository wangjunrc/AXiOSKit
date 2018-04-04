//
//  AXToolsHeader.h
//  Xile
//
//  Created by liuweixing on 2017/3/22.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#ifndef AXToolsHeader_h
#define AXToolsHeader_h

/*
 
 分类重写set get 方法说明
 
 OBJC_ASSOCIATION_ASSIGN;            //assign策略
 OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
 OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain strong 策略
 
 OBJC_ASSOCIATION_RETAIN;
 OBJC_ASSOCIATION_COPY;
 */
/*
 * id object 给哪个对象的属性赋值
 const void *key 属性对应的key
 id value  设置属性值为value
 objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
 */

/* 01AXTools */
#pragma mark - 01AXTools
#import "IBObjectHeader.h"
#import "AXNetManager.h"
#import "AXConstant.h"
#import "AXViewController.h"
#import "AXBaseAlertVC.h"
#import "AXQRCodeVC.h"
#import "AXSinglePickVC.h"
#import "AXPlayVC.h"
#import "AXWebVC.h"
#import "AXWKWebVC.h"
#import "AXObject.h"
#import "QRCodeViewController.h"
#import "WKWebViewController.h"
#import "AXTableViewController.h"
#import "AXSafariVC.h"
#import "AXConstant.h"
#import "AXMacros.h"
#import "AXFullLayout.h"
#import "AXViewModel.h"
#import "UIView+AXFrame.h"
#import "CALayer+AXFrame.h"
#import "UIButton+AXTool.h"
#import "UILabel+AXTool.h"
#import "NSString+AXTool.h"
#import "NSString+AXEffective.h"
#import "UIImage+AXTool.h"
#import "UIImageView+AXTool.h"
#import "UIBarButtonItem+AXTool.h"
#import "UIView+AXTool.h"
#import "NSDate+AXTool.h"
#import "NSObject+AXTool.h"
#import "NSString+AXVersion.h"
#import "UIColor+AXTool.h"
#import "UIViewController+AXTool.h"
#import "NSURL+AXTool.h"
#import "NSData+AXTool.h"
#import "UITableView+AXTool.h"
#import "UIDevice+AXTool.h"
#import "UIView+AXAnimation.h"
#import "UIViewController+AXAlert.h"
#import "NSObject+AXKVO.h"
#import "UICollectionView+AXTool.h"
#import "NSString+AXNet.h"
#import "UIScrollView+AXTool.h"
#import "NSString+AXCrypto.h"
#import "UIButton+AXTool.h"
#import "UISlider+AXTool.h"
#import "UITextField+AXTool.h"
#import "NSString+AXDate.h"
#import "UINavigationController+AXTool.h"
#import "UISwitch+AXTool.h"
#import "NSDateComponents+AXTool.h"
#import "UIScrollView+AXEmptyDataSet.h"
#import "NSArray+AXCatch.h"
#import "NSMutableArray+AXCatch.h"
#import "NSDictionary+AXCatch.h"
#import "NSMutableDictionary+AXCatch.h"
#import "UIButton+AXCountDown.h"
#import "UIViewController+AXiPadAlert.h"
#import "UIViewController+BackButtonHandler.h"
#import "NSUserDefaults+AXTool.h"
#import "NSNumber+AXTool.h"

/* 02ThirdTools */
#pragma mark - 02ThirdTools
#import "MBProgressHUD+AX.h"
#import "MBProgressHUD.h"

/* 03ThirdToolsWrap */
#pragma mark - 03ThirdToolsWrap
#import "UIScrollView+AXRefresh.h"
#import "AXNetManager.h"
#import "NSObject+FBKVOControllerAX.h"

/* 04ThirdSDK */
#pragma mark - 04ThirdSDK


/* 05Pod */
#pragma mark - 05Pod
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "IQKeyboardManager.h"
#import "UINavigationController+TZPopGesture.h"

/**多选照片*/
#import "TZImagePickerController.h"

/*气泡提示*/
//#import "JDFSequentialTooltipManager.h"
#import "UITextView+WZB.h"
#import "UIImage+GIF.h"

#endif /* AXToolsHeader_h */
