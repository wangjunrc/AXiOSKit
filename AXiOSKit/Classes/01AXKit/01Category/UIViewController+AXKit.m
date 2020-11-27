//
//  UIViewController+AXKit.m
//  AXiOSKit
//
//  Created by liuweixing on 16/6/15.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UIViewController+AXKit.h"
#import "UIViewController+AXAlert.h"
#import <Photos/Photos.h>
#import "NSObject+AXVersion.h"
#import "NSString+AXKit.h"
#import <objc/runtime.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface UIViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>


/**
 * <#注释#>
 */
@property (nonatomic, strong) UIViewController *ax_popVC;


@property (nonatomic, strong) AXAlertTransitioningObserver *alertObserver;
@end



@implementation UIViewController (AXKit)

/**
 * 保存图片到系统相册
 */
- (void)ax_saveImageToPhotos:(UIImage*)image {
    // 这个方法不会吊起隐私权限,所以会crash
    //    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    //    //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
    
    // Asynchronously 异步执行操作
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSString *msg = nil ;
        if (success) {
            msg = @"保存图片成功" ;
        }else{
            msg = @"保存图片失败";
            if (error.code == 2047) {
                msg = @"不允许访问照片,请在iPhone中设置";
            }
        }
        
        [self ax_showAlertByTitle:msg];
    }];
}

/**
 * 保存图片到系统相册
 */
- (void)ax_saveImageToLibrary:(UIImage*)image {
    // 1.先保存图片到【相机胶卷】
    /// 同步执行修改操作
    NSError *error = nil;
    __block PHObjectPlaceholder *placeholder = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        placeholder =  [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
    } error:&error];

    if (error) {
        AXLoger(@"保存失败");
        return;
    }
    // 2.拥有一个【自定义相册】
    PHAssetCollection * assetCollection = [self AXPHAssetCollection];
    // 3.将刚才保存到【相机胶卷】里面的图片引用到【自定义相册】
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        PHAssetCollectionChangeRequest *requtes = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        [requtes addAssets:@[placeholder]];
    } error:&error];

    if (error) {
        AXLoger(@"保存图片失败");
         [self ax_showAlertByTitle:@"保存图片失败"];
    } else {
        AXLoger(@"保存图片成功");
         [self ax_showAlertByTitle:@"保存图片成功"];
    }
}

/**
 * 保存图片到系统相册
 */
//- (void)ax_saveImageToLibrary:(UIImage*)image {
//
//    //保存图片
//    __block NSString *assetId = nil;
//    // 1. 存储图片到"相机胶卷"
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        // 新建一个PHAssetCreationRequest对象
//        // 返回PHAsset(图片)的字符串标识
//        assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        // 2. 获得相册对象
//        PHAssetCollection *collection = [self getCollection];
//        // 3. 将“相机胶卷”中的图片添加到新的相册
//        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
////            NSLog(@"%@", [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil]);
//            // 根据唯一标示获得相片对象
//            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
//            // 添加图片到相册中
//            [request addAssets:@[asset]];
//        } completionHandler:^(BOOL success, NSError * _Nullable error) {
//            NSLog(@"成功保存到相簿：%@", collection.localizedTitle);
//        }];
//    }];
//}

- (PHAssetCollection *)AXPHAssetCollection {
    // 先获得之前创建过的相册
    
    NSString *appName =  [NSString ax_getAppName];
    
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:appName]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:appName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}

//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [self ax_showAlertByTitle:msg];
}

/**
 * 导航栏 push 到vc
 */
- (void)ax_navigationControllerPush:(Class)aClass block:(void(^)(id vc))blockVC{
    id vc = [[aClass alloc]init];
    if (blockVC) {
        blockVC((id)vc);
    }
    [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
    
}

/**
 * 当前控制器是否在显示,也可以直接使用
 */
- (BOOL)ax_isViewShow{
    return (self.isViewLoaded && self.view.window);
}

/**
 * 当前控制器
 */
+(UIViewController *)ax_currentViewController {
    UIViewController *resultVC = [self ax_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self ax_topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

//多次循环遍历
+ (UIViewController *)ax_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self ax_topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self ax_topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

/**
 * 是否有navigationController
 */
- (void)ax_haveNavigationController:(void(^)(UINavigationController *nav))have noHave:(void(^)(void))noHave{
    
    if (self.navigationController) {
        
        if (have) {
            have(self.navigationController);
        }
    }else {
        if (noHave) {
            noHave();
        }
    }
    
    
    
}


/**
 是否有 navigationController
 @param haveNav 有导航栏,包含被 push present
 @param isPush 被push自带nav
 @param presentNav 被present自带
 @param noneNav 没有
 */
- (void)ax_haveNav:(void(^)(UINavigationController *nav))haveNav isPushNav:(void(^)(UINavigationController *nav))isPush isPresentNav:(void(^)(UINavigationController *nav))presentNav noneNav:(void(^)(void))noneNav {
    
    if (!self.navigationController) {//没有导航
        if (noneNav) {
            noneNav();
        }
        
    }else {
        
        if (haveNav) {
            haveNav(self.navigationController);
        }
        
        //被present
        if ([self.navigationController.viewControllers.firstObject isEqual:self]){
            
            if (presentNav) {
                presentNav(self.navigationController);
            }
        }else{
            
            if (isPush) {
                isPush(self.navigationController);
            }
        }
        
    }
    
}


/**
 是否有 navigationController
 
 @param haveNav 被push和present自带nav
 @param presentNav 被present自带
 @param noHave 没有
 */
- (void)ax_havNav:(void(^)(UINavigationController *nav))haveNav isPresentNav:(void(^)(UINavigationController *nav))presentNav noHave:(void(^)(void))noHave{
    
    if (!self.navigationController) {//有导航
        if (noHave) {
            noHave();
        }
        
    }else {
        
        if ([self.navigationController.viewControllers.firstObject isEqual:self]){
            //被present 自带导航
            if (presentNav) {
                presentNav(self.navigationController);
            }
        }else{
            
            if (haveNav) {
                haveNav(self.navigationController);
            }
        }
        
    }
    
}


/**
 设置tabBarItem 属性,区分图片
 
 @param title title
 @param imageName imageName
 @param selectImageName selectImageName
 */
- (void)ax_setTabBarWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectImageName{
    
    self.tabBarItem.title = title;
    
    self.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if (selectImageName) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        self.tabBarItem.selectedImage = [UIImage imageNamed:imageName] ;
    }
    
    
}

/**
 设置tabBarItem 属性 不区分图片色,使用tabBar颜色渲染
 
 @param title title
 @param imageName imageName
 */
- (void)ax_tabBarWithTitle:(NSString *)title imageName:(NSString *)imageName{
    
    self.tabBarItem.title = title;
    self.tabBarItem.image = [UIImage imageNamed:imageName];
    
}



#pragma mark - set and get


- (void)setAx_popVC:(UIViewController *)ax_popVC{
    
    objc_setAssociatedObject(self, @selector(ax_popVC),ax_popVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIViewController *)ax_popVC{
    return objc_getAssociatedObject(self,@selector(ax_popVC));
}


- (void)ax_popoverWithContentSize:(CGSize )contentSize sourceView:(UIView *)sourceView orItem:(UIBarButtonItem *)item{
    
    self.modalPresentationStyle = UIModalPresentationPopover;
    self.popoverPresentationController.delegate = self;
    self.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    self.preferredContentSize = contentSize;
    
    if (sourceView) {
        
        self.popoverPresentationController.sourceView = sourceView;
        self.popoverPresentationController.sourceRect = sourceView.bounds;
        
    }else if (item)  {
        
        self.popoverPresentationController.barButtonItem = item;
    }else{
        NSAssert(0, @"必须有sourceView或者item");
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    
    return UIModalPresentationNone;
}



/**
 AppleStore 更新
 
 @param AppleStoreID AppleStoreID
 */
- (void)ax_AppStoreUpdateWithAppleStoreID:(NSString *)AppleStoreID{
    
    [self ax_versionProjectCompareAppStoreWithAppid:AppleStoreID comparisonResult:^(NSString *projectVersion, NSString *appStoreVersion, NSComparisonResult comparisonResult) {
        
        
        if (comparisonResult == NSOrderedAscending) {
            
            NSString *title = [NSString stringWithFormat:@"发现新版本: %@",appStoreVersion];
            [self ax_showAlertByTitle:title message:@"是否更新?" confirm:^{
                
                ax_OpenURLStr(ax_AppStoreURL(AppleStoreID));
                
            } cancel:^{
                
            }];
        }
    }];
    
}

/**
 跳转 App Store 评价页面
 
 @param AppleStoreID AppleStoreID
 */
- (void)ax_AppStoreScoreWithAppleStoreID:(NSString *)AppleStoreID{
    
    
    [self ax_showAlertByTitle:@"我们需要您的鼓励" message:@"是否去鼓励?" confirm:^{
        
        ax_OpenURLStr(ax_AppStoreScoreURL(AppleStoreID));
        
    } cancel:^{
        
    }];
}

/**
 封装 presentViewController
 
 @param aVC vc
 */
- (void)ax_showVC:(UIViewController *)aVC{
    if (@available(iOS 13.0, *)) {
        if (aVC.modalPresentationStyle == UIModalPresentationAutomatic || aVC.modalPresentationStyle == UIModalPresentationPageSheet) {
            aVC.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    [self presentViewController:aVC animated:YES completion:nil];
}

/**
 封装 presentViewController
 
 @param aVC vc
 */
- (void)ax_showVCClass:(Class )aClass {
    
    if ( [aClass isSubclassOfClass:UIViewController.class]) {
        UIViewController *vc = ( UIViewController *)[[aClass alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}


/**
 封装 pushViewController
 
 @param aVC vc
 */
- (void)ax_pushVC:(UIViewController *)aVC {
    
    [self.navigationController pushViewController:aVC animated:YES];
}

//# pragma mark - 隐藏导航栏

//- (BOOL)ax_shouldNavigationBarHidden{
//    return [objc_getAssociatedObject(self, @selector(ax_shouldNavigationBarHidden)) boolValue];
//}
//
//- (void)setAx_shouldNavigationBarHidden:(BOOL)ax_shouldNavigationBarHidden {
//
//    if (ax_shouldNavigationBarHidden) {
//        // 设置导航控制器的代理为self
//        self.navigationController.delegate = self;
//        // 必须设置,不然返回手势失效
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
//    objc_setAssociatedObject(self, @selector(ax_shouldNavigationBarHidden), @(ax_shouldNavigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
//}
//
///// UINavigationControllerDelegate
////将要显示控制器
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//}

-(void)setAXListener:(AXViewControllerListener *)AXListener {
    ax_setStrongPropertyAssociated(AXListener);
}

- (AXViewControllerListener*)AXListener{
    AXViewControllerListener *obj = ax_getValueAssociated(AXListener);
    if (!obj){
        obj = [[AXViewControllerListener alloc] initWithObserve:self];
        self.AXListener = obj;
    }
    return obj;
}

- (AXAlertTransitioningObserver *)alertObserver {
    return ax_getValueAssociated(alertObserver);
    
}
- (void)setAlertObserver:(AXAlertTransitioningObserver *)alertObserver {
    ax_setStrongPropertyAssociated(alertObserver);
}

-(void)ax_alertObserver:(void(^)(AXAlertTransitioningObserver *observer))handler {
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.alertObserver = [[AXAlertTransitioningObserver alloc] init];
    if(handler){
        handler(self.alertObserver);
    }
    self.transitioningDelegate = self.alertObserver;
    __weak typeof(self) weakSelf = self;
    
    if ([self respondsToSelector:@selector(viewDidLoad)]) {
        [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id  _Nullable x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.view.backgroundColor = UIColor.clearColor;
        }];
    }
   
    
}
@end
