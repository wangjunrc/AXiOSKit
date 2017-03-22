//
//  UIViewController+AXTool.m
//  AXTools
//
//  Created by Mole Developer on 16/6/15.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "UIViewController+AXTool.h"
#import "UIViewController+AXAlert.h"

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

- (void)setPageIndex:(NSInteger)pageIndex{
    objc_setAssociatedObject(self, @selector(pageIndex),@(pageIndex), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)pageIndex{
    return [objc_getAssociatedObject(self,@selector(pageIndex))integerValue];

}



/**
 * backBlock set
 */
- (void)setBackBlock:(AXBackBlock)backBlock{
    objc_setAssociatedObject(self, @selector(backBlock),backBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/**
 * backBlock get
 */
- (AXBackBlock)backBlock{
    return objc_getAssociatedObject(self,@selector(backBlock));
    
}

/**
 * 回调
 */
-(void)ax_backObjBlock:(void(^)(id obj))backBlock{
    self.backBlock = backBlock;
}

/**
 * BackBlockDict set and  get
 */
- (void)setAx_backBlockDict:(AXBackBlockDict)ax_backBlockDict{
    objc_setAssociatedObject(self, @selector(ax_backBlockDict),ax_backBlockDict, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (AXBackBlockDict)ax_backBlockDict{
    return objc_getAssociatedObject(self,@selector(ax_backBlockDict));
}

/**
 * 回调一个字典
 */
-(void)ax_backDictBlock:(void(^)(NSDictionary *dict))backBlock{
    self.ax_backBlockDict = backBlock;
}


- (void)setAx_popVC:(UIViewController *)ax_popVC{
   
    objc_setAssociatedObject(self, @selector(ax_popVC),ax_popVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIViewController *)ax_popVC{
    return objc_getAssociatedObject(self,@selector(ax_popVC));
}

@end
