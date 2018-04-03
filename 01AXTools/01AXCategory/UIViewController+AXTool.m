//
//  UIViewController+AXTool.m
//  AXTools
//
//  Created by Mole Developer on 16/6/15.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "UIViewController+AXTool.h"
#import "UIViewController+AXAlert.h"

@interface UIViewController ()


/**
 * <#注释#>
 */
@property (nonatomic, strong)UIViewController  *ax_popVC;


@end



@implementation UIViewController (AXTool)

/**
 * 保存图片到系统相册
 */
- (void)ax_saveImageToPhotos:(UIImage*)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
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
-(void)ax_navigationControllerPush:(Class)aClass block:(void(^)(id vc))blockVC{
    id vc = [[aClass alloc]init];
    if (blockVC) {
        blockVC((id)vc);
    }
    [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
    
}

/**
 * 当前控制器是否在显示,也可以直接使用
 */
-(BOOL)ax_isViewShow{
    return (self.isViewLoaded && self.view.window);
}

/**
 * 当前控制器
 */
+(UIViewController *)ax_currentViewController {
    UIViewController *resultVC;
    resultVC = [self ax_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
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
-(void)ax_haveNavigationController:(void(^)(UINavigationController *nav))have noHave:(void(^)(void))noHave{

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

 @param haveNav 被push和present自带nav
 @param presentNav 被present自带
 @param noHave 没有
 */
-(void)ax_havNav:(void(^)(UINavigationController *nav))haveNav isPresentNav:(void(^)(UINavigationController *nav))presentNav noHave:(void(^)(void))noHave{
    
    if (!self.navigationController) {//有导航
        if (noHave) {
            noHave();
        }
        
    }else {
        
        if (haveNav) {
            haveNav(self.navigationController);
        }
        
        if ([self.navigationController.viewControllers.firstObject isEqual:self]){
            //被present 自带导航
            if (presentNav) {
                presentNav(self.navigationController);
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
-(void)ax_setTabBarWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectImageName{
    
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
 @param selectImageName selectImageName
 */
-(void)ax_tabBarWithTitle:(NSString *)title imageName:(NSString *)imageName{
    
    self.tabBarItem.title = title;
    self.tabBarItem.image = [UIImage imageNamed:imageName];
    
}



#pragma mark - set and get

- (void)setPageIndex:(NSInteger)pageIndex{
    ax_runtimePropertyAssSet(pageIndex);
}

- (NSInteger)pageIndex{
    return [ax_runtimePropertyAssGet(pageIndex)integerValue];

}


/**
 * 回调
 */
-(void)ax_backObjBlock:(void(^)(id obj))backBlock{
    self.backBlock = backBlock;
}

/**
 * backBlock set
 */
- (void)setBackBlock:(BackBlock)backBlock{
    objc_setAssociatedObject(self, @selector(backBlock),backBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/**
 * backBlock get
 */
- (BackBlock)backBlock{
    return objc_getAssociatedObject(self,@selector(backBlock));
}

- (void)setAx_popVC:(UIViewController *)ax_popVC{
   
    objc_setAssociatedObject(self, @selector(ax_popVC),ax_popVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIViewController *)ax_popVC{
    return objc_getAssociatedObject(self,@selector(ax_popVC));
}


-(void)ax_popoverWithContentSize:(CGSize )contentSize sourceView:(UIView  *)sourceView orItem:(UIBarButtonItem  *)item{
    
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

@end