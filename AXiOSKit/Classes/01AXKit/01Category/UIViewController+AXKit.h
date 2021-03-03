//
//  UIViewController+AXKit.h
//  AXiOSKit
//
//  Created by liuweixing on 16/6/15.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXConstant.h"
#import "AXMacros.h"
#import "AXViewControllerObserve.h"
#import "AXAlertTransitioningObserver.h"

@class PHAssetCollection;

@interface UIViewController (AXKit)<UIPopoverPresentationControllerDelegate>

/**
 * 保存图片到系统相册
 */
- (void)ax_saveImageToPhotos:(UIImage *)image;

/**
 * 保存图片到自定义相册
 */
- (void)ax_saveImageToLibrary:(UIImage *)image;

/**
 * 导航栏 push 到vc
 */
- (void)ax_navigationControllerPush:(Class)aClass
                              block:(void (^)(id vc))blockVC;

/**
 * 当前控制器是否在显示,也可以直接使用
 */
- (BOOL)ax_isViewShow;

/**
 * 当前控制器
 */
+ (UIViewController *)ax_currentViewController;

/**
 是否有 navigationController

 @param haveNav 被push和present自带nav
 @param presentNav 被present自带
 @param noHave 没有
 */
- (void)ax_havNav:(void (^)(UINavigationController *nav))haveNav
     isPresentNav:(void (^)(UINavigationController *nav))presentNav
           noHave:(void (^)(void)) noHave DEPRECATED_MSG_ATTRIBUTE("请使用 - (void)ax_haveNav:(void(^)(UINavigationController *nav))haveNav isPushNav:(void(^)(UINavigationController *nav))isPush isPresentNav:(void(^)(UINavigationController *nav))presentNav noneNav:(void(^)(void))noneNav");
/**
 是否有 navigationController
 @param haveNav 有导航栏,包含被 push present
 @param isPush 被push自带nav
 @param presentNav 被present自带
 @param noneNav 没有
 */
- (void)ax_haveNav:(void (^)(UINavigationController *nav))haveNav
         isPushNav:(void (^)(UINavigationController *nav))isPush
      isPresentNav:(void (^)(UINavigationController *nav))presentNav
           noneNav:(void (^)(void))noneNav;

/**
 设置tabBarItem 属性

 @param title title
 @param imageName imageName
 @param selectImageName selectImageName
 */
- (void)ax_setTabBarWithTitle:(NSString *)title
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectImageName;

/**
 设置tabBarItem 属性 不区分图片色,使用tabBar颜色

 @param title title
 @param imageName imageName descriptionimageName
 */
- (void)ax_tabBarWithTitle:(NSString *)title
                 imageName:(NSString *)imageName;

/**
 iOS8.0开始推荐使用UIPopoverPresentationController，用于替代UIPopoverController iPhone和iPad 都可以使用

 @param contentSize CGSize
 @param sourceView UIView
 @param item UIBarButtonItem
 */
- (void)ax_popoverWithContentSize:(CGSize)contentSize
                       sourceView:(UIView *)sourceView
                           orItem:(UIBarButtonItem *)item;

/**
 AppleStore 更新

 @param AppleStoreID AppleStoreID
 */
- (void)ax_AppStoreUpdateWithAppleStoreID:(NSString *)AppleStoreID;

/**
 跳转 App Store 评价页面

 @param AppleStoreID AppleStoreID
 */
- (void)ax_AppStoreScoreWithAppleStoreID:(NSString *)AppleStoreID;

/**
 封装 presentViewController

 @param aVC vc
 */
- (void)ax_showVC:(UIViewController *)aVC;

/**
 封装 presentViewController

 @param aClass vc
 */
- (void)ax_showVCClass:(Class)aClass;

/**
 封装 pushViewController

 @param aVC vc
 */
- (void)ax_pushVC:(UIViewController *)aVC;

///// 是否隐藏导航栏。默认NO。
//@property (nonatomic, assign) BOOL ax_shouldNavigationBarHidden;

@property (nonatomic, strong, readonly)PHAssetCollection *AXPHAssetCollection;

@property (nonatomic, strong, readonly) AXViewControllerObserve *ax_controllerObserve;



/// 自定义alert样式, 主要view背景色不能自行添加颜色,必须保持透明
/**
 - (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
     if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
         [self ax_alertObserver:^(AXAlertTransitioningObserver *observer) {
             observer.alertControllerStyle = AXAlertControllerStyleCentre;
         }];
     }
     return self;
 }
 /// 调用者自控制是否点击空白页面 消失
 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [self dismissViewControllerAnimated:YES completion:nil];
 }
 */
/// @param handler 参数回调
-(void)ax_alertObserver:(void(^)(AXAlertTransitioningObserver *observer))handler;

@end
