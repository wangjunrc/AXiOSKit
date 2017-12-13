//
//  AXToolsHeader.h
//  Xile
//
//  Created by Mole Developer on 2017/3/22.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#ifndef AXToolsHeader_h
#define AXToolsHeader_h

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/*
 
 分类重写set get 方法说明
 
 OBJC_ASSOCIATION_ASSIGN;            //assign策略
 OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
 OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
 
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

/* 01_AXTools */
#pragma mark - 01_AXTools

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


/* 02_ThirdTools */
#pragma mark - 02_ThirdTools

#import "Masonry.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "IQKeyboardManager.h"
#import "UINavigationController+TZPopGesture.h"
/**多选照片*/
#import "TZImagePickerController.h"
#import "JDFSequentialTooltipManager.h"
#import "UITextView+WZB.h"
#import "UIImage+GIF.h"

/* 03_ThirdToolsWrap */
#pragma mark - 03_ThirdToolsWrap

#import "UIScrollView+AXRefresh.h"

#import "AXNetManager.h"
/* 04_ThirdSDK */
#pragma mark - 04_ThirdSDK




#endif /* AXToolsHeader_h */
